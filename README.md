
# vComp

A simple bash script to download and compress videos to a target resolution (480p or 720p) while limiting file size, using `ffmpeg` and optionally `yt-dlp` for YouTube downloads.

---

## 🔧 Features

- Compress local videos or downloaded YouTube videos  
- Automatically scales video to 480p or 720p  
- Calculates bitrate to keep output size below a configurable MB limit (default 499 MB)  
- Audio bitrate fixed at 128 kbps for consistent quality  
- Faststart enabled for MP4 streaming compatibility  
- Simple CLI interface with helpful usage instructions  

---

## 📦 Requirements

- `ffmpeg`  
- `ffprobe`  
- `yt-dlp` (optional, for YouTube downloads)

### Debian/Ubuntu:

```bash
sudo apt update
sudo apt install ffmpeg yt-dlp
```

### Arch Linux:

```bash
sudo pacman -S ffmpeg yt-dlp
```

---

## 📥 Downloading the Script

### Option 1: Clone via Git

```bash
git clone https://github.com/PostmanPat2011/vComp.git
cd vComp
chmod +x vComp.sh
```

### Option 2: Manual Download

Download the raw script:  
[https://github.com/PostmanPat2011/vComp/blob/main/vComp.sh](https://github.com/PostmanPat2011/vComp/blob/main/vComp.sh)

Then make it executable:

```bash
chmod +x vComp.sh
```

---

## 🚀 Usage

```bash
./vComp.sh <input_file> <output_file> <resolution> [options]
```

### Arguments

| Argument      | Description                                                   |
| ------------- | ------------------------------------------------------------- |
| `input_file`  | Path to your input video file (or target path if downloading) |
| `output_file` | Path where the compressed video will be saved                 |
| `resolution`  | Target resolution: `480p` or `720p`                           |

### Options

| Option         | Description                                                                         |
| -------------- | ----------------------------------------------------------------------------------- |
| `-d <URL>`     | Download a video from YouTube using the URL, save to `input_file`, then compress it |
| `-h`, `--help` | Display this help manual and exit                                                   |

---

## 📂 Examples

### Compress a local video to 480p

```bash
./vComp.sh "/path/to/input.mp4" "/path/to/output.mp4" 480p
```

### Download and compress a YouTube video to 720p

```bash
./vComp.sh "/path/to/save/video.mp4" "/path/to/output.mp4" 720p -d "https://youtube.com/watch?v=VIDEOID"
```

---

## ⚙️ Configuration

Modify variables at the top of the script to customize behavior:

```bash
MAX_MB=499           # Max output file size in MB
AUDIO_BITRATE=128000 # Audio bitrate in bits per second
```

---

## 🔍 How It Works

1. (Optional) Downloads the video using `yt-dlp` if `-d` is specified  
2. Skips compression if input is already under the size limit  
3. Calculates video bitrate from remaining file size budget  
4. Uses `ffmpeg` to scale and compress using H.264  
5. Outputs a resolution-constrained, size-limited MP4 file  

---

## 🛠 Troubleshooting

- Ensure all required tools are in your `PATH`
- Use absolute paths to avoid file resolution issues
- Script supports only 480p and 720p resolutions currently
- For `yt-dlp`, verify network access and sufficient disk space

---

## 📄 License

### MIT License  
Copyright 2025 PostmanPat2011

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

---

## 🤝 Contributing

Pull requests, issues, and suggestions are always welcome!


## 🐧 Using on Windows with WSL
###### I put this down here because I doubt windows users will use this >.<
1. Install WSL and Ubuntu:  
   ```powershell
   wsl --install
   ```

2. Open your WSL terminal and install dependencies:  
   ```bash
   sudo apt update && sudo apt install ffmpeg yt-dlp
   ```

3. Clone the script into your WSL environment:  
   ```bash
   git clone https://github.com/PostmanPat2011/vComp.git
   cd vComp
   chmod +x vComp.sh
   ```

4. Use `/mnt/c/...` paths to access Windows files:  
   ```bash
   ./vComp.sh "/mnt/c/Users/YourUsername/input.mkv" "/mnt/c/Users/YourUsername/output.mp4" 480p
   ```

---

## 🖥️ Using on Windows with Git Bash

1. Install Git Bash from [git-scm.com](https://git-scm.com/)  

2. Download and extract FFmpeg from:  
   [https://www.gyan.dev/ffmpeg/builds/](https://www.gyan.dev/ffmpeg/builds/)  
   Add its `bin` folder (e.g., `C:\ffmpeg\bin`) to your Windows **PATH**

3. Install `yt-dlp` with Python:  
   ```bash
   pip install yt-dlp
   ```
   Or download the standalone `.exe` from [yt-dlp GitHub Releases](https://github.com/yt-dlp/yt-dlp/releases)

4. Clone the script using Git Bash:  
   ```bash
   git clone https://github.com/PostmanPat2011/vComp.git
   cd vComp
   chmod +x vComp.sh
   ```

5. Run the script using Git Bash-style paths:  
   ```bash
   ./vComp.sh "/c/Users/YourUsername/input.mkv" "/c/Users/YourUsername/output.mp4" 480p
   ```

---
