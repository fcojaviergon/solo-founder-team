---
name: commit-ship
version: 1.1.1
description: >
  Prepare and ship the changes. Generate commit message, create PR,
  and prepare for deploy. Includes pre-flight checks for lint and
  build. Use when the user says "ship", "commit", "PR", "push",
  "ship it", or "send it".
author: fcojaviergon
license: MIT
tags: [sdlc, git, deployment, solo-founder, shipping]
disable-model-invocation: true
---

# Ship: $ARGUMENTS

## Current context
- Branch: !`git branch --show-current`
- Status: !`git status --short`
- Diff stats: !`git diff --stat`

## Pre-flight checks

Before committing, verify:
1. Lint check on source → must pass
2. Build → must compile
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
