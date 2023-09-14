@echo off

set /p inputVideo="Enter the name of the video file (e.g., input.mkv, input.mp4): "

echo.
echo Displaying stream information for %inputVideo%:
echo.

ffmpeg -hide_banner -i "%inputVideo%" 2>&1 | findstr "Stream"

echo.
set /p subtitleIndex="Enter the subtitle stream index (should look like #0:X where X is the index): "

:: Extract filename and extension
for %%a in ("%inputVideo%") do (
    set "filename=%%~na"
    set "extension=%%~xa"
)

:: Extract and save the subtitle
ffmpeg -hide_banner -i "%inputVideo%" -map "%subtitleIndex%" "%filename%_%subtitleIndex%.ass"

:: Burn the subtitle into the video
ffmpeg -hwaccel auto -i "%inputVideo%" -map 0 -vf "subtitles='%inputVideo%:si=%subtitleIndex%'" -preset ultrafast -c:a copy "%filename%_hardsub3%extension%"

echo.
echo Operation completed.
