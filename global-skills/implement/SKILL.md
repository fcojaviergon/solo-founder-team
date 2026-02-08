---
name: implement
description: >
  Implement tasks from the active plan. Read docs/active-plan.md and
  execute the next pending task. Follow project conventions.
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
2. Identify the next pending task ([ ])
3. Create branch if it doesn't exist: `git checkout -b feat/[name]`
4. Implement following the project conventions
5. After each modified file, verify it compiles:
   - `npx @biomejs/biome check --write [file]`
   - `npx tsc --noEmit` (if applicable)
6. Mark the task as completed [x] in active-plan.md
7. Report: what you did, what files you touched, what's next

## Rules
- Incremental changes. One commit per task.
- If a task is too large, split it and update the plan.
- If you find an existing bug, don't fix it now.
  Create a note in docs/bugs-found.md.
- Conventional commits: feat(scope): description
- When finishing the last task in the plan, run:
  1. `npx @biomejs/biome check ./src`
  2. `npm run build`
  Both must pass before considering the implementation complete.
