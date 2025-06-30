#!/bin/bash

LOG_FILE="update_log_$(date +%Y%m%d).txt"
echo "Starting safe upgrade process..."
{
    echo "Updating package lists..."
    sudo apt-get update | tee -a "$LOG_FILE"
    sleep 5

    echo "Upgrading installed packages..."
    sudo apt-get update -y | tee -a "$LOG_FILE"
    if [ $? -ne 0 ]; then
        echo "Failed to update packages. Please check your network connection or package sources."
        exit 1
    fi

    echo "Performing safe upgrade..."
    sudo apt-get dist-upgrade -y | tee -a "$LOG_FILE"
    if [ $? -ne 0 ]; then
        echo "Failed to perform safe upgrade. Please check your network connection or package sources."
        exit 1
    fi

    echo "Upgrading distribution..."
    sudo apt-get full-upgrade -y | tee -a "$LOG_FILE"
    if [ $? -ne 0 ]; then
        echo "Failed to upgrade distribution. Please check your network connection or package sources."
        exit 1
    fi
    
    echo "Removing unnecessary packages..."
    echo "Safe upgrade completed successfully."
    echo "Cleaning up unused packages..."
    sudo apt-get autoremove -y | tee -a "$LOG_FILE"
    sudo apt-get autoclean -y | tee -a "$LOG_FILE"
    sleep 5
    echo "Cleaning up completed."
    echo "Cleaning up unused packages..."
    if [ $? -ne 0 ]; then
        echo "Failed to clean up unused packages. Please check your network connection or package sources."
        exit 1
    fi
    echo "Safe upgrade completed successfully."
}