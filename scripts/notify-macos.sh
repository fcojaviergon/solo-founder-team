#!/bin/bash
# macOS notifications via osascript (gracefully no-op on non-macOS)

case "$1" in
  finished)
    osascript -e 'display notification "Claude has finished" with title "Claude Code"' 2>/dev/null || true
    ;;
  attention)
    osascript -e 'display notification "Claude needs your attention" with title "Claude Code"' 2>/dev/null || true
    ;;
esac

exit 0
