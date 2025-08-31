#!/bin/bash

# -----------------------------
# Auto Git Commit Script (MacOS)
# -----------------------------

# Full path to your repo
REPO_PATH="/Users/nirvanaflame/Documents/Workspace/daily-commit"

# Log file location
LOG_FILE="$HOME/auto_commit.log"

# Go to repo folder
cd "$REPO_PATH" || exit

# Record script start time
echo "=============================" >> "$LOG_FILE"
echo "Script ran at $(date)" >> "$LOG_FILE"

# Add changes
/usr/bin/git add . >> "$LOG_FILE" 2>&1

# Commit changes
COMMIT_MESSAGE="Automated commit $(date +"%Y-%m-%d %H:%M:%S")"
/usr/bin/git commit -m "$COMMIT_MESSAGE" >> "$LOG_FILE" 2>&1

# Check if commit succeeded
if git diff-index --quiet HEAD --; then
    echo "No changes to commit" >> "$LOG_FILE"
    osascript -e 'display notification "No changes to commit" with title "Auto Commit"'
else
    # Push to GitHub
    /usr/bin/git push origin main >> "$LOG_FILE" 2>&1
    echo "Changes pushed to GitHub" >> "$LOG_FILE"
    osascript -e 'display notification "Changes pushed to GitHub" with title "Auto Commit"'
fi