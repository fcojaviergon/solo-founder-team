---
name: plan-feature
description: >
  Plan a new feature. Analyze requirements, define scope,
  identify risks and generate an actionable implementation plan.
  Use when the founder says "I want to add...", "I need...",
  "plan...", "new feature", "plan".
---

# Plan Feature: $ARGUMENTS

## Instructions

You are the Tech Lead planning for a solo developer. Be pragmatic.

### Step 0: Check for PDP context
If the arguments reference a PDP file (e.g. `@docs/pdp-*.md`):
- Read the PDP and identify the relevant module(s)
- Use the WBS tasks, estimates, and dependencies as the starting point
- Pre-populate the plan with tasks from the PDP instead of creating from scratch
- Include the PDP estimated hours as reference in each task

### Step 1: Understand the Requirement
- What problem does it solve for the user?
- What is the expected behavior (happy path)?
- What edge cases matter?

### Step 2: Impact Analysis
Use Explore subagents to scan the codebase:
- What files are affected?
- Are there dependencies or conflicts?
- Are DB migrations needed?

### Step 3: Generate Plan
Write to docs/active-plan.md:

```
## Feature: [name]
**Date**: [today]
**Estimate**: [S/M/L]
**Branch**: feat/[short-name]
<!-- gh-parent:#NNN (added by Step 5 if GitHub enabled) -->

### Tasks (ordered)
1. [ ] Task 1 — affected file(s) <!-- gh:#NNN -->
2. [ ] Task 2 — affected file(s) <!-- gh:#NNN -->
...

### Risks
- Risk 1: mitigation

### Done Criteria
- [ ] Tests pass
- [ ] Build succeeds (npm run build)
- [ ] Biome check passes (npx @biomejs/biome check ./src)
- [ ] Feature works on happy path
```

### Step 4: Confirm with the Founder
Present the plan and wait for approval before implementing.
Ask: "Should I adjust anything in the plan or shall we proceed?"

### Step 5: GitHub Issues (Optional)

Check if a `.github-issues` file exists in the project root:
- If it contains `disabled` → skip this step entirely
- If it doesn't exist → ask: "Do you want to sync tasks to GitHub Issues? (y/n)"
  - If yes: create `.github-issues` file with `enabled`, verify `gh auth status`
  - If no: create `.github-issues` file with `disabled`, skip this step

If GitHub integration is enabled:
1. Ensure labels exist (create if missing):
   - `gh label create user-story --color 0075ca --force`
   - `gh label create task --color a2eeef --force`
   - `gh label create from-pdp --color fbca04 --force` (only if PDP context)
2. Create a **parent issue** for the feature:
   - Title: `[Feature] <feature name>`
   - Body: estimate, branch name, risks, done criteria from the plan
   - Labels: `user-story` (+ `from-pdp` if PDP context)
   - Command: `gh issue create --title "[Feature] ..." --body "..." --label user-story`
3. For **each task** in the plan:
   - Create a child issue:
     - Title: task description
     - Body: affected files + "Parent: #<parent-number>"
     - Labels: `task`
   - After creating, append the issue number to the task line in active-plan.md:
     - `1. [ ] Task description — files <!-- gh:#101 -->`
4. Report: "Created feature issue #100 with N task issues (#101-#10N)"
