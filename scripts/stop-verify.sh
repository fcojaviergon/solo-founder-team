#!/bin/bash
# Background verification on session stop: Biome check + build
# Runs async — does not block Claude

command -v npx >/dev/null 2>&1 || exit 0

(
  if [ -d "./src" ]; then
    npx @biomejs/biome check ./src --no-errors-on-unmatched > /tmp/biome-report.txt 2>&1 || true
  fi
  npm run build --if-present > /tmp/build-report.txt 2>&1 || true
  echo "$(date +%Y-%m-%dT%H:%M:%S) STOP" >> ~/.claude/session-log.txt
) &

exit 0
