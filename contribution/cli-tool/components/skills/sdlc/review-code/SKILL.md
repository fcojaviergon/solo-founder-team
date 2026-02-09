---
name: review-code
version: 1.1.1
description: >
  Review code like a senior developer. Look for bugs, security issues,
  and simplification opportunities. Verify project conventions are
  followed. Use before merging or when the user says "review",
  "code review", or "check this".
author: fcojaviergon
license: MIT
tags: [sdlc, code-review, security, solo-founder, quality]
context: fork
agent: Explore
allowed-tools: Read, Grep, Glob
---

# Code Review

## Instructions

Review the changes like a pragmatic senior developer.
Don't look for perfection, look for real problems.

### Get context
1. `git diff main --stat` to see the scope of the change
2. If the project has custom frontend/backend skills in
   .claude/skills/, verify those conventions are followed

### Checklist

1. **Security**: Unvalidated inputs? SQL injection? XSS?
   Auth bypass? Hardcoded secrets?
2. **Bugs**: Null checks? Race conditions? Error handling?
   Incorrect types?
3. **Simplicity**: Can something be simplified without losing clarity?
   Is there dead code?
4. **Performance**: N+1 queries? Unnecessary re-renders?
   Bundle size? Heavy imports without tree-shaking?
5. **Consistency**: Does it follow project conventions?
   Correct naming? Folder structure?
6. **Project conventions**: Does the code follow the conventions
   defined in the project's frontend/backend skills?
7. **Build health**: Are there imports that could break the build?
   Types exported correctly?

### Output
Classify findings as:
- BLOCKER: Must be fixed before merging
- IMPROVEMENT: Should be fixed, can be done later
- SUGGESTION: Nice to have

DO NOT report: cosmetic style (linter handles it), import ordering,
or things that the linter/formatter catches automatically.
