
import math
from pathlib import Path

MAX_POWER = 10
TW_WIDTH = 16
FRAC_BITS = 15

N = 1 << MAX_POWER
rom_size = N // 2
bus_width = rom_size * TW_WIDTH

PROJECT_DIR = Path(__file__).resolve().parent.parent

OUTPUT_FILE = PROJECT_DIR / "rom" / "fft_twiddle_rom.v"

OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)

def to_hex(val):
    val = round(val * (1 << FRAC_BITS))
    val = max(
        -(1 << (TW_WIDTH - 1)),
        min((1 << (TW_WIDTH - 1)) - 1, val)
    )
    return f"{val & ((1 << TW_WIDTH) - 1):04X}"


with open(OUTPUT_FILE, "w") as f:
    f.write("module fft_twiddle_rom (\n")
    f.write(f"    output [{bus_width - 1}:0] tw_real,\n")
    f.write(f"    output [{bus_width - 1}:0] tw_imag\n")
    f.write(");\n\n")

    for k in range(rom_size):
        angle = -2.0 * math.pi * k / N

        r_hex = to_hex(math.cos(angle))
        i_hex = to_hex(math.sin(angle))

        hi = (k + 1) * TW_WIDTH - 1
        lo = k * TW_WIDTH

        f.write(f"    assign tw_real[{hi}:{lo}] = 16'h{r_hex};\n")
        f.write(f"    assign tw_imag[{hi}:{lo}] = 16'h{i_hex};\n\n")

    f.write("endmodule\n")

print(f"Generated {N}-point FFT twiddle ROM at: {OUTPUT_FILE}")
