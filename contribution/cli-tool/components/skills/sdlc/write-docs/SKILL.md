---
name: write-docs
version: 1.1.1
description: >
  Generate or update project documentation. README, API docs,
  architecture decisions. Focuses on what a solo founder needs:
  documentation for future self and for Claude Code context.
  Use when the user says "document", "README", "docs", or "documentation".
author: fcojaviergon
license: MIT
tags: [sdlc, documentation, solo-founder, readme, architecture]
---

# Document: $ARGUMENTS

## Instructions

As a solo founder, documentation has two audiences:
1. **You in 3 months** (when you forget how something works)
2. **Claude Code** (to maintain context in future sessions)

### Types of documentation

- **README.md**: Setup, how to run, how to deploy, environment variables
- **docs/architecture.md**: Stack, technical decisions, Mermaid diagram
- **docs/decisions/**: ADRs for important decisions (use /log-decision)
- **CLAUDE.md**: Rules for Claude (update when something new is learned)
- **Inline comments**: Only for "why", never for "what"

### Golden rule
Document what is not obvious from the code.
Don't document what TypeScript already expresses.

### For README.md always include:
```
## Setup
1. Clone repo
2. Install dependencies
3. Copy .env.example to .env and configure variables
4. Run development server

## Available scripts
- dev — local development
- build — production build
- lint — linter check
- test — run tests

## Stack
[list of technologies with versions]

## Architecture
[diagram or brief description]
```
