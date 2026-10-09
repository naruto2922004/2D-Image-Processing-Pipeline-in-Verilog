module image_proc_top #(
    parameter TWIDDLE_MAX_STAGES  = 10,
    parameter MAX_ROW_STAGES      = 8,
    parameter MAX_COL_STAGES      = 8,
    parameter INPUT_STAGE_WIDTH   = 4,
    parameter BUTTERFLY_FACTOR    = 6,
    parameter TWIDDLE_WIDTH       = 16,
    parameter FRAC_BITS           = 15,
    parameter PIXEL_WIDTH         = 16,
    parameter FREQ_WIDTH          = PIXEL_WIDTH + MAX_COL_STAGES + MAX_ROW_STAGES,
    parameter OUTPUT_WIDTH        = 16,
    parameter GAUSS_ADDR_WIDTH    = 2*MAX_COL_STAGES,
    parameter GAUSS_ROM_DEPTH     = 1 << GAUSS_ADDR_WIDTH
)(
    input  clk, rst_n,

    input  [INPUT_STAGE_WIDTH-1:0] row_stage,
    input  [INPUT_STAGE_WIDTH-1:0] col_stage,
    input  [2:0]                   filter_mode,
    input  [MAX_COL_STAGES-1:0]    cutoff,

    input  fft_data_valid,
    input  signed [PIXEL_WIDTH-1:0] fft_pixel_in,
    output [MAX_ROW_STAGES-1:0]     fft_row_in,
    output fft_in_ready,

    input  ifft_read_next,
    input  ifft_read_done,
    output ifft_out_ready,
    output ifft_empty,
    output ifft_done,
    output [MAX_ROW_STAGES-1:0]      ifft_row_out,
    output signed [OUTPUT_WIDTH-1:0] ifft_pixel_out_R,
    output signed [OUTPUT_WIDTH-1:0] ifft_pixel_out_I
);

    wire [INPUT_STAGE_WIDTH-1:0] row_stage_buf, col_stage_buf;

    wire fft_out_ready;
    wire fft_empty;
    wire [MAX_ROW_STAGES-1:0]    fft_row_out;
    wire signed [FREQ_WIDTH-1:0] fft_data_R, fft_data_I;
    wire proc_read_next;

    wire proc_data_valid;
    wire signed [FREQ_WIDTH-1:0] proc_data_R, proc_data_I;
    wire ifft_in_ready;
    wire ifft_done_w;

    assign ifft_done = ifft_done_w;

    fft #(
        .TWIDDLE_MAX_STAGES(TWIDDLE_MAX_STAGES),
        .MAX_ROW_STAGES(MAX_ROW_STAGES),
        .MAX_COL_STAGES(MAX_COL_STAGES),
        .INPUT_STAGE_WIDTH(INPUT_STAGE_WIDTH),
        .INPUT_DATA_WIDTH(PIXEL_WIDTH),
        .TWIDDLE_WIDTH(TWIDDLE_WIDTH),
        .FRAC_BITS(FRAC_BITS),
        .BUTTERFLY_FACTOR(BUTTERFLY_FACTOR),
        .OUTPUT_DATA_WIDTH(FREQ_WIDTH)
    ) u_fft (
        .clk(clk), .rst_n(rst_n),
        .data_valid(fft_data_valid),
        .row_stage(row_stage),
        .col_stage(col_stage),
        .data_in(fft_pixel_in),
        .row_in(fft_row_in),
        .in_ready(fft_in_ready),
        .row_stage_out(row_stage_buf),
        .col_stage_out(col_stage_buf),
        .read_next(proc_read_next),
        .ifft_done(ifft_done_w),
        .out_ready(fft_out_ready),
        .empty(fft_empty),
        .row_out(fft_row_out),
        .output_data_R(fft_data_R),
        .output_data_I(fft_data_I)
    );

    img_proc #(
        .MAX_ROW_STAGES(MAX_ROW_STAGES),
        .MAX_COL_STAGES(MAX_COL_STAGES),
        .INPUT_STAGE_WIDTH(INPUT_STAGE_WIDTH),
        .DATA_WIDTH(FREQ_WIDTH),
        .FRAC_BITS(FRAC_BITS),
        .GAUSS_ADDR_WIDTH(GAUSS_ADDR_WIDTH),
        .GAUSS_ROM_DEPTH(GAUSS_ROM_DEPTH)
    ) u_proc (
        .clk(clk), .rst_n(rst_n),
        .row_stage(row_stage_buf),
        .col_stage(col_stage_buf),
        .mode(filter_mode),
        .cutoff(cutoff),
        .fft_out_ready(fft_out_ready),
        .fft_empty(fft_empty),
        .fft_row_out(fft_row_out),
        .fft_data_R(fft_data_R),
        .fft_data_I(fft_data_I),
        .read_next(proc_read_next),
        .ifft_in_ready(ifft_in_ready),
        .data_valid(proc_data_valid),
        .proc_data_R(proc_data_R),
        .proc_data_I(proc_data_I)
    );

    ifft #(
        .TWIDDLE_MAX_STAGES(TWIDDLE_MAX_STAGES),
        .MAX_ROW_STAGES(MAX_ROW_STAGES),
        .MAX_COL_STAGES(MAX_COL_STAGES),
        .INPUT_STAGE_WIDTH(INPUT_STAGE_WIDTH),
        .INPUT_DATA_WIDTH(FREQ_WIDTH),
        .TWIDDLE_WIDTH(TWIDDLE_WIDTH),
        .FRAC_BITS(FRAC_BITS),
        .BUTTERFLY_FACTOR(BUTTERFLY_FACTOR),
        .OUTPUT_DATA_WIDTH(OUTPUT_WIDTH),
        .INTERNAL_DATA_WIDTH(FREQ_WIDTH + MAX_ROW_STAGES + MAX_COL_STAGES)
    ) u_ifft (
        .clk(clk), .rst_n(rst_n),
        .data_valid(proc_data_valid),
        .row_stage(row_stage_buf),
        .col_stage(col_stage_buf),
        .data_in_R(proc_data_R),
        .data_in_I(proc_data_I),
        .row_in(),
        .in_ready(ifft_in_ready),
        .read_next(ifft_read_next),
        .read_done(ifft_read_done),
        .out_ready(ifft_out_ready),
        .empty(ifft_empty),
        .ifft_done(ifft_done_w),
        .row_out(ifft_row_out),
        .output_data_R(ifft_pixel_out_R),
        .output_data_I(ifft_pixel_out_I)
    );

endmodule
