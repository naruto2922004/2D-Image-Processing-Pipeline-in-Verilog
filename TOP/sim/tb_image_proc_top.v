`timescale 1ns/1ps
// tb_image_proc_top.v  –  System-level testbench: FFT → IMG_PROC → IFFT
//
// Flow:
//   1. Python script generates fft_input.txt (noisy image pixels)
//   2. This testbench feeds pixels into the FFT row by row
//   3. IMG_PROC filter is applied in-flight (pipelined, no buffering)
//   4. IFFT reconstructs and writes ifft_output.txt (R I pairs)
//   5. Python script reads ifft_output.txt and saves the filtered PNG
//
module tb_image_proc_top;

    // ── Parameters ────────────────────────────────────────────────────────────
    parameter TWIDDLE_MAX_STAGES = 10;
    parameter MAX_ROW_STAGES     = 10;   
    parameter MAX_COL_STAGES     = 10;   
    parameter INPUT_STAGE_WIDTH  = 4;
    parameter BUTTERFLY_FACTOR   = 6;   
    parameter TWIDDLE_WIDTH      = 16;
    parameter FRAC_BITS          = 15;
    parameter PIXEL_WIDTH        = 16;
    parameter FREQ_WIDTH         = PIXEL_WIDTH + MAX_COL_STAGES + MAX_ROW_STAGES; 
    parameter OUTPUT_WIDTH       = 16;
    parameter GAUSS_ADDR_WIDTH   = 20;   // ceil(log2(GAUSS_ROM_DEPTH))
    parameter GAUSS_ROM_DEPTH    = 524289;  // (total row/2)^2 + (total column/2)^2 + 1 

    // ── Runtime image dimensions ──────────────────────────────────────────────
    parameter ROW_STAGE = 8;   // 256 rows
    parameter COL_STAGE = 8;   // 256 cols
    localparam NUM_ROWS = 1 << ROW_STAGE;
    localparam NUM_COLS = 1 << COL_STAGE;

    // ── Filter settings: ─────────────────
    // mode: 3'b000=LPF, 3'b001=HPF, 3'b010=Gaussian_LPF, 3'b011=Gaussian_HPF, 3'b100=Passthrough
    parameter [2:0] FILTER_MODE  = 3'b011; 
    parameter [MAX_COL_STAGES-1:0] CUTOFF = 25;

    reg  clk, rst_n;
    reg  fft_data_valid;
    reg  signed [PIXEL_WIDTH-1:0]   fft_pixel_in;
    wire [MAX_ROW_STAGES-1:0]       fft_row_in;
    wire fft_in_ready;

    reg  ifft_read_next, ifft_read_done;
    wire ifft_out_ready, ifft_empty, ifft_done;
    wire [MAX_ROW_STAGES-1:0]       ifft_row_out;
    wire signed [OUTPUT_WIDTH-1:0]  ifft_pixel_out_R, ifft_pixel_out_I;

    image_proc_top #(
        .TWIDDLE_MAX_STAGES(TWIDDLE_MAX_STAGES),
        .MAX_ROW_STAGES(MAX_ROW_STAGES),
        .MAX_COL_STAGES(MAX_COL_STAGES),
        .INPUT_STAGE_WIDTH(INPUT_STAGE_WIDTH),
        .BUTTERFLY_FACTOR(BUTTERFLY_FACTOR),
        .TWIDDLE_WIDTH(TWIDDLE_WIDTH),
        .FRAC_BITS(FRAC_BITS),
        .PIXEL_WIDTH(PIXEL_WIDTH),
        .FREQ_WIDTH(FREQ_WIDTH),
        .OUTPUT_WIDTH(OUTPUT_WIDTH),
        .GAUSS_ADDR_WIDTH(GAUSS_ADDR_WIDTH),
        .GAUSS_ROM_DEPTH(GAUSS_ROM_DEPTH)
    ) dut (
        .clk(clk), .rst_n(rst_n),
        .row_stage(ROW_STAGE[INPUT_STAGE_WIDTH-1:0]),
        .col_stage(COL_STAGE[INPUT_STAGE_WIDTH-1:0]),
        .filter_mode(FILTER_MODE),
        .cutoff(CUTOFF),
        .fft_data_valid(fft_data_valid),
        .fft_pixel_in(fft_pixel_in),
        .fft_row_in(fft_row_in),
        .fft_in_ready(fft_in_ready),
        .ifft_read_next(ifft_read_next),
        .ifft_read_done(ifft_read_done),
        .ifft_out_ready(ifft_out_ready),
        .ifft_empty(ifft_empty),
        .ifft_done(ifft_done),
        .ifft_row_out(ifft_row_out),
        .ifft_pixel_out_R(ifft_pixel_out_R),
        .ifft_pixel_out_I(ifft_pixel_out_I)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    reg signed [PIXEL_WIDTH-1:0] image [0:NUM_ROWS*NUM_COLS-1];
    integer i, r, c;
    integer f_in, f_out;

    initial begin

        f_in = $fopen("TOP/sim/fft_input.txt", "r");
        if (!f_in) f_in = $fopen("sim/fft_input.txt", "r");
        if (!f_in) begin
            $display("ERROR: fft_input.txt not found.");
            $finish;
        end
        for (i = 0; i < NUM_ROWS * NUM_COLS; i = i + 1) begin
            if ($fscanf(f_in, "%h\n", image[i]) != 1) begin
                $display("ERROR reading sample %0d from fft_input.txt", i); $finish;
            end
        end
        $fclose(f_in);
        $display("Loaded %0d samples from sim/fft_input.txt", NUM_ROWS*NUM_COLS);

        rst_n = 0; fft_data_valid = 0;
        ifft_read_next = 0; ifft_read_done = 0;
        repeat(3) @(posedge clk); #1;
        rst_n = 1;
        @(posedge clk); #1;

        for (r = 0; r < NUM_ROWS; r = r + 1) begin
            while (!fft_in_ready) begin @(posedge clk); #1; end
            for (c = 0; c < NUM_COLS; c = c + 1) begin
                fft_data_valid = 1;
                fft_pixel_in   = image[r * NUM_COLS + c];
                @(posedge clk); #1;
            end
            fft_data_valid = 0;
        end
        $display("All %0d image rows fed into FFT.", NUM_ROWS);

        while (!ifft_out_ready) begin @(posedge clk); #1; end
        $display("IFFT output ready. Reading reconstructed image...");

        f_out = $fopen("TOP/sim/ifft_output.txt", "w");
        if (!f_out) f_out = $fopen("sim/ifft_output.txt", "w");
        for (r = 0; r < NUM_ROWS; r = r + 1) begin
            for (c = 0; c < NUM_COLS; c = c + 1) begin
                $fdisplay(f_out, "%d %d", ifft_pixel_out_R, ifft_pixel_out_I);
                ifft_read_next = 1; @(posedge clk); #1;
                ifft_read_next = 0; @(posedge clk); #1;
            end
        end
        ifft_read_done = 1; @(posedge clk); #1;
        ifft_read_done = 0; @(posedge clk); #1;
        $fclose(f_out);
        $display("IFFT output written to sim/ifft_output.txt");
        $display("Run: python PYTHON/reconstruct_image.py TOP/sim/ifft_output.txt filtered.png --rows %0d --cols %0d", NUM_ROWS, NUM_COLS);
        $finish;
    end

    // Timeout guard
    initial begin
        #10000000;
        $display("TIMEOUT – simulation did not complete"); $finish;
    end
endmodule
