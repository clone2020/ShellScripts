#!/bin/bash

URL=${1:-"https://example.com"}
EXPECTED_STATUS=${2:-200}
echo "Checking URL: $URL for expected status: $EXPECTED_STATUS"
response=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
if [ "$response" -eq "$EXPECTED_STATUS" ]; then
    echo "URL $URL is healthy. Status code: $response"
else
    echo "URL $URL is not healthy. Expected status code: $EXPECTED_STATUS, but got: $response"
    exit 1
fi
echo "URL health check completed successfully."
exit 0
# Usage: ./url_health_check.sh <URL> <EXPECTED_STATUS>
# Example: ./url_health_check.sh https://example.com 200