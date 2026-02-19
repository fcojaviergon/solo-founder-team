#!/bin/bash
# Block writes to protected paths (.env, .git/, node_modules/, .next/, dist/)
# Exit code 2 = block the tool use

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "import json,sys;d=json.load(sys.stdin);print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null)

[ -z "$FILE_PATH" ] && exit 0

for pattern in '.env' '.git/' 'node_modules/' '.next/' 'dist/'; do
  if echo "$FILE_PATH" | grep -q "$pattern"; then
    echo "BLOCKED: Cannot write to protected path containing '$pattern'" >&2
    exit 2
  fi
done

exit 0
