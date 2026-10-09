import os

ROW_STAGE = 3
COL_STAGE = 3
NUM_ROWS  = 1 << ROW_STAGE
NUM_COLS  = 1 << COL_STAGE

script_dir = os.path.dirname(os.path.abspath(__file__))
project_dir = os.path.dirname(script_dir)
root_dir = os.path.dirname(project_dir)

orig_file = os.path.join(root_dir, "FFT", "sim", "input_samples.txt")
out_file  = os.path.join(project_dir, "sim", "output_results.txt")

if not os.path.exists(orig_file):
    orig_file = os.path.join(project_dir, "sim", "input_samples.txt")

if not os.path.exists(orig_file) or not os.path.exists(out_file):
    print(f"Error: Missing {orig_file} or {out_file}")
    exit(1)

with open(orig_file) as f:
    orig = [int(line.strip()) for line in f if line.strip()]

with open(out_file) as f:
    reconstructed = [int(line.split()[0]) for line in f if line.strip()]

if len(orig) != len(reconstructed):
    print(f"Error: Length mismatch orig={len(orig)}, reconstructed={len(reconstructed)}")
    exit(1)

max_diff = max(abs(a - b) for a, b in zip(orig, reconstructed))
max_val  = max(abs(x) for x in orig)
avg_diff = sum(abs(a - b) for a, b in zip(orig, reconstructed)) / len(orig)
rel_err  = 100.0 * max_diff / max_val if max_val > 0 else 0

status = "PASS" if max_diff <= 2 else "FAIL"
print(f"2D IFFT ({NUM_ROWS}x{NUM_COLS}) Round-Trip: Max Error = {max_diff} LSB ({rel_err:.4f}%), Avg Error = {avg_diff:.4f} -> {status}")