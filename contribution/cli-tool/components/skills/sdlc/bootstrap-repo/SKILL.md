---
name: bootstrap-repo
version: 1.1.1
description: >
  Analyze a complete repository and generate an executive summary of its
  architecture, stack, patterns, and current state. Use when opening
  a project for the first time, resuming after a while, or needing
  quick context. Trigger: "analyze this repo", "onboarding",
  "what's here", "give me context", "bootstrap".
author: fcojaviergon
license: MIT
tags: [sdlc, onboarding, architecture, solo-founder, analysis]
context: fork
agent: Explore
allowed-tools: Read, Grep, Glob, Bash
---

# Repository Bootstrap

You are an architect doing onboarding to a new repo.
Generate an executive summary in < 2 minutes of reading.

## Steps

1. **Stack**
   - package.json / requirements.txt / go.mod / Cargo.toml
   - Frameworks (Next.js, Django, Spring, etc.)
   - Database (migrations, schemas, prisma)

2. **Structure**
   - First and second level directories
   - Architectural pattern (MVC, Clean Arch, Monolith, Microservices)
   - File count by type

3. **Patterns**
   - Auth: JWT, sessions, OAuth?
   - API: REST, GraphQL, tRPC?
   - State: Redux, Zustand, Context?
   - Testing: Jest, Vitest, Pytest? Coverage?
   - Linting: Biome, ESLint, Prettier?

4. **Status**
   - `git log --oneline -10`
   - CI/CD configured?
   - Visible tech debt (TODOs, hacks)
   - Tests pass?
   - Build compiles?

5. **Output** → docs/repo-overview.md

```
# Repo Overview: [name]
**Generated**: [date]

## Stack
Frontend: [...] | Backend: [...] | DB: [...] | Infra: [...]

## Architecture
[2-3 lines + ASCII diagram]

## Main Modules
- /src/[module1]: [what it does]
- /src/[module2]: [what it does]

## Current Status
- Last commit: [date + message]
- Tests: [pass/fail/none]
- Build: [compiles/fails/not configured]
- Lint: [tool/none]
- CI/CD: [yes/no]
- Tech debt: [high/medium/low]

## Points of Attention
- [point 1]
- [point 2]
```
