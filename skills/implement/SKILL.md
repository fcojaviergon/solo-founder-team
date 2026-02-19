---
name: implement
description: >
  Implement tasks from the active plan. Read docs/active-plan.md and
  execute the next pending user story. Follow project conventions.
  Use when the founder says "implement", "code", "next task",
  "move forward", "develop".
---

# Implement: $ARGUMENTS

## Before implementing

1. If the project has custom frontend or backend skills in
   .claude/skills/, load them first and follow their conventions
   as priority over the generic ones.
2. Read CLAUDE.md for general project context.

## Instructions

1. Read docs/active-plan.md to understand the full context
2. Identify the next pending user story — look for the first story
   that still has unchecked `- [ ]` acceptance criteria
3. **GitHub Issue (Optional)**: If `.github-issues` contains `enabled`:
   - Extract issue number from the story: look for `<!-- gh:#NNN -->`
   - If found: `gh issue comment NNN --body "Starting implementation"`
4. Create branch if it doesn't exist: `git checkout -b feat/[name]`
5. Implement the story:
   - Read ALL acceptance criteria before writing any code
   - Implement to satisfy each criterion — they are your definition of done
   - After each modified file, verify it compiles:
     - `npx @biomejs/biome check --write [file]`
     - `npx tsc --noEmit` (if applicable)
6. Mark each acceptance criterion as completed `[x]` in active-plan.md
   as you satisfy it
7. **GitHub Issue (Optional)**: If issue was linked in step 3:
   - `gh issue comment NNN --body "Completed: [brief summary of what was done]"`
   - Do NOT close the issue — that happens when the PR is created via /commit-ship
8. Report:
   - Which story you implemented (US-X.Y)
   - Which acceptance criteria are now passing
   - What files you touched
   - What's the next story

## Rules
- Incremental changes. One commit per user story.
- If a story is too large, split it and update the plan.
- If you find an existing bug, don't fix it now.
  Create a note in docs/bugs-found.md.
- Conventional commits: feat(scope): description
- When finishing the last story in the plan, run:
  1. `npx @biomejs/biome check ./src`
  2. `npm run build`
  Both must pass before considering the implementation complete.
