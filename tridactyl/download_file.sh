#!/bin/bash
TARGET_DIR="$HOME/Downloads"
mkdir -p "$TARGET_DIR"
IMAGE_URL="$1"
if [ -z "$IMAGE_URL" ]; then
    notify-send -i "error" "No URL provided for download"
    exit 1
fi
FILENAME=$(basename "$IMAGE_URL" | cut -d'?' -f1)
notify-send -i "info" "Starting download for $FILENAME"
curl -Is "$IMAGE_URL" > /dev/null 2>&1 ||
    { notify-send -i "error" "Invalid URL"; exit 1; }
wget -O "$TARGET_DIR/$FILENAME" "$IMAGE_URL" && \
    notify-send -i "info" "Completed download for $FILENAME" || \
    notify-send -i "error" "Download failed for $FILENAME"
