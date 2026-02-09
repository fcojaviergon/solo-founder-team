---
name: log-decision
version: 1.1.1
description: >
  Record a technical or product decision as an ADR (Architecture Decision
  Record). Use when an important decision is made: choosing a library,
  changing a pattern, defining an API, etc. Trigger: "log decision", "ADR",
  "why did we choose", "technical decision", "record decision".
author: fcojaviergon
license: MIT
tags: [sdlc, adr, architecture, solo-founder, decisions]
---

# Log Decision: $ARGUMENTS

## Instructions

Create ADR at docs/decisions/YYYY-MM-DD-[slug].md:

```markdown
# ADR: [Title]

**Date**: [today]
**Status**: Accepted | Proposed | Superseded by [link]

## Problem
[1-2 sentences]

## Options Considered
1. **[Option A]**: [brief]
   - Pro: ...
   - Con: ...
2. **[Option B]**: [brief]
   - Pro: ...
   - Con: ...

## Decision
We chose **[Option X]** because [reason in 1 sentence].

## Consequences
- [What changes]
- [What tech debt it accepts]
- [When to reconsider]
```

## Rules
- Max 1 page
- "Consequences" is the most important section
- Update the index at docs/decisions/README.md
