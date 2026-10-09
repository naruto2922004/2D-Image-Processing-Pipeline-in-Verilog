import math
from pathlib import Path
from PIL import Image


# Settings
ROWS = 256
COLS = 256

INPUT = Path(__file__).parent.parent / "TOP" / "sim" / "ifft_output.txt"
OUTPUT = Path(__file__).parent / "image" / "filtered.png"

COMPARE = True
REFERENCE = Path(__file__).parent / "image" / "input_sample.jpg"


def read_output(path):
    with open(path) as f:
        lines = [line.strip() for line in f if line.strip()]

    expected = ROWS * COLS

    if len(lines) < expected:
        print(f"Warning: expected {expected} lines, got {len(lines)}")
        lines += ["0 0"] * (expected - len(lines))

    pixels = []

    for i in range(expected):
        real = int(lines[i].split()[0])
        pixels.append(real)

    return [
        pixels[r * COLS:(r + 1) * COLS]
        for r in range(ROWS)
    ]


def save_image(pixels):
    image = Image.new("L", (COLS, ROWS))
    image.putdata([pixel for row in pixels for pixel in row])

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    image.save(OUTPUT)

    print(f"Saved reconstructed image: {OUTPUT}")


def compute_psnr(image, reference):
    mse = sum(
        (image[r][c] - reference[r][c]) ** 2
        for r in range(ROWS)
        for c in range(COLS)
    ) / (ROWS * COLS)

    psnr = 10 * math.log10(255 ** 2 / mse) if mse else float("inf")

    return mse, psnr


def main():
    print(f"Reading IFFT output: {INPUT}")
    print(f"Size: {ROWS} x {COLS}")

    raw = read_output(INPUT)

    flat = [pixel for row in raw for pixel in row]

    print(f"Raw range: min={min(flat)}, max={max(flat)}")

    below = sum(pixel < 0 for pixel in flat)
    above = sum(pixel > 255 for pixel in flat)

    if below or above:
        print(f"Clipping: {below} below 0, {above} above 255")

    pixels = [
        [max(0, min(255, pixel)) for pixel in row]
        for row in raw
    ]

    save_image(pixels)

    if COMPARE:
        reference = Image.open(REFERENCE).convert("L")
        reference = reference.resize((COLS, ROWS))

        data = list(reference.getdata())
        reference = [
            data[r * COLS:(r + 1) * COLS]
            for r in range(ROWS)
        ]

        mse, psnr = compute_psnr(pixels, reference)

        print(f"MSE: {mse:.2f}")
        print(f"PSNR: {psnr:.2f} dB")


if __name__ == "__main__":
    main()