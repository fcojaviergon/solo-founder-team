---
name: triage-bug
version: 1.1.1
description: >
  Diagnose and classify a bug. Find the root cause and propose a fix.
  Logs bugs in docs/bugs-found.md for tracking. Use when the user
  reports an error, bug, or something that doesn't work. Trigger:
  "bug", "error", "doesn't work", "broken", "fails", "crash".
author: fcojaviergon
license: MIT
tags: [sdlc, debugging, bug-triage, solo-founder, diagnostics]
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
   - Lint check
   - Build
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
```
