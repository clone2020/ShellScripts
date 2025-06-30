#!/bin/bash

COMMIT_MSG=${1:-"auto-commit: $(date)"}

echo "Adding Changes..."
git add .

echo "Committing with message: $COMMIT_MSG"
git commit -m "$COMMIT_MSG"

echo "Push to remote..."
git push

echo "Done!"
