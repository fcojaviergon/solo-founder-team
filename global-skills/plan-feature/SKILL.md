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

### Tasks (ordered)
1. [ ] Task 1 — affected file(s)
2. [ ] Task 2 — affected file(s)
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
