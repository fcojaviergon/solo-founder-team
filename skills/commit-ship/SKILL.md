---
name: commit-ship
description: >
  Prepare and ship the changes. Generate commit message, create PR,
  and prepare for deploy. Use when the founder says "ship",
  "commit", "PR", "push", "ship it", "send it".
disable-model-invocation: true
---

# Ship: $ARGUMENTS

## Current context
- Branch: !`git branch --show-current`
- Status: !`git status --short`
- Diff stats: !`git diff --stat`

## Pre-flight checks

Before committing, verify:
1. `npx @biomejs/biome check ./src` → must pass
2. `npm run build` → must compile
If either fails, fix first. DO NOT ship broken code.

## Instructions

1. Stage the appropriate changes (git add)
2. Generate commit message with Conventional Commits:
   - Analyze the diff to determine the type (feat/fix/chore/docs/refactor)
   - Scope based on the main affected folder
   - Clear and concise description in English
   - Optional body if the change is complex
3. Commit
4. Push to origin
5. Create PR with:
   - Title = commit message
   - Body = summary of changes + link to plan if exists
   - Appropriate labels if the repo uses them
6. **GitHub Issues Linking (Optional)**: If `.github-issues` contains `enabled`:
   - Read docs/active-plan.md
   - Extract all issue numbers from completed tasks: lines with `[x]` and `<!-- gh:#NNN -->`
   - Append `Closes #101, closes #102, ...` to the PR body
     (GitHub auto-closes these issues when the PR is merged)
   - If there's a parent feature issue (look for `<!-- gh-parent:#NNN -->` in active-plan.md header):
     - `gh issue comment NNN --body "Shipped in PR #<pr-number>"`
7. Report: PR URL, linked issues, and suggest next step
   - If this was a significant feature or release, suggest: "Run `/changelog` to generate release notes"

## Rules
- If the diff is > 500 lines, STOP and ask if we should
  split into smaller commits
- Do not include build files (.next/, dist/, node_modules/)
- Do not include .env or secrets
- If there are new untracked files that look temporary, ask
