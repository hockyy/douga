#!/bin/bash

read -p "Enter the name of the video file (e.g., input.mkv, input.mp4): " inputVideo

echo ""
echo "Displaying stream information for $inputVideo:"
echo ""

ffmpeg -hide_banner -i "$inputVideo" 2>&1 | grep "Stream"

echo ""
read -p "Enter the subtitle stream index (should look like 0:X where X is the index): " subtitleIndex

# Extract filename and extension
filename="${inputVideo%.*}"
extension="${inputVideo##*.}"

# Extract and save the subtitle
ffmpeg -hide_banner -i "$inputVideo" -map "$subtitleIndex" "${filename}_${subtitleIndex}.ass"

# Burn the subtitle into the video
ffmpeg -hwaccel auto -i "$inputVideo" -map 0 -vf "subtitles='$inputVideo:si=$subtitleIndex'" -c:v h264_videotoolbox -preset ultrafast -c:a copy "${filename}_hardsub.${extension}"

echo ""
echo "Operation completed."

