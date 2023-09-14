@echo off
for %%a in (*.srt) do (
    ffmpeg -itsoffset 44.5 -i "%%~na.srt" -c copy "%%~na_synced.srt"
)
