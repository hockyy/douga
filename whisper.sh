whisper() {
  local input="$1"
  shift
  
  # All remaining arguments will be treated as an array
  local -a extra_args=("$@")
  "$WHISPERPATH/main" -f "$input" -of "$input.w" --model "$WHISPERPATH/models/ggml-large.bin" -l ja "${extra_args[@]}" -osrt
}

prepwhisper() {
  local input="$1"
  local output="${input%.*}.wav"
  ffmpeg -i "$input" -ar 16000 -ac 1 -c:a pcm_s16le "$output"
}
