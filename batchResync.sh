#!/bin/bash

for srt_file in *.srt; do
    base_name="${srt_file%.*}"
    ffmpeg -itsoffset 44.5 -i "$srt_file" -c copy "${base_name}_synced.srt"
done
