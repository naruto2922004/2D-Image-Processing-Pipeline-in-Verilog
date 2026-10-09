module fft_butterfly #(
    parameter DATA_WIDTH = 36,
    parameter TWIDDLE_WIDTH = 16,
    parameter FRAC_BITS = 15
)(
    input signed [DATA_WIDTH-1:0] IN_A_R, IN_A_I, IN_B_R, IN_B_I,
    input signed[TWIDDLE_WIDTH-1:0]T_R, T_I,
    output signed [DATA_WIDTH-1:0] OUT_A_R, OUT_A_I, OUT_B_R, OUT_B_I
);
    wire signed[DATA_WIDTH-1:0]T_B_R, T_B_I;
    wire signed [DATA_WIDTH+TWIDDLE_WIDTH-1:0] P1, P2;
    wire signed [DATA_WIDTH+TWIDDLE_WIDTH+1:0] P3, M_B_R, M_B_I;

    assign P1 = IN_B_R * T_R;
    assign P2 = IN_B_I * T_I;
    assign P3 = (IN_B_R + IN_B_I) * (T_R + T_I);

    assign M_B_R = P1 - P2;
    assign M_B_I = P3 - P1 - P2;

    assign T_B_R = (M_B_R + (1 <<< (FRAC_BITS - 1))) >>> FRAC_BITS; // round to nearest with preserved sign
    assign T_B_I = (M_B_I + (1 <<< (FRAC_BITS - 1))) >>> FRAC_BITS;

    assign OUT_A_R = IN_A_R + T_B_R;
    assign OUT_A_I = IN_A_I + T_B_I;
    assign OUT_B_R = IN_A_R - T_B_R;
    assign OUT_B_I = IN_A_I - T_B_I;
    
endmodule