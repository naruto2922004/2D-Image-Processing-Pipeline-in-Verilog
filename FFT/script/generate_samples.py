import os
import math

ROW_STAGE = 3
COL_STAGE = 3
NUM_ROWS  = 1 << ROW_STAGE
NUM_COLS  = 1 << COL_STAGE

image = []
for r in range(NUM_ROWS):
    for c in range(NUM_COLS):
        val = 5000 * math.cos(2 * math.pi * 1 * r / NUM_ROWS + 2 * math.pi * 2 * c / NUM_COLS)
        val += 3000 * math.cos(2 * math.pi * 2 * r / NUM_ROWS + 2 * math.pi * 1 * c / NUM_COLS)
        image.append(int(round(val)))

script_dir = os.path.dirname(os.path.abspath(__file__))
sim_dir = os.path.join(os.path.dirname(script_dir), "sim")
os.makedirs(sim_dir, exist_ok=True)
out_path = os.path.join(sim_dir, "input_samples.txt")

with open(out_path, "w") as f:
    for val in image:
        f.write(f"{val}\n")

print(f"Generated {NUM_ROWS}x{NUM_COLS} ({len(image)} pixels) -> {out_path}")
