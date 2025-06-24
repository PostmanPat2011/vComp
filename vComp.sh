#!/bin/bash
set -euo pipefail

######################################
# User-configurable settings
MAX_MB=499              # Maximum allowed output size in MB
AUDIO_BITRATE=128000    # Fixed audio bitrate in bits/sec
######################################

show_help() {
  cat << EOF
Usage: $0 <input_file> <output_file> <resolution> [options]

Arguments:
  input_file           Path to the input video file (or where downloaded file will be saved)
  output_file          Path to save the compressed output video
  resolution           Target resolution: 480p or 720p

Options:
  -d <youtube_url>     Download video from YouTube URL using yt-dlp, save to input_file, then compress
  -h, --help           Show this help message and exit

Example:
  $0 "/path/to/input.mp4" "/path/to/output.mp4" 480p
  $0 "/path/to/input.mp4" "/path/to/output.mp4" 720p -d "https://youtube.com/xyz"

Note:
  - Requires 'ffmpeg', 'ffprobe', and optionally 'yt-dlp' if using -d.
  - Compression target file size is set by MAX_MB=${MAX_MB} MB in the script.
EOF
}

# If no args or -h/--help show help
if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
  exit 0
fi

# Parse arguments
input=$(realpath "$1")
output=$(realpath "$2")
resolution="$3"
download_flag="${4:-}"
yt_url="${5:-}"

# Convert max MB to bytes
max_size_bytes=$((MAX_MB * 1024 * 1024))

# Download video if -d option is used
if [[ "$download_flag" == "-d" && -n "$yt_url" ]]; then
  echo "📥 Downloading video from: $yt_url"

  if ! command -v yt-dlp &>/dev/null; then
    echo "❌ yt-dlp is not installed. Please install it first."
    exit 1
  fi

  mkdir -p "$(dirname "$input")"
  yt-dlp -o "$input" -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]" "$yt_url"

  echo "⏳ Waiting for file to finalize..."
  for i in {1..30}; do
    [[ -f "$input" && ! -f "$input.part" ]] && {
      echo "✅ Download finalized: $input"
      break
    }
    sleep 1
  done

  [[ ! -f "$input" ]] && {
    echo "❌ Failed to detect finalized file: $input"
    exit 1
  }
fi

# Check if the file is already below the size limit
actual_size=$(stat -c%s "$input")
if (( actual_size <= max_size_bytes )); then
  echo "✅ File is already under ${MAX_MB}MB ($((actual_size / 1024 / 1024)) MB). No compression needed."
  exit 0
fi

# Select resolution scale
case "$resolution" in
  720p) scale="scale=-2:720" ;;
  480p) scale="scale=-2:480" ;;
  *)
    echo "❌ Unsupported resolution: $resolution"
    echo "✅ Use: 480p or 720p"
    exit 1
    ;;
esac

# Get video duration in seconds
duration=$(ffprobe -v error -show_entries format=duration \
          -of default=noprint_wrappers=1:nokey=1 "$input")
duration=${duration%.*}

# Calculate target video bitrate in kbps
video_bitrate=$(( (max_size_bytes * 8 / duration) - AUDIO_BITRATE ))
video_bitrate_kbps=$((video_bitrate / 1000))

echo "🎬 Compressing '$input' to $resolution at ~${video_bitrate_kbps} kbps"

# Compress the video
ffmpeg -i "$input" -vf "$scale" -c:v libx264 -preset slow -b:v "${video_bitrate_kbps}k" \
       -c:a aac -b:a $((AUDIO_BITRATE / 1000))k -movflags +faststart "$output"

echo "✅ Compression complete: $output"
