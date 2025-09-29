#!/bin/bash

# -----------------------------
# Auto Git Commit Script (MacOS)
# -----------------------------

REPO_PATH="/Users/nirvanaflame/Documents/Workspace/daily-commit"
LOG_FILE="$HOME/auto_commit.log"
TIMESTAMP_FILE="$REPO_PATH/timestamp.js"

cd "$REPO_PATH" || exit

echo "=============================" >> "$LOG_FILE"
echo "Script ran at $(date)" >> "$LOG_FILE"

# Write timestamp to timestamp.js
echo "console.log(\"$(date +'%Y-%m-%d %H:%M:%S')\")" > "$TIMESTAMP_FILE"

# Add changes
git add . >> "$LOG_FILE" 2>&1

# Check for staged changes
if [[ -n $(git status --porcelain) ]]; then
    COMMIT_MESSAGE="Automated commit $(date +"%Y-%m-%d %H:%M:%S")"
    git commit -m "$COMMIT_MESSAGE" >> "$LOG_FILE" 2>&1
    git push origin main >> "$LOG_FILE" 2>&1
    echo "$(date +"%Y-%m-%d %H:%M:%S")"
    echo "Changes pushed to GitHub" >> "$LOG_FILE"
    osascript -e 'display notification "Changes pushed to GitHub" with title "Auto Commit"'
else
    echo "No changes to commit" >> "$LOG_FILE"
    osascript -e 'display notification "No changes to commit" with title "Auto Commit"'
fi