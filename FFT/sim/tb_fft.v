`timescale 1ns/1ps
module tb_fft;

    parameter TWIDDLE_MAX_STAGES = 10;
    parameter MAX_ROW_STAGES     = 4;
    parameter MAX_COL_STAGES     = 4;
    parameter INPUT_STAGE_WIDTH  = 4;
    parameter INPUT_DATA_WIDTH   = 16;
    parameter TWIDDLE_WIDTH      = 16;
    parameter FRAC_BITS          = 15;
    parameter BUTTERFLY_FACTOR   = 2;
    parameter OUTPUT_DATA_WIDTH  = INPUT_DATA_WIDTH + MAX_COL_STAGES + MAX_ROW_STAGES;

    parameter ROW_STAGE = 3;   // 8 rows
    parameter COL_STAGE = 3;   // 8 cols
    localparam NUM_ROWS = 1 << ROW_STAGE;
    localparam NUM_COLS = 1 << COL_STAGE;
    localparam TOTAL_SAMPLES = NUM_ROWS * NUM_COLS;

    reg clk, rst_n, data_valid, read_next, ifft_done;
    reg [INPUT_STAGE_WIDTH-1:0]  row_stage_in, col_stage_in;
    reg signed [INPUT_DATA_WIDTH-1:0] data_in;

    wire in_ready, out_ready, empty;
    wire [MAX_ROW_STAGES-1:0] row_in, row_out;
    wire [INPUT_STAGE_WIDTH-1:0] row_stage_out, col_stage_out;
    wire signed [OUTPUT_DATA_WIDTH-1:0] output_data_R, output_data_I;

    fft #(
        .TWIDDLE_MAX_STAGES(TWIDDLE_MAX_STAGES),
        .MAX_ROW_STAGES(MAX_ROW_STAGES),
        .MAX_COL_STAGES(MAX_COL_STAGES),
        .INPUT_STAGE_WIDTH(INPUT_STAGE_WIDTH),
        .INPUT_DATA_WIDTH(INPUT_DATA_WIDTH),
        .TWIDDLE_WIDTH(TWIDDLE_WIDTH),
        .FRAC_BITS(FRAC_BITS),
        .BUTTERFLY_FACTOR(BUTTERFLY_FACTOR),
        .OUTPUT_DATA_WIDTH(OUTPUT_DATA_WIDTH)
    ) dut (
        .clk(clk), .rst_n(rst_n),
        .data_valid(data_valid),
        .row_stage(row_stage_in),
        .col_stage(col_stage_in),
        .data_in(data_in),
        .row_in(row_in),
        .in_ready(in_ready),
        .row_stage_out(row_stage_out),
        .col_stage_out(col_stage_out),
        .read_next(read_next),
        .ifft_done(ifft_done),
        .out_ready(out_ready),
        .empty(empty),
        .row_out(row_out),
        .output_data_R(output_data_R),
        .output_data_I(output_data_I)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    reg signed [INPUT_DATA_WIDTH-1:0] image [0:TOTAL_SAMPLES-1];
    integer r, c, f_in, f_out;

    initial begin
        f_in = $fopen("FFT/sim/input_samples.txt", "r");
        if (!f_in) begin
            $display("ERROR: cannot open input_samples.txt");
            $finish;
        end
        for (r = 0; r < TOTAL_SAMPLES; r = r + 1) begin
            if ($fscanf(f_in, "%d\n", image[r]) != 1) $finish;
        end
        $fclose(f_in);

        rst_n = 0; data_valid = 0; read_next = 0; ifft_done = 0;
        row_stage_in = ROW_STAGE; col_stage_in = COL_STAGE;
        repeat(3) @(posedge clk); #1;
        rst_n = 1;
        @(posedge clk); #1;

        for (r = 0; r < NUM_ROWS; r = r + 1) begin
            while (!in_ready) begin @(posedge clk); #1; end
            for (c = 0; c < NUM_COLS; c = c + 1) begin
                data_valid = 1;
                data_in    = image[r * NUM_COLS + c];
                @(posedge clk); #1;
            end
            data_valid = 0;
        end

        while (!out_ready) begin @(posedge clk); #1; end

        f_out = $fopen("FFT/sim/output_results.txt", "w");
        if (!f_out) f_out = $fopen("sim/output_results.txt", "w");
        for (r = 0; r < NUM_ROWS; r = r + 1) begin
            for (c = 0; c < NUM_COLS; c = c + 1) begin
                $fdisplay(f_out, "%d %d", output_data_R, output_data_I);
                read_next = 1; @(posedge clk); #1;
                read_next = 0; @(posedge clk); #1;
            end
        end
        ifft_done = 1; @(posedge clk); #1;
        ifft_done = 0; @(posedge clk); #1;
        $fclose(f_out);
        $display("2D FFT simulation complete.");
        $finish;
    end

    initial begin
        #2000000;
        $display("TIMEOUT"); $finish;
    end
endmodule
