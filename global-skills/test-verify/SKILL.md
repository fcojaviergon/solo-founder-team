---
name: test-verify
description: >
  Write tests and verify the implementation works.
  Includes build and biome verification.
  Use after implementing, or when the founder says
  "test", "verify", "check", "does it work?".
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

1. **Biome check**:
   ```bash
   npx @biomejs/biome check ./src
   ```
   - If formatting errors: `npx @biomejs/biome check --write ./src`
   - If lint errors: fix manually

2. **TypeScript check** (if applicable):
   ```bash
   npx tsc --noEmit
   ```
   - Fix all type errors

3. **Build**:
   ```bash
   npm run build
   ```
   - If it fails, analyze the error and fix
   - Common errors: broken imports, missing types, unused variables

4. Only if all 3 pass → report as verified

## Testing Philosophy (Solo Founder)
- Unit tests for pure business logic
- Integration tests for critical flows (auth, payments, data mutations)
- NO tests for: pure UI components, layouts, styles
- One test that catches a real bug > 10 superficial coverage tests

## Output
Report:
- Tests written and result
- Biome check status
- tsc status
- Build status
- Verdict: VERIFIED or PENDING [reason]
