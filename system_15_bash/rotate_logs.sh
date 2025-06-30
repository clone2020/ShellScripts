#!/bin/bash

LOG_DIR=${1:-"/var/log/myapp"}
ROTATE_DIR=${2:-"/var/log/archived"}
DAYS_OLD=${3:-7}
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

mkdir -p "$ROTATE_DIR"

echo "Rotating Logs in $LOG_DIR older than $DAYS_OLD days to $ROTATE_DIR"

find "$LOG_DIR" -type f -mtime +$DAYS_OLD -exec sh -c '
    for file do
        if [ -f "$file" ]; then
            base_name=$(basename "$file")
            new_name="${base_name%.*}_$TIMESTAMP.${base_name##*.}"
            gzip -c "$file" > "$ROTATE_DIR/$new_name.gz"
            rm "$file"
            echo "Rotated $file to $ROTATE_DIR/$new_name.gz"
        else
            echo "Skipping $file, not a regular file."
        fi
    done
    ' sh {} +
echo "Log rotation completed."
# Usage: ./rotate_logs.sh [Log_Directory] [Archive Directory] [Days Old]
# Example: ./rotate_logs.sh /var/log/myapp /var/log/archived 7

