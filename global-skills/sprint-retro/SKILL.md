---
name: sprint-retro
description: >
  Generate a mini-retrospective for the sprint or work period. Analyze
  what was done, what went well/badly, and propose improvements to
  CLAUDE.md and workflow. Use at the end of each week or sprint.
  Trigger: "retro", "retrospective", "what did we learn", "week review".
context: fork
agent: Explore
allowed-tools: Read, Grep, Glob, Bash
---

# Sprint Retro

## Steps

1. **Gather data**
   - `git log --oneline --since="1 week ago"` (or indicated period)
   - docs/active-plan.md: completed vs. planned
   - Recent docs/decisions/
   - `grep -r "TODO\|FIXME\|HACK" src/` (new this week)

2. **Analyze**
   - Tasks that took longer than estimated — why?
   - Bugs or regressions — what caused them?
   - Repeated Claude mistakes → candidates for CLAUDE.md rules
   - Build failures — common causes?

3. **Generate** docs/retros/YYYY-MM-DD-retro.md

```markdown
# Retro: [Date]

## Metrics
- Commits: [N]
- Tasks completed: [X of Y]
- Bugs found/resolved: [N/N]
- Build failures: [N]

## What Worked
- [thing 1]

## What Didn't Work
- [thing 1]: [why] → [action]

## Workflow Improvements
- [ ] Add to CLAUDE.md: "[rule]"
- [ ] Create/modify skill: [which]
- [ ] Add/adjust hook: [which]

## Carry-over
- [pending task]
```

4. **Propose CLAUDE.md updates**
   If there are repeated mistakes, propose new rules
   and ask for confirmation before editing.

5. **If there's a timesheet (docs/timesheet.csv)**
   Compare actual MH vs. estimated by module.
   Update the PDP estimation-reference.md if the
   deviation is consistent (>20% on the same task type).
