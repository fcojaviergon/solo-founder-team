---
description: Initialize a project for the Solo Founder SDLC Kit. Creates or updates CLAUDE.md, .claude/settings.json, and docs/ structure. Auto-detects your stack. Use when setting up a new project or integrating the kit into an existing one.
argument-hint: [project-name]
---

# Initialize Project: $ARGUMENTS

You are setting up (or updating) a project for the Solo Founder SDLC Kit.

## Pre-checks

1. Verify we are at the root of a git repository (check for `.git/` directory)
2. If not at a git root, tell the user to navigate to their project root first and stop

## Step 1: Detect Project Stack

Before creating anything, scan the project to understand its stack:

1. Read `package.json` — extract name, scripts (build, test, dev, lint), dependencies
2. Read `tsconfig.json` — check if TypeScript is used, strictness
3. Read `biome.json` or `biome.jsonc` — check if Biome is configured
4. Check for `.eslintrc*` or `prettier*` — detect linter/formatter
5. Check for `requirements.txt`, `pyproject.toml`, `go.mod`, `Cargo.toml` — detect non-JS stacks
6. Check for `Dockerfile`, `docker-compose.yml` — detect containerization
7. Check for `next.config.*`, `nuxt.config.*`, `vite.config.*` — detect framework

Build a stack summary from what you find. Examples:
- "Next.js 15 + TypeScript + Tailwind + Biome + Vercel"
- "Python FastAPI + PostgreSQL + Docker"
- "Vite + React + TypeScript + ESLint"

Extract the real commands from `package.json` scripts:
- Build: whatever `scripts.build` is (e.g. `next build`, `vite build`)
- Test: whatever `scripts.test` is (e.g. `vitest`, `jest`)
- Dev: whatever `scripts.dev` is
- Lint: whatever `scripts.lint` is, or `npx @biomejs/biome check --write ./src` if Biome

## Step 2: Project Settings

Check if `.claude/settings.json` exists:

**If it does NOT exist**, create `.claude/settings.json` with permissions adapted to the detected stack:

```json
{
  "permissions": {
    "allow": [
      "Read",
      "Glob",
      "Grep",
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
      "Bash(wget * | bash)"
    ]
  }
}
```

Then add to the `allow` array based on detected stack:
- If npm/node project: add `"Bash(npm run build*)"`, `"Bash(npm run dev*)"`, `"Bash(npm run test*)"`, `"Bash(npm run lint*)"`, `"Bash(npx tsc --noEmit*)"`
- If Biome detected: add `"Bash(npx @biomejs/biome *)"` and add `"Bash(npx prettier*)"` to deny
- If Python project: add `"Bash(python *)"`, `"Bash(pip *)"`, `"Bash(pytest *)"`
- If Docker detected: add `"Bash(docker compose *)"`, `"Bash(docker build *)"`

**If it already exists**, tell the user and skip.

## Step 3: CLAUDE.md

Determine the project name: use `$ARGUMENTS` if provided, otherwise use the basename of the current directory.

### If CLAUDE.md does NOT exist

Generate it using the detected stack information. Do NOT use generic placeholders — fill in real values:

```markdown
# CLAUDE.md — {project_name}

## Project
{project_name} — {brief description from package.json or ask user}
Stack: {detected stack summary}

## Principles
- Ship small, ship often. PRs < 300 lines.
- Tests for critical business logic only. No 100% coverage mandate.
- Conventional commits: feat/ fix/ chore/ docs/ refactor/.
- Production-facing code needs error handling.
- Every repeated Claude mistake becomes a rule in Learned Rules.

## Architecture
{describe based on what you found: directory structure, layers, patterns}

## Code Conventions
{adapt based on detected stack:}
{- If TypeScript: "TypeScript strict mode"}
{- If Python: "Type hints required. Black formatting."}
{- If Go: "Standard Go conventions. gofmt."}
- English names. Comments only when they add value.
{- If React: "Components: PascalCase. Hooks: use + camelCase. Files: kebab-case.tsx"}

## Commands
{fill from actual package.json scripts or detected tools:}
- Build: `{detected build command}`
- Test: `{detected test command}`
- Dev: `{detected dev command}`
- Lint: `{detected lint command}`
- Type check: `{detected typecheck command if applicable}`

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

Important: replace ALL `{...}` with real detected values. If you cannot detect a value, ask the user.

### If CLAUDE.md ALREADY exists

Do NOT overwrite it. Instead:

1. Read the existing CLAUDE.md
2. Check which of these sections exist:
   - Principles, Workflow, Commands, Current Context, Learned Rules
3. For missing sections, generate content adapted to the detected stack
4. Present the changes to the user:
   - "Your CLAUDE.md is missing these sections that the SDLC Kit uses:"
   - Show each missing section with its generated content
   - "Want me to add them to the end of your file?"
5. If the user agrees, append only the missing sections
6. **NEVER** overwrite or modify existing sections
7. If "Commands" section exists but has different commands than detected, mention the difference but do not change it

## Step 4: Docs Structure

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

## Step 5: Report

Tell the user what was created/updated, including:
- Detected stack summary
- What was generated vs what already existed
- Remind them to review the generated CLAUDE.md and adjust anything that's off
- Available skills: /plan-feature, /implement, /test-verify, /review-code, /commit-ship, /write-docs, /triage-bug, /write-spec, /github-sync, /pdp-generator, /bootstrap-repo, /log-decision, /sprint-retro, /time-track
