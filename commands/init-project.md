---
description: Initialize a project for the Solo Founder SDLC Kit. Creates CLAUDE.md, .claude/settings.json, and docs/ structure. Use when setting up a new project or updating an existing one.
argument-hint: [project-name]
---

# Initialize Project: $ARGUMENTS

You are setting up (or updating) a project for the Solo Founder SDLC Kit.

## Pre-checks

1. Verify we are at the root of a git repository (check for `.git/` directory)
2. If not at a git root, tell the user to navigate to their project root first and stop

## Step 1: Project Settings

Check if `.claude/settings.json` exists:

**If it does NOT exist**, create `.claude/settings.json` with these permissions:

```json
{
  "permissions": {
    "allow": [
      "Read",
      "Glob",
      "Grep",
      "Bash(npx @biomejs/biome *)",
      "Bash(npm run build*)",
      "Bash(npm run dev*)",
      "Bash(npm run test*)",
      "Bash(npm run lint*)",
      "Bash(npx tsc --noEmit*)",
      "Bash(git status*)",
      "Bash(git diff*)",
      "Bash(git log*)",
      "Bash(git add*)",
      "Bash(git commit*)",
      "Bash(git push*)",
      "Bash(git checkout*)",
      "Bash(git branch*)",
      "Bash(cat *)",
      "Bash(ls *)",
      "Bash(find *)",
      "Bash(wc *)",
      "Bash(head *)",
      "Bash(tail *)",
      "Bash(mkdir *)",
      "Bash(cp *)"
    ],
    "deny": [
      "Bash(rm -rf *)",
      "Bash(sudo *)",
      "Bash(chmod 777*)",
      "Bash(curl * | bash)",
      "Bash(wget * | bash)",
      "Bash(npx prettier*)"
    ]
  }
}
```

**If it already exists**, tell the user it already exists and skip this step.

## Step 2: CLAUDE.md

Determine the project name: use `$ARGUMENTS` if provided, otherwise use the basename of the current directory.

### If CLAUDE.md does NOT exist

Create it with this content, replacing `[PROJECT_NAME]` with the project name:

```markdown
# CLAUDE.md — [PROJECT_NAME]

## Project
[PROJECT_NAME] — [Brief description of what this project does]
Stack: [e.g.: Next.js 15 + Supabase + Tailwind + Vercel]

## Principles
- Ship small, ship often. PRs < 300 lines.
- Tests for critical business logic only. No 100% coverage mandate.
- Conventional commits: feat/ fix/ chore/ docs/ refactor/.
- Production-facing code needs error handling.
- Every repeated Claude mistake becomes a rule in Learned Rules.

## Architecture
[Describe your architectural pattern: monolith, modular monolith, microservices, etc.]
[Main layers: API routes, services, repositories, components, etc.]
See docs/architecture.md for detailed decisions.

## Code Conventions
- TypeScript strict mode
- English names. Comments only when they add value.
- Components: PascalCase. Hooks: use + camelCase.
- Files: kebab-case.tsx

## Commands
- Lint: `npx @biomejs/biome check --write ./src`
- Build: `npm run build`
- Test: `npm run test`
- Type check: `npx tsc --noEmit`
- Dev: `npm run dev`

## Project Skills
Custom per-project conventions in .claude/skills/:
- Frontend: .claude/skills/frontend/SKILL.md
- Backend: .claude/skills/backend/SKILL.md

## Workflow
Spec (complex only) -> Plan -> Implement -> Test -> Review -> Ship
- /write-spec — only for features touching 10+ files or with integrations
- /plan-feature — generates user stories with acceptance criteria
- /implement — executes next pending story
- /test-verify — runs tests, build, lint in isolation
- /review-code — code review for bugs, security, simplicity
- /commit-ship — commit + PR

## Current Context
- Active plan: docs/active-plan.md
- Specs: specs/
- Decisions: docs/decisions/

## Learned Rules
<!-- Claude adds rules here when it makes a mistake that should not repeat -->
```

### If CLAUDE.md ALREADY exists

Do NOT overwrite it. Instead, perform a smart update:

1. Read the existing CLAUDE.md
2. Identify which of the expected sections exist:
   - Project, Principles, Architecture, Code Conventions, Commands, Project Skills, Workflow, Current Context, Learned Rules
3. Report to the user:
   - "Your CLAUDE.md has these sections: [list]"
   - "Missing sections that could be useful: [list]"
4. Ask the user: "Would you like me to add the missing sections? I will append them without modifying your existing content."
5. If the user agrees, append only the missing sections at the end of the file
6. **NEVER** overwrite or modify existing sections — the user's Architecture, Learned Rules, and other customized content is sacred
7. Optionally offer to clean up formatting (consistent heading levels, trailing whitespace, etc.) but only if the user explicitly asks

## Step 3: Docs Structure

Create these directories and files only if they don't already exist:

- `docs/` directory
- `docs/decisions/` directory
- `docs/retros/` directory
- `specs/` directory

Files (only if missing):

- `docs/active-plan.md`:
  ```
  # Active Plan

  No active plan. Use /plan-feature to create one.
  ```

- `docs/decisions/README.md`:
  ```
  # Technical Decisions (ADRs)

  | # | Date | Decision | Status |
  |---|------|----------|--------|
  | | | | |
  ```

- `docs/bugs-found.md`:
  ```
  # Bugs Found

  Log maintained by /triage-bug skill.
  ```

- `docs/timesheet.csv`:
  ```
  date,project,module,task,actual_mh,estimated_mh,notes
  ```

## Step 4: Report

Tell the user what was created/updated. Then remind them:

1. Edit `CLAUDE.md` with your stack, architecture, and conventions
2. Add project-specific skills in `.claude/skills/` if needed
3. Available skills: /plan-feature, /implement, /test-verify, /review-code, /commit-ship, /write-docs, /triage-bug, /write-spec, /github-sync, /pdp-generator, /bootstrap-repo, /log-decision, /sprint-retro, /time-track
