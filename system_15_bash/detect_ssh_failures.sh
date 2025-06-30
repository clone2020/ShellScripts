#!/bin/bash

LOG_FILE="/var/log/auth.log"
OUTPUT_FILE="ssh_failures_${HOSTNAME}_$(date +%Y%m%d).txt"

echo "Detecting SSH failures in $LOG_FILE..."
grep "sshd.*Failed password" "$LOG_FILE" | awk '{print $1, $2, $3, $9, $11}' | sort | uniq -c | sort -nr > "$OUTPUT_FILE"
echo "SSH failure report saved to $OUTPUT_FILE"
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file $LOG_FILE does not exist."
    exit 1
fi