A simple bash script to download and compress videos to a target resolution (480p or 720p) while limiting file size, using `ffmpeg` and optionally `yt-dlp` for YouTube downloads.

---

## Features

* Compress local videos or downloaded YouTube videos
* Automatically scales video to 480p or 720p
* Calculates bitrate to keep output size below a configurable MB limit (default 499 MB)
* Audio bitrate fixed at 128 kbps for consistent quality
* Faststart enabled for MP4 streaming compatibility
* Simple CLI interface with helpful usage instructions

---

## Requirements

* `ffmpeg`
* `ffprobe`
* `yt-dlp` (optional, only if using the download feature)

Install on Debian/Ubuntu:

```bash
sudo apt update
sudo apt install ffmpeg yt-dlp
```

On Arch Linux:

```bash
sudo pacman -S ffmpeg yt-dlp
```

---

## Usage

```bash
./vComp.sh <input_file> <output_file> <resolution> [options]
```

### Arguments

| Argument      | Description                                                   |
| ------------- | ------------------------------------------------------------- |
| `input_file`  | Path to your input video file (or target path if downloading) |
| `output_file` | Path where the compressed video will be saved                 |
| `resolution`  | Target resolution. Accepted: `480p` or `720p`                 |

### Options

| Option         | Description                                                                         |
| -------------- | ----------------------------------------------------------------------------------- |
| `-d <URL>`     | Download a video from YouTube using the URL, save to `input_file`, then compress it |
| `-h`, `--help` | Display this help manual and exit                                                   |

---

## Examples

### Compress a local video to 480p

```bash
./DiscordCompression.sh "/path/to/input.mp4" "/path/to/output.mp4" 480p
```

### Download and compress a YouTube video to 720p

```bash
./DiscordCompression.sh "/path/to/save/video.mp4" "/path/to/output.mp4" 720p -d "https://youtube.com/watch?v=VIDEOID"
```

---

## Configuration

You can modify the following variables at the top of the script to customize behavior:

```bash
MAX_MB=499          # Max output file size in MB (default 499)
AUDIO_BITRATE=128000 # Audio bitrate in bits per second (default 128k)
```

---

## How it works

1. **(Optional)** Downloads the video from YouTube if `-d` option is provided.
2. Checks if the input video is already smaller than the `MAX_MB` limit. If yes, skips compression.
3. Calculates the video bitrate based on the target file size minus audio bitrate.
4. Uses `ffmpeg` to resize and encode the video using H.264 codec.
5. Outputs a compressed video file under the size limit with the desired resolution.

---

## Troubleshooting

* Make sure `ffmpeg`, `ffprobe`, and `yt-dlp` are installed and accessible in your PATH.
* Use absolute paths for input/output to avoid confusion.
* If the script fails to detect a completed download, ensure your disk and network are stable.
* The script currently supports only 480p and 720p resolutions.

---

## License


Copyright 2025 PostmanPat2011

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


---

## Contributing

Feel free to open issues or submit pull requests for bug fixes or enhancements.
