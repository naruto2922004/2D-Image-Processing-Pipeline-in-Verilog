module ifft #(
    parameter TWIDDLE_MAX_STAGES  = 10,   // max{MAX_ROW_STAGES, MAX_COL_STAGES}
    parameter MAX_ROW_STAGES      = 10,    // log2(max image height)
    parameter MAX_COL_STAGES      = 10,    // log2(max image width)
    parameter INPUT_STAGE_WIDTH   = 4,    // max{log2(MAX_ROW_STAGES), log2(MAX_COL_STAGES)}
    parameter INPUT_DATA_WIDTH    = 36,   // FFT OUTPUT_DATA_WIDTH
    parameter TWIDDLE_WIDTH       = 16,
    parameter FRAC_BITS           = 15,
    parameter BUTTERFLY_FACTOR    = 6,    // log2(butterflies)
    parameter OUTPUT_DATA_WIDTH   = 16,   
    parameter INTERNAL_DATA_WIDTH = INPUT_DATA_WIDTH + MAX_COL_STAGES + MAX_ROW_STAGES
)(
    input  clk, rst_n,

    // ── Input interface  ──────────────────────────────
    input  data_valid,
    input  [INPUT_STAGE_WIDTH-1:0] row_stage,      
    input  [INPUT_STAGE_WIDTH-1:0] col_stage,       
    input  signed [INPUT_DATA_WIDTH-1:0] data_in_R,   
    input  signed [INPUT_DATA_WIDTH-1:0] data_in_I,   
    output reg [MAX_ROW_STAGES-1:0] row_in, 
    output in_ready,

    // ── Output interface ──────────────────────────────
    input  read_next,                                
    input  read_done,                                
    output out_ready,
    output reg empty,
    output reg ifft_done,                            
    output [MAX_ROW_STAGES-1:0] row_out,
    output signed [OUTPUT_DATA_WIDTH-1:0] output_data_R,
    output signed [OUTPUT_DATA_WIDTH-1:0] output_data_I
);

    reg [INPUT_STAGE_WIDTH-1:0] row_stage_buff, col_stage_buff;

    localparam MAX_ROWS = 1 << MAX_ROW_STAGES;
    localparam MAX_COLS = 1 << MAX_COL_STAGES;
    localparam TWD_POINTS = 1 << (TWIDDLE_MAX_STAGES - 1);
    localparam BUTTERFLIES = 1 << BUTTERFLY_FACTOR;
    localparam K_WIDTH = (MAX_COL_STAGES >= MAX_ROW_STAGES) ?
                              MAX_COL_STAGES : MAX_ROW_STAGES;
    localparam C_WIDTH = (K_WIDTH > BUTTERFLY_FACTOR) ?
                              (K_WIDTH - BUTTERFLY_FACTOR) : 1;

    reg signed [INTERNAL_DATA_WIDTH-1:0] RAM_R [0:MAX_ROWS-1][0:MAX_COLS-1];
    reg signed [INTERNAL_DATA_WIDTH-1:0] RAM_I [0:MAX_ROWS-1][0:MAX_COLS-1];

    // fft twiddle rom reuse with negative imaginary part
    wire [TWIDDLE_WIDTH*TWD_POINTS-1:0] tw_real, tw_imag;
    fft_twiddle_rom tw_rom (
        .tw_real(tw_real), 
        .tw_imag(tw_imag)
    );

    wire signed [TWIDDLE_WIDTH-1:0] tw_real_arr [0:TWD_POINTS-1];
    wire signed [TWIDDLE_WIDTH-1:0] tw_imag_arr [0:TWD_POINTS-1];
    wire signed [TWIDDLE_WIDTH-1:0] tw_imag_raw [0:TWD_POINTS-1];
    genvar gi;
    generate
        for (gi = 0; gi < TWD_POINTS; gi = gi + 1) begin : MAP_TWD
            assign tw_real_arr[gi] = tw_real[gi*TWIDDLE_WIDTH +: TWIDDLE_WIDTH];
            assign tw_imag_raw[gi] = tw_imag[gi*TWIDDLE_WIDTH +: TWIDDLE_WIDTH];
            assign tw_imag_arr[gi] = (tw_imag_raw[gi] == -16'sd32768) ? 16'sd32767 : -tw_imag_raw[gi];
        end
    endgenerate

    reg  signed [INTERNAL_DATA_WIDTH-1:0] IN_bus_A_R [0:BUTTERFLIES-1];
    reg  signed [INTERNAL_DATA_WIDTH-1:0] IN_bus_A_I [0:BUTTERFLIES-1];
    reg  signed [INTERNAL_DATA_WIDTH-1:0] IN_bus_B_R [0:BUTTERFLIES-1];
    reg  signed [INTERNAL_DATA_WIDTH-1:0] IN_bus_B_I [0:BUTTERFLIES-1];
    reg  signed [TWIDDLE_WIDTH-1:0] IN_bus_T_R [0:BUTTERFLIES-1];
    reg  signed [TWIDDLE_WIDTH-1:0] IN_bus_T_I [0:BUTTERFLIES-1];
    wire signed [INTERNAL_DATA_WIDTH-1:0] OUT_bus_A_R [0:BUTTERFLIES-1];
    wire signed [INTERNAL_DATA_WIDTH-1:0] OUT_bus_A_I [0:BUTTERFLIES-1];
    wire signed [INTERNAL_DATA_WIDTH-1:0] OUT_bus_B_R [0:BUTTERFLIES-1];
    wire signed [INTERNAL_DATA_WIDTH-1:0] OUT_bus_B_I [0:BUTTERFLIES-1];

    generate
        for (gi = 0; gi < BUTTERFLIES; gi = gi + 1) begin : GEN_BF
            ifft_butterfly #(
                .DATA_WIDTH(INTERNAL_DATA_WIDTH),
                .TWIDDLE_WIDTH(TWIDDLE_WIDTH),
                .FRAC_BITS(FRAC_BITS)
            ) BF (
                .IN_A_R(IN_bus_A_R[gi]), 
                .IN_A_I(IN_bus_A_I[gi]),
                .IN_B_R(IN_bus_B_R[gi]), 
                .IN_B_I(IN_bus_B_I[gi]),
                .T_R(IN_bus_T_R[gi]),    
                .T_I(IN_bus_T_I[gi]),
                .OUT_A_R(OUT_bus_A_R[gi]), 
                .OUT_A_I(OUT_bus_A_I[gi]),
                .OUT_B_R(OUT_bus_B_R[gi]), 
                .OUT_B_I(OUT_bus_B_I[gi])
            );
        end
    endgenerate

    reg [2:0] state;
    reg [INPUT_STAGE_WIDTH-1:0] stage;
    reg [C_WIDTH-1:0] cycle;
    reg [K_WIDTH-1:0] K [0:BUTTERFLIES-1];

    reg [MAX_ROW_STAGES-1:0] row_count;
    reg [MAX_COL_STAGES-1:0] col_count;    

    wire [C_WIDTH-1:0] c_state_col =
        (col_stage_buff <= BUTTERFLY_FACTOR + 1) ? {C_WIDTH{1'b0}} :
        ((1 << (col_stage_buff - BUTTERFLY_FACTOR - 1)) - 1'b1);
    wire [C_WIDTH-1:0] c_state_row =
        (row_stage_buff <= BUTTERFLY_FACTOR + 1) ? {C_WIDTH{1'b0}} :
        ((1 << (row_stage_buff - BUTTERFLY_FACTOR - 1)) - 1'b1);

    reg [MAX_ROW_STAGES-1:0] row_idx;  
    reg [MAX_COL_STAGES-1:0] col_idx;

    integer x, y;
    always @(*) begin
        for (x = 0; x < MAX_ROW_STAGES; x = x + 1) begin
            if (x < row_stage_buff && state == 3'd1)
                row_idx[x] = row_count[row_stage_buff - 1 - x];
            else
                row_idx[x] = 1'b0;
        end

        for (y = 0; y < MAX_COL_STAGES; y = y + 1) begin
            if (y < col_stage_buff && state == 3'd1)
                col_idx[y] = col_count[col_stage_buff - 1 - y];
            else
                col_idx[y] = 1'b0;
        end
    end

    reg [K_WIDTH-1:0] IN_A_idx [0:BUTTERFLIES-1];
    reg [K_WIDTH-1:0] IN_B_idx [0:BUTTERFLIES-1];
    reg [TWIDDLE_MAX_STAGES-2:0] IN_T_idx [0:BUTTERFLIES-1];

    integer a;
    always @(*) begin
        for (a = 0; a < BUTTERFLIES; a = a + 1) begin
            IN_A_idx[a] = ((K[a] >> stage) << (stage + 1)) | (K[a] & ((1 << stage) - 1));
            IN_B_idx[a] = IN_A_idx[a] | (1 << stage);
            IN_T_idx[a] = (K[a] & ((1 << stage) - 1)) << (TWIDDLE_MAX_STAGES - 1 - stage);
            IN_bus_T_R[a] = tw_real_arr[IN_T_idx[a]];
            IN_bus_T_I[a] = tw_imag_arr[IN_T_idx[a]];

            if (state == 3'd2) begin
                IN_bus_A_R[a] = RAM_R[row_count][IN_A_idx[a]];
                IN_bus_A_I[a] = RAM_I[row_count][IN_A_idx[a]];
                IN_bus_B_R[a] = RAM_R[row_count][IN_B_idx[a]];
                IN_bus_B_I[a] = RAM_I[row_count][IN_B_idx[a]];
            end 
            else if (state == 3'd3) begin
                IN_bus_A_R[a] = RAM_R[IN_A_idx[a]][col_count];
                IN_bus_A_I[a] = RAM_I[IN_A_idx[a]][col_count];
                IN_bus_B_R[a] = RAM_R[IN_B_idx[a]][col_count];
                IN_bus_B_I[a] = RAM_I[IN_B_idx[a]][col_count];
            end
            else begin
                IN_bus_A_R[a] = {INTERNAL_DATA_WIDTH{1'b0}};
                IN_bus_A_I[a] = {INTERNAL_DATA_WIDTH{1'b0}};
                IN_bus_B_R[a] = {INTERNAL_DATA_WIDTH{1'b0}};
                IN_bus_B_I[a] = {INTERNAL_DATA_WIDTH{1'b0}};
            end
        end
    end

    wire [MAX_ROW_STAGES-1:0] max_in_row = (1 << row_stage_buff) - 1'b1;
    wire [MAX_COL_STAGES-1:0] max_in_col = (1 << col_stage_buff) - 1'b1;

    wire [INPUT_STAGE_WIDTH:0] total_shift = row_stage_buff + col_stage_buff;

    wire signed [INTERNAL_DATA_WIDTH-1:0] round_offset =
        (total_shift > 0) ?
        ({{(INTERNAL_DATA_WIDTH-1){1'b0}}, 1'b1} << (total_shift - 1'b1)) :
        {INTERNAL_DATA_WIDTH{1'b0}};

    wire signed [INTERNAL_DATA_WIDTH-1:0] cur_R = RAM_R[row_count][col_count];
    wire signed [INTERNAL_DATA_WIDTH-1:0] cur_I = RAM_I[row_count][col_count];

    wire signed [INTERNAL_DATA_WIDTH-1:0] scaled_R =
        (total_shift > 0) ? ((cur_R + round_offset) >>> total_shift) : cur_R;
    wire signed [INTERNAL_DATA_WIDTH-1:0] scaled_I =
        (total_shift > 0) ? ((cur_I + round_offset) >>> total_shift) : cur_I;

    localparam signed [INTERNAL_DATA_WIDTH-1:0] MAX_VAL =
        {{(INTERNAL_DATA_WIDTH-OUTPUT_DATA_WIDTH+1){1'b0}}, {(OUTPUT_DATA_WIDTH-1){1'b1}}};
    localparam signed [INTERNAL_DATA_WIDTH-1:0] MIN_VAL =
        {{(INTERNAL_DATA_WIDTH-OUTPUT_DATA_WIDTH+1){1'b1}}, {(OUTPUT_DATA_WIDTH-1){1'b0}}};

    wire signed [OUTPUT_DATA_WIDTH-1:0] sat_R =
        (scaled_R > MAX_VAL) ? MAX_VAL[OUTPUT_DATA_WIDTH-1:0] :
        (scaled_R < MIN_VAL) ? MIN_VAL[OUTPUT_DATA_WIDTH-1:0] :
        scaled_R[OUTPUT_DATA_WIDTH-1:0];

    wire signed [OUTPUT_DATA_WIDTH-1:0] sat_I =
        (scaled_I > MAX_VAL) ? MAX_VAL[OUTPUT_DATA_WIDTH-1:0] :
        (scaled_I < MIN_VAL) ? MIN_VAL[OUTPUT_DATA_WIDTH-1:0] :
        scaled_I[OUTPUT_DATA_WIDTH-1:0];

    integer j;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= 3'd0; 
            stage <= 0; 
            cycle <= 0;
            row_count <= 0; 
            col_count <= 0; 
            empty <= 1'b0;
            ifft_done <= 1'b0;
            row_stage_buff <= 0;
            col_stage_buff <= 0;
            row_in <= 0;
            for (j = 0; j < BUTTERFLIES; j = j + 1) 
                K[j] <= j;
        end
        else begin
            ifft_done <= 1'b0;
            case (state)
                3'd0: begin
                    if (data_valid) begin
                        row_stage_buff <= row_stage;
                        col_stage_buff <= col_stage;
                        RAM_R[0][0] <= {{(INTERNAL_DATA_WIDTH-INPUT_DATA_WIDTH){data_in_R[INPUT_DATA_WIDTH-1]}}, data_in_R};
                        RAM_I[0][0] <= {{(INTERNAL_DATA_WIDTH-INPUT_DATA_WIDTH){data_in_I[INPUT_DATA_WIDTH-1]}}, data_in_I};
                        col_count <= 1'b1;
                        state <= 3'd1;
                    end
                end
                3'd1: begin
                    if (data_valid) begin
                        RAM_R[row_idx][col_idx] <= {{(INTERNAL_DATA_WIDTH-INPUT_DATA_WIDTH){data_in_R[INPUT_DATA_WIDTH-1]}}, data_in_R};
                        RAM_I[row_idx][col_idx] <= {{(INTERNAL_DATA_WIDTH-INPUT_DATA_WIDTH){data_in_I[INPUT_DATA_WIDTH-1]}}, data_in_I};
                        if (col_count == max_in_col) begin
                            col_count <= {MAX_COL_STAGES{1'b0}};
                            if (row_count == max_in_row) begin
                                state <= 3'd2;
                                row_count <= {MAX_ROW_STAGES{1'b0}};
                                row_in <= {MAX_ROW_STAGES{1'b0}};
                            end
                            else begin
                                row_count <= row_count + 1'b1;
                                row_in <= row_in + 1'b1;
                            end
                        end
                        else begin
                            col_count <= col_count + 1'b1;
                        end
                    end
                end
                3'd2: begin
                    for (j = 0; j < BUTTERFLIES; j = j + 1) begin
                        if (col_stage_buff != 0 && (K[j] < (1 << (col_stage_buff - 1)))) begin
                            RAM_R[row_count][IN_A_idx[j]] <= OUT_bus_A_R[j];
                            RAM_R[row_count][IN_B_idx[j]] <= OUT_bus_B_R[j];
                            
                            RAM_I[row_count][IN_A_idx[j]] <= OUT_bus_A_I[j];
                            RAM_I[row_count][IN_B_idx[j]] <= OUT_bus_B_I[j];
                        end
                    end
                    if (cycle < c_state_col) begin
                        cycle <= cycle + 1'b1;
                        for (j = 0; j < BUTTERFLIES; j = j + 1) begin
                            K[j] <= K[j] + BUTTERFLIES;
                        end
                    end
                    else begin
                        cycle <= {C_WIDTH{1'b0}};
                        for (j = 0; j < BUTTERFLIES; j = j + 1) begin
                            K[j] <= j;
                        end
                        if (stage < (col_stage_buff - 1)) begin
                            stage <= stage + 1'b1;
                        end
                        else begin
                            stage <= {INPUT_STAGE_WIDTH{1'b0}};
                            if (row_count < max_in_row)
                                row_count <= row_count + 1'b1;
                            else begin
                                row_count <= {MAX_ROW_STAGES{1'b0}};
                                state <= 3'd3;
                            end
                        end
                    end
                end
                3'd3: begin
                    for (j = 0; j < BUTTERFLIES; j = j + 1) begin
                        if (row_stage_buff != 0 && (K[j] < (1 << (row_stage_buff - 1)))) begin
                            RAM_R[IN_A_idx[j]][col_count] <= OUT_bus_A_R[j];
                            RAM_R[IN_B_idx[j]][col_count] <= OUT_bus_B_R[j];
                            
                            RAM_I[IN_A_idx[j]][col_count] <= OUT_bus_A_I[j];
                            RAM_I[IN_B_idx[j]][col_count] <= OUT_bus_B_I[j];
                        end
                    end
                    if (cycle < c_state_row) begin
                        cycle <= cycle + 1'b1;
                        for (j = 0; j < BUTTERFLIES; j = j + 1) begin
                            K[j] <= K[j] + BUTTERFLIES;
                        end
                    end
                    else begin
                        cycle <= {C_WIDTH{1'b0}};
                        for (j = 0; j < BUTTERFLIES; j = j + 1) begin
                            K[j] <= j;
                        end
                        if (stage < (row_stage_buff - 1)) begin
                            stage <= stage + 1'b1;
                        end
                        else begin
                            stage <= {INPUT_STAGE_WIDTH{1'b0}};
                            if (col_count < max_in_col)
                                col_count <= col_count + 1'b1;
                            else begin
                                col_count <= {MAX_COL_STAGES{1'b0}};
                                state <= 3'd4;
                            end
                        end
                    end
                end
                3'd4: begin
                    if (read_next && !empty) begin
                        if (col_count == max_in_col) begin
                            col_count <= {MAX_COL_STAGES{1'b0}};
                            if (row_count == max_in_row) begin
                                row_count <= {MAX_ROW_STAGES{1'b0}};
                                empty <= 1'b1;
                            end
                            else
                                row_count <= row_count + 1'b1;
                        end
                        else
                            col_count <= col_count + 1'b1;
                    end
                    else if (read_done) begin
                        col_count <= {MAX_COL_STAGES{1'b0}};
                        row_count <= {MAX_ROW_STAGES{1'b0}};
                        row_in    <= {MAX_ROW_STAGES{1'b0}};
                        state     <= 3'd0;
                        empty     <= 1'b0;
                        ifft_done <= 1'b1;
                    end
                end
                default: state <= 3'd0;
            endcase
        end
    end

    assign in_ready = (state == 3'd0) || (state == 3'd1);
    assign out_ready = (state == 3'd4) && !empty;
    assign output_data_R = (state == 3'd4) ? sat_R : {OUTPUT_DATA_WIDTH{1'b0}};
    assign output_data_I = (state == 3'd4) ? sat_I : {OUTPUT_DATA_WIDTH{1'b0}};
    assign row_out = (state == 3'd4) ? row_count : {MAX_ROW_STAGES{1'b0}};

endmodule