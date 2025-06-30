#!/bin/bash

echo "Cleaning up dangling Docker container and images..."
docker image prune -f

echo "Remove unused Docker volumes..."
docker volume prune -f

echo "Removing stopped containers..."
docker container prune -f

echo "Removing unused networks..."
docker network prune -f

echo "Docker cleanup completed successfully."
if [ $? -ne 0 ]; then
    echo "Docker cleanup encountered an error. Please check the Docker service status."
    exit 1
fi
echo "You can check the Docker service status using the command: systemctl status docker"
echo "For more details, you can view the Docker logs using: journalctl -u docker"
echo "Cleanup script executed successfully."
exit 0