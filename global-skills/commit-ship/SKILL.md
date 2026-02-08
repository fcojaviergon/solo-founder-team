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
6. Report: PR URL and recommended next step

## Rules
- If the diff is > 500 lines, STOP and ask if we should
  split into smaller commits
- Do not include build files (.next/, dist/, node_modules/)
- Do not include .env or secrets
- If there are new untracked files that look temporary, ask
