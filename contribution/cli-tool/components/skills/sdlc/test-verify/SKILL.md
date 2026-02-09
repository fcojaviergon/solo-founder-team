---
name: test-verify
version: 1.1.1
description: >
  Write tests and verify the implementation works. Includes build and
  lint verification. Runs as a forked subagent to avoid polluting
  the main context. Use after implementing, or when the user says
  "test", "verify", "check", or "does it work?".
author: fcojaviergon
license: MIT
tags: [sdlc, testing, verification, solo-founder, qa]
context: fork
agent: general-purpose
allowed-tools: Read, Grep, Glob, Bash, Write
---

# Verify Implementation

## Instructions

1. Read docs/active-plan.md to understand the done criteria
2. Identify what was implemented by reviewing recent changes:
   - `git diff main --name-only`
3. For each modified component/function:
   - Does it have a test? If not, write one for the happy path
   - Does the test cover the most dangerous edge case? Add if not
4. Run the full test suite
5. If there are errors, fix the code (not the test)

## Build & Lint Verification (MANDATORY)

After tests pass, run in this order:

1. **Lint check**: Run linter on src/ directory
   - If formatting errors: auto-fix
   - If lint errors: fix manually

2. **Type check** (if applicable):
   - Fix all type errors

3. **Build**: Run build command
   - If it fails, analyze the error and fix

4. Only if all 3 pass → report as verified

## Testing Philosophy (Solo Founder)
- Unit tests for pure business logic
- Integration tests for critical flows (auth, payments, data mutations)
- NO tests for: pure UI components, layouts, styles
- One test that catches a real bug > 10 superficial coverage tests

## Output
Report:
- Tests written and result
- Lint check status
- Type check status
- Build status
- Verdict: VERIFIED or PENDING [reason]
