// Filter modes:
//   3'b000 – Ideal Low-Pass  
//   3'b001 – Ideal High-Pass
//   3'b010 – Gaussian Low-Pass 
//   3'b011 – Gaussian High-Pass
//   3'b100 – Passthrough
module img_proc #(
    parameter MAX_ROW_STAGES = 8,
    parameter MAX_COL_STAGES = 8,
    parameter INPUT_STAGE_WIDTH = 4,
    parameter DATA_WIDTH = 32,
    parameter FRAC_BITS = 15,
    parameter GAUSS_ADDR_WIDTH = 2*MAX_COL_STAGES,
    parameter GAUSS_ROM_DEPTH = 1 << GAUSS_ADDR_WIDTH
)(
    input clk, rst_n,
    input [INPUT_STAGE_WIDTH-1:0] row_stage, col_stage,
    input [2:0] mode,
    input [MAX_COL_STAGES-1:0] cutoff,

    input fft_out_ready, fft_empty,
    input [MAX_ROW_STAGES-1:0] fft_row_out,
    input signed [DATA_WIDTH-1:0] fft_data_R, fft_data_I,
    output read_next,

    input ifft_in_ready,
    output data_valid,
    output signed [DATA_WIDTH-1:0] proc_data_R, proc_data_I
);

    reg [MAX_COL_STAGES-1:0] k_count;
    wire advance = fft_out_ready && ifft_in_ready;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            k_count <= 0;
        else if (advance) begin
            if (k_count == (1 << col_stage) - 1)
                k_count <= 0;
            else
                k_count <= k_count + 1;
        end
    end

    wire [MAX_COL_STAGES:0] col_half = 1 << (col_stage - 1);
    wire [MAX_ROW_STAGES:0] row_half = 1 << (row_stage - 1);

    wire [MAX_COL_STAGES-1:0] u = (k_count >= col_half) ? (1 << col_stage) - k_count : k_count;
    wire [MAX_ROW_STAGES-1:0] v = (fft_row_out >= row_half) ? (1 << row_stage) - fft_row_out : fft_row_out;

    wire [2*MAX_COL_STAGES:0] d2 = u*u + v*v;

    wire [GAUSS_ADDR_WIDTH-1:0] addr = (d2[2*MAX_COL_STAGES : GAUSS_ADDR_WIDTH] != 0) ? {GAUSS_ADDR_WIDTH{1'b1}} : d2[GAUSS_ADDR_WIDTH-1:0];
    wire signed [15:0] H;

    gaussian_rom #(
        .ADDR_WIDTH(GAUSS_ADDR_WIDTH),
        .DEPTH(GAUSS_ROM_DEPTH)
    ) gauss_rom_inst (
        .addr(addr),
        .H(H)
    );

    wire signed [15:0] H_eff = (mode == 3'b011) ? (16'sd32767 - H) : H;

    wire signed [DATA_WIDTH+15:0] prod_R = H_eff * fft_data_R;
    wire signed [DATA_WIDTH+15:0] prod_I = H_eff * fft_data_I;
    wire signed [DATA_WIDTH-1:0] gauss_R = (prod_R + (1 << (FRAC_BITS-1))) >>> FRAC_BITS;
    wire signed [DATA_WIDTH-1:0] gauss_I = (prod_I + (1 << (FRAC_BITS-1))) >>> FRAC_BITS;

    reg keep;

    always @(*) begin
        case (mode)
            3'b000:  keep = (d2 <= cutoff*cutoff);
            3'b001:  keep = (d2 >  cutoff*cutoff);
            default: keep = 1'b1; 
        endcase
    end

    assign proc_data_R = (mode == 3'b010 || mode == 3'b011) ? gauss_R : keep ? fft_data_R : {DATA_WIDTH{1'b0}};
    assign proc_data_I = (mode == 3'b010 || mode == 3'b011) ? gauss_I : keep ? fft_data_I : {DATA_WIDTH{1'b0}};

    assign data_valid = fft_out_ready;
    assign read_next = advance && !fft_empty;

endmodule