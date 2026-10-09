import math
from pathlib import Path


# Settings
SIGMA = 10.0
MAX_COL_STAGES = 10
MAX_ROW_STAGES = 10


OUTPUT = Path(__file__).parent.parent / "rom" / "gaussian_rom.v"


def generate_rom():
    col_half = 1 << (MAX_COL_STAGES - 1)
    row_half = 1 << (MAX_ROW_STAGES - 1)

    d_sq_max = col_half * col_half + row_half * row_half
    depth = d_sq_max + 1
    addr_width = 1 if d_sq_max == 0 else int(math.floor(math.log2(d_sq_max))) + 1

    two_sigma_sq = 2.0 * SIGMA * SIGMA

    with open(OUTPUT, "w") as f:
        f.write("// gaussian_rom.v - Auto-generated\n")
        f.write(f"// sigma={SIGMA}, max_col_stages={MAX_COL_STAGES}, max_row_stages={MAX_ROW_STAGES}\n")
        f.write(f"// D_sq_max={d_sq_max}, DEPTH={depth}, ADDR_WIDTH={addr_width}\n")
        f.write(f"// H[D_sq] = round(32767 * exp(-D_sq / {two_sigma_sq:.4f}))\n")
        f.write("//\n")

        f.write("module gaussian_rom #(\n")
        f.write(f"    parameter ADDR_WIDTH = {addr_width},\n")
        f.write(f"    parameter DEPTH      = {depth}\n")
        f.write(")(\n")
        f.write("    input  [ADDR_WIDTH-1:0] addr,\n")
        f.write("    output signed [15:0]    H\n")
        f.write(");\n\n")

        f_write_init = """    reg signed [15:0] rom [0:DEPTH-1];
    integer i;
    initial begin
        for (i = 0; i < DEPTH; i = i + 1)
            rom[i] = 16'sd0;

"""
        f.write(f_write_init)

        for d_sq in range(depth):
            h_real = math.exp(-d_sq / two_sigma_sq)
            h_q15 = int(round(32767.0 * h_real))
            h_q15 = max(0, min(32767, h_q15))
            if h_q15 > 0:
                comment = f"exp(-{d_sq}/{two_sigma_sq:.2f}) = {h_real:.6f}"
                f.write(
                    f"        rom[{d_sq:6d}] = 16'sd{h_q15:6d};  // {comment}\n"
                )
            else:
                break

        f.write("    end\n\n")
        f.write("    assign H = rom[addr];\n")
        f.write("endmodule\n")

    print(f"Generated: {OUTPUT}")
    print(f"D_sq_max: {d_sq_max}")
    print(f"Depth: {depth}")
    print(f"Address width: {addr_width}")


if __name__ == "__main__":
    generate_rom()