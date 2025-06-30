#!/bin/bash

SERVICE_NAME=${1:-"nginx"}

echo "Checking status of $SERVICE_NAME service..."

if systemctl is-active --quiet "$SERVICE_NAME"; then
    echo "$SERVICE_NAME service is running fine."
else
    echo "$SERVICE_NAME service is not running. Attempting to restart..."
    if systemctl restart "$SERVICE_NAME"; then
        echo "$SERVICE_NAME service has been restarted successfully."
    elif systemctl is-active --quiet "$SERVICE_NAME"; then
        echo "$SERVICE_NAME service is now running after restart."
    else
        echo "Failed to restart $SERVICE_NAME service. Please check the service Logs for more details."
        echo "You can check the Logs using the command: journalctl -u $SERVICE_NAME"
        exit 1
    fi
fi
echo "Status check completed for $SERVICE_NAME service."
