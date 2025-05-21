#!/bin/bash

OPTIONS="Downloads\nPDF\nVideos\nPictures"

CHOICE=$(echo -e "$OPTIONS" | dmenu -i -p "Select download directory:" | cut -d'|' -f1)

case "$CHOICE" in
    "Downloads")
        TARGET_DIR="$HOME/Downloads"
        ;;
    "PDF")
        TARGET_DIR="$HOME/PDF"
        ;;
    "Videos")
        TARGET_DIR="$HOME/Videos"
        ;;
    "Pictures")
        TARGET_DIR="$HOME/Pictures/Saved Pictures"
        ;;
    *)
        notify-send -i "error" "Download canceled."
        exit 1
        ;;
esac

mkdir -p "$TARGET_DIR" || { notify-send -i "error" "Failed to create directory."; exit 1; }

FILE_URL="$1"
if [ -z "$FILE_URL" ]; then
    notify-send -i "error" "No URL provided for download."
    exit 1
fi

FILENAME=$(basename "$FILE_URL" | cut -d'?' -f1)
notify-send -i "info" "Starting download for $FILENAME"
curl -Is "$FILE_URL" > /dev/null 2>&1 ||
    { notify-send -i "error" "Invalid URL"; exit 1; }
wget -O "$TARGET_DIR/$FILENAME" "$FILE_URL" && \
    notify-send -i "info" "Completed download for $FILENAME." || \
    notify-send -i "error" "Download failed for $FILENAME."
