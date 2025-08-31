#!/bin/bash
cd /Users/nirvanaflame/Documents/Workspace/daily-commit
echo "Last run: $(date)" > last-run.txt
git add .
git commit -m "Daily commit - $(date)"
git push origin main