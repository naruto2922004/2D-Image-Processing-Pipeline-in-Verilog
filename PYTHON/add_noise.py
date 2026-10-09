import math
import random
from pathlib import Path
from PIL import Image


# Settings
ROWS = 256
COLS = 256
DATA_WIDTH = 16

NOISE = "none"       # none / low / high / radial / gaussian
NOISE_PARAM = 20

LOW_NOISE_FREQ = 20
HIGH_NOISE_FREQ = 200
RADIAL_LOW_FREQ = 70
RADIAL_HIGH_FREQ = 90

SEED = 45


# Paths
BASE = Path(__file__).parent
INPUT = BASE / "image" / "sample.jpg"
NOISY_IMAGE = BASE / "image" / "input.png"
INPUT_TXT = BASE.parent / "TOP" / "sim" / "fft_input.txt"


def add_noise(image):
    random.seed(SEED)
    noisy = []

    for y, row in enumerate(image):
        new_row = []

        for x, pixel in enumerate(row):

            if NOISE == "none":
                value = pixel

            elif NOISE == "gaussian":
                value = pixel + NOISE_PARAM * random.gauss(0, 1)

            elif NOISE == "low":
                value = pixel + NOISE_PARAM * math.sin(
                    2 * math.pi * LOW_NOISE_FREQ * x / COLS
                )

            elif NOISE == "high":
                value = pixel + NOISE_PARAM * math.sin(
                    2 * math.pi * HIGH_NOISE_FREQ * x / COLS
                )

            elif NOISE == "radial":
                value = pixel

                for freq in range(RADIAL_LOW_FREQ, RADIAL_HIGH_FREQ + 1, 5):
                    for angle in range(0, 360, 45):
                        a = math.radians(angle)
                        fx = freq * math.cos(a)
                        fy = freq * math.sin(a)

                        value += (NOISE_PARAM / 32) * math.cos(
                            2 * math.pi * (
                                fx * x / COLS +
                                fy * y / ROWS
                            )
                        )

            else:
                raise ValueError(
                    "NOISE must be: none, low, high, radial or gaussian"
                )

            new_row.append(max(0, min(255, round(value))))

        noisy.append(new_row)

    return noisy


def main():
    if ROWS & (ROWS - 1) or COLS & (COLS - 1):
        raise ValueError("ROWS and COLS must be powers of 2")

    if DATA_WIDTH < 8:
        raise ValueError("DATA_WIDTH must be at least 8")

    image = Image.open(INPUT).convert("L")
    image = image.resize((COLS, ROWS), Image.Resampling.LANCZOS)

    pixels = list(image.get_flattened_data())

    image_data = [
        pixels[r * COLS:(r + 1) * COLS]
        for r in range(ROWS)
    ]

    noisy = add_noise(image_data)

    noisy_image = Image.new("L", (COLS, ROWS))
    noisy_image.putdata(
        [pixel for row in noisy for pixel in row]
    )
    noisy_image.save(NOISY_IMAGE)

    INPUT_TXT.parent.mkdir(parents=True, exist_ok=True)

    with open(INPUT_TXT, "w") as f:
        for row in noisy:
            for pixel in row:
                f.write(f"{pixel:0{(DATA_WIDTH + 3) // 4}X}\n")

    mse = sum(
        (image_data[r][c] - noisy[r][c]) ** 2
        for r in range(ROWS)
        for c in range(COLS)
    ) / (ROWS * COLS)

    psnr = 10 * math.log10(255 ** 2 / mse) if mse else float("inf")

    print(f"Image: {INPUT}")
    print(f"Size: {ROWS} x {COLS}")
    print(f"Data width: {DATA_WIDTH} bits")
    print(f"Noise: {NOISE}")
    print(f"Parameter: {NOISE_PARAM}")

    if NOISE == "low":
        print(f"Frequency: {LOW_NOISE_FREQ}")
    elif NOISE == "high":
        print(f"Frequency: {HIGH_NOISE_FREQ}")
    elif NOISE == "radial":
        print(
            f"Frequency: {RADIAL_LOW_FREQ} - "
            f"{RADIAL_HIGH_FREQ}"
        )

    print(f"Output image: {NOISY_IMAGE}")
    print(f"FFT input: {INPUT_TXT}")
    print(f"MSE: {mse:.2f}")
    print(f"PSNR: {psnr:.2f} dB")


if __name__ == "__main__":
    main()
