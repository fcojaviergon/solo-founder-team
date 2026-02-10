---
name: triage-bug
description: >
  Diagnose and classify a bug. Find the root cause and propose
  a fix. Use when the founder reports an error, bug, or something
  that doesn't work. Trigger: "bug", "error", "doesn't work",
  "broken", "fails", "crash".
---

# Triage Bug: $ARGUMENTS

## Instructions

1. **Reproduce**: Understand the steps to reproduce
2. **Locate**: Use grep/search to find relevant code
3. **Diagnose**: Identify the root cause (not the symptom)
4. **Classify**:
   - CRITICAL: Affects all users, data loss, security
   - HIGH: Broken feature for many users
   - MEDIUM: Visible bug with workaround
   - LOW: Cosmetic or rare edge case
5. **Propose fix**: Describe the necessary change with affected files
6. **Verify**: After the fix, run:
   - Relevant tests
   - `npx @biomejs/biome check ./src`
   - `npm run build`
7. **Ask**: "Should I fix it now or schedule it?"

If CRITICAL: don't ask, fix it directly.

## Log
Add the bug in docs/bugs-found.md:
```
### [date] - [short title]
- **Severity**: [CRITICAL/HIGH/MEDIUM/LOW]
- **Symptom**: [what is observed]
- **Root cause**: [why it happens]
- **Fix**: [what was done / what needs to be done]
- **Files**: [affected files]
<!-- gh:#NNN -->
```

## GitHub Issue (Optional)

If `.github-issues` contains `enabled`:
1. Ensure label exists: `gh label create bug --color d73a4a --force`
2. If severity is **CRITICAL** → create issue automatically (don't ask)
3. Otherwise ask: "Create a GitHub issue for this bug?"
4. If yes:
   - `gh issue create --title "[Bug] <short title>" --body "**Severity**: ...\n**Symptom**: ...\n**Root cause**: ...\n**Proposed fix**: ...\n**Files**: ..." --label bug`
5. Append `<!-- gh:#NNN -->` to the bug entry in bugs-found.md
6. If the bug was fixed immediately, close the issue:
   - `gh issue close NNN --comment "Fixed in commit <sha>"`
