import argparse
import os

from PIL import Image, ImageChops


def make_frame(image, shift, wrap):
    if wrap:
        # Pixels that leave the right edge reappear on the left
        return ImageChops.offset(image, shift, 0)

    # No wrap: shifted-in area on the left is transparent
    frame = Image.new("RGBA", image.size, (0, 0, 0, 0))
    frame.paste(image, (shift, 0))
    return frame


def main():
    parser = argparse.ArgumentParser(
        description="Generate frames of an image scrolling to the right."
    )
    parser.add_argument("input", help="Path to the source image")
    parser.add_argument("-o", "--outdir", default="frames", help="Output folder")
    parser.add_argument("-n", "--frames", type=int, default=16, help="Number of frames")
    parser.add_argument("-s", "--step", type=int, default=2, help="Pixels to scroll per frame")
    parser.add_argument("--no-wrap", action="store_true", help="Don't wrap pixels around the edge")
    args = parser.parse_args()

    image = Image.open(args.input).convert("RGBA")
    os.makedirs(args.outdir, exist_ok=True)

    for i in range(args.frames):
        shift = i * args.step
        frame = make_frame(image, shift, wrap=not args.no_wrap)
        path = os.path.join(args.outdir, f"frame_{i:02d}.png")
        frame.save(path)
        print(f"Saved {path} (shift {shift}px)")


if __name__ == "__main__":
    main()