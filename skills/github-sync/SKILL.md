---
name: github-sync
description: >
  Sync tasks and bugs with GitHub Issues. Push untracked tasks as issues,
  check sync status, or close completed issues. Requires GitHub CLI (gh)
  and a `.github-issues` file with `enabled` in the project root.
  Trigger: "github sync", "sync issues", "push issues", "issue status".
---

# GitHub Sync: $ARGUMENTS

## Pre-check

1. Verify `.github-issues` file exists and contains `enabled`
   - If not found or disabled: "GitHub Issues integration is not enabled for this project.
     Run /plan-feature or /triage-bug to enable it, or create `.github-issues` with `enabled`."
2. Verify `gh auth status` succeeds
   - If not: "GitHub CLI not authenticated. Run: `gh auth login`"
3. Verify we're in a git repo with a GitHub remote
   - If not: "No GitHub remote found. Add one with: `git remote add origin <url>`"

## Commands

### `/github-sync push` — Push untracked tasks to GitHub

1. Read `docs/active-plan.md`
2. Find all task lines (`[ ]` or `[x]`) that do NOT have `<!-- gh:#NNN -->`
3. For each untracked task:
   - Create a GitHub issue: `gh issue create --title "<task>" --label task`
   - Append `<!-- gh:#NNN -->` to the task line
4. Report: "Created N issues. All tasks are now tracked."

### `/github-sync push-bugs` — Push untracked bugs to GitHub

1. Read `docs/bugs-found.md`
2. Find bug entries that do NOT have `<!-- gh:#NNN -->`
3. For each untracked bug:
   - Create issue with label `bug`
   - Append `<!-- gh:#NNN -->` to the bug entry
4. Report: "Created N bug issues."

### `/github-sync status` — Show sync overview

1. Read `docs/active-plan.md` and count:
   - Total tasks, tracked (with `gh:#`), untracked (without)
   - Completed `[x]` with open issues (should be closed)
   - Pending `[ ]` with closed issues (mismatch)
2. Read `docs/bugs-found.md` and count tracked/untracked bugs
3. Show summary table:

```
| Source          | Total | Tracked | Untracked | Mismatches |
|-----------------|-------|---------|-----------|------------|
| active-plan.md  | 8     | 6       | 2         | 0          |
| bugs-found.md   | 3     | 1       | 2         | 0          |
```

4. If mismatches: suggest `/github-sync close-done` or manual fixes

### `/github-sync close-done` — Close issues for completed tasks

1. Read `docs/active-plan.md`
2. Find all lines with `[x]` AND `<!-- gh:#NNN -->`
3. For each: check if issue is still open with `gh issue view NNN --json state`
4. If open: `gh issue close NNN --comment "Completed in local plan"`
5. Report: "Closed N issues."

## Rules
1. Never create duplicate issues — always check for existing `<!-- gh:#NNN -->` first
2. Never close issues that correspond to pending `[ ]` tasks
3. All operations are idempotent — safe to run multiple times
