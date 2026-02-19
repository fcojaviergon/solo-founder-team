#!/bin/bash
# Auto-format edited files with Biome (no-op if Biome is not installed)

command -v npx >/dev/null 2>&1 || exit 0

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "
import json, sys
d = json.load(sys.stdin)
p = d.get('tool_input', {}).get('file_path', '') or d.get('tool_response', {}).get('filePath', '')
print(p)
" 2>/dev/null)

[ -z "$FILE_PATH" ] && exit 0

case "$FILE_PATH" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.css)
    npx @biomejs/biome check --write "$FILE_PATH" 2>/dev/null || true
    ;;
esac

exit 0
