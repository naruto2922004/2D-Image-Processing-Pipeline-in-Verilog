# 2D Image Processing Pipeline in Verilog

A hardware-accelerated 2D frequency-domain image processing pipeline implemented in Verilog HDL. The architecture performs a **2D Fast Fourier Transform (FFT)**, applies **real-time spatial-frequency filtering**, and reconstructs the image using a **2D Inverse Fast Fourier Transform (IFFT)**.

---

## Overview

Processing images in the frequency domain allows selective attenuation or enhancement of specific spatial frequencies (e.g., smoothing, noise removal, edge detection). This design implements an end-to-end pipelined hardware accelerator:

1. **2D DIT Radix-2 FFT**: Computes the 2D DFT by transforming rows followed by columns using parallel butterfly units.
2. **Frequency Domain Filter (`img_proc`)**: Filters frequency coefficients on-the-fly as they stream out of the FFT without storing full intermediate frames.
3. **2D DIT Radix-2 IFFT**: Converts filtered frequency coefficients back to spatial-domain pixels with hardware scaling and saturation.
4. **Python Software Interface**: Generates noisy test images, converts pixels to simulator stimulus, and reconstructs the output images for visual inspection and PSNR evaluation.

---

## Filter Modes

The filter block supports 5 selectable modes via the 3-bit `filter_mode` input:

| Mode (`filter_mode`) | Type | Description |
|---|---|---|
| `3'b000` | **Ideal Low-Pass (LPF)** | Passes frequencies within radius D <= cutoff, blocks high-frequency noise. |
| `3'b001` | **Ideal High-Pass (HPF)** | Passes frequencies beyond radius D > cutoff, extracts edges and details. |
| `3'b010` | **Gaussian Low-Pass (GLPF)** | Smooth attenuation using precomputed Gaussian ROM factors. |
| `3'b011` | **Gaussian High-Pass (GHPF)** | Smooth edge preservation by inverting Gaussian coefficients (1.0 - H_LP). |
| `3'b100` | **Passthrough** | Bypasses filtering (raw FFT -> IFFT) to verify system integrity and round-trip accuracy. |

---

## Configurable Parameters

The architecture is fully parameterized to support customizable image dimensions, precision, and parallelism:

| Parameter | Default | Description |
|---|---|---|
| `MAX_ROW_STAGES` | `10` | Log base 2 of the maximum image height. Default 10 means a maximum of 1024 rows. |
| `MAX_COL_STAGES` | `10` | Log base 2 of the maximum image width. Default 10 means a maximum of 1024 columns. |
| `PIXEL_WIDTH` | `16` | Bit-width of input and output pixels. |
| `TWIDDLE_WIDTH` | `16` | Bit-width of twiddle factors (Q15 format). |
| `FRAC_BITS` | `15` | Number of fractional bits for fixed-point math. |
| `BUTTERFLY_FACTOR` | `6` | Parallelism: 2^BUTTERFLY_FACTOR = 64 parallel butterfly units. |
| `TWIDDLE_MAX_STAGES` | `10` | Maximum twiddle depth supported by the ROM: 2^10 = 1024 points. |

*Note: Runtime dimensions are dynamically set using the `row_stage` and `col_stage` ports. The dimension is N = 2^stage; examples include 8 x 8, 64 x 64, and 256 x 256.*

---

## Project Structure

```
.
├── FFT/
│   ├── rtl/                # 2D FFT module and butterfly hardware
│   ├── rom/                # Central twiddle factor lookup table (fft_twiddle_rom.v)
│   ├── script/             # Twiddle generator, sample generator, verification
│   └── sim/                # Standalone FFT testbench & simulation files
├── IFFT/
│   ├── rtl/                # 2D IFFT module and butterfly hardware
│   ├── script/             # Standalone IFFT verification script
│   └── sim/                # Standalone IFFT testbench & simulation files
├── IMG_PROC/
│   ├── rtl/                # Filtering module (LPF, HPF, Gaussian LPF/HPF, Passthrough)
│   ├── rom/                # Gaussian lookup table (gaussian_rom.v)
│   └── script/             # Gaussian ROM generation script
├── TOP/
│   ├── rtl/                # Top-level wrapper (image_proc_top.v)
│   └── sim/                # End-to-end system testbench (tb_image_proc_top.v)
└── PYTHON/
    ├── add_noise.py        # Adds noise to an input image and extracts hex pixels
    └── reconstruct_image.py # Reconstructs filtered image from IFFT output and computes PSNR
```

---

## How to Run and Verify

The complete image processing flow consists of three steps:

### 1. Generate Noisy Image Stimulus

Place your source image in `PYTHON/image/input_sample.jpg` and run:

```bash
python PYTHON/add_noise.py
```

This resizes the image to the configured resolution (default 256 x 256), injects frequency or spatial noise, saves the noisy preview to `PYTHON/image/input_noisy.png`, and writes formatted pixels to `TOP/sim/fft_input.txt`.

### 2. Run Hardware Simulation

Compile all modules and run the end-to-end testbench using ModelSim:

```powershell
# Compile RTL and testbench
vlog -work work FFT/rom/fft_twiddle_rom.v FFT/rtl/fft_butterfly.v FFT/rtl/fft.v `
               IFFT/rtl/ifft_butterfly.v IFFT/rtl/ifft.v `
               IMG_PROC/rom/gaussian_rom.v IMG_PROC/rtl/img_proc.v `
               TOP/rtl/image_proc_top.v TOP/sim/tb_image_proc_top.v

# Run simulation
vsim -c -work work tb_image_proc_top -do "run -all; quit"
```

The testbench:
- Streams image pixels from `TOP/sim/fft_input.txt` into the 2D FFT core.
- Passes frequency coefficients through the `img_proc` filter unit.
- Computes the 2D IFFT and writes reconstructed pixel values to `TOP/sim/ifft_output.txt`.

*(To change the active filter mode or cutoff radius, adjust `FILTER_MODE` and `CUTOFF` in `TOP/sim/tb_image_proc_top.v`).*

### 3. Reconstruct Filtered Image

Convert the simulation output back into an image and evaluate filtering quality:

```bash
python PYTHON/reconstruct_image.py
```

The script:
- Reads the raw real outputs from `TOP/sim/ifft_output.txt`.
- Clips and formats pixel intensities to the range 0 to 255.
- Saves the final result to `PYTHON/image/filtered.png`.
- Computes Mean Squared Error (MSE) and Peak Signal-to-Noise Ratio (PSNR) against the original image.

---

## Standalone Core Verification

Each processing core can also be simulated and verified individually:

### Standalone 2D FFT:

```powershell
python FFT/script/generate_samples.py
vlog -work FFT/work FFT/rom/fft_twiddle_rom.v FFT/rtl/fft_butterfly.v FFT/rtl/fft.v FFT/sim/tb_fft.v
vsim -c -work FFT/work tb_fft -do "run -all; quit"
python FFT/script/verify_output.py
```

*Compares hardware frequency outputs against an analytical 2D DFT calculated in Python.*

### Standalone 2D IFFT:

```powershell
# (Note: Run the FFT simulation above first so FFT/sim/output_results.txt is available)
vlog -work IFFT/work FFT/rom/fft_twiddle_rom.v IFFT/rtl/ifft_butterfly.v IFFT/rtl/ifft.v IFFT/sim/tb_ifft.v
vsim -c -work IFFT/work tb_ifft -do "run -all; quit"
python IFFT/script/verify_output.py
```

*Loads frequency bins from `FFT/sim/output_results.txt` and verifies round-trip reconstruction against original image pixels (maximum error <= 1 LSB).*
