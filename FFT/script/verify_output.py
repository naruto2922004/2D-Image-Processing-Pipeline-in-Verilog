import os
import math
import cmath

ROW_STAGE = 3
COL_STAGE = 3
NUM_ROWS  = 1 << ROW_STAGE
NUM_COLS  = 1 << COL_STAGE

script_dir = os.path.dirname(os.path.abspath(__file__))
sim_dir = os.path.join(os.path.dirname(script_dir), "sim")
in_file = os.path.join(sim_dir, "input_samples.txt")
out_file = os.path.join(sim_dir, "output_results.txt")

if not os.path.exists(in_file) or not os.path.exists(out_file):
    print(f"Error: Missing {in_file} or {out_file}")
    exit(1)

with open(in_file) as f:
    flat = [int(line.strip()) for line in f if line.strip()]

image = [[flat[r * NUM_COLS + c] for c in range(NUM_COLS)] for r in range(NUM_ROWS)]

ref = [[0 + 0j] * NUM_COLS for _ in range(NUM_ROWS)]
for m in range(NUM_ROWS):
    for k in range(NUM_COLS):
        s = 0 + 0j
        for r in range(NUM_ROWS):
            for c in range(NUM_COLS):
                s += image[r][c] * cmath.exp(-1j * 2 * math.pi * m * r / NUM_ROWS) \
                                 * cmath.exp(-1j * 2 * math.pi * k * c / NUM_COLS)
        ref[m][k] = s

with open(out_file) as f:
    lines = [line.split() for line in f if line.strip()]

hw = [[0 + 0j] * NUM_COLS for _ in range(NUM_ROWS)]
for m in range(NUM_ROWS):
    for k in range(NUM_COLS):
        idx = m * NUM_COLS + k
        hw[m][k] = complex(int(lines[idx][0]), int(lines[idx][1]))

max_ref = max(abs(ref[m][k]) for m in range(NUM_ROWS) for k in range(NUM_COLS))
max_err = max(abs(hw[m][k] - ref[m][k]) for m in range(NUM_ROWS) for k in range(NUM_COLS))
rel_err = 100.0 * max_err / max_ref if max_ref > 0 else 0

status = "PASS" if rel_err < 0.1 else "FAIL"
print(f"2D FFT ({NUM_ROWS}x{NUM_COLS}): Max Error = {max_err:.2f} ({rel_err:.4f}%) -> {status}")