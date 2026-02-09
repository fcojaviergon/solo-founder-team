---
name: write-spec
version: 1.1.1
description: >
  Generate a formal specification for complex features before planning.
  Use ONLY when the feature touches 10+ files, has external integrations,
  complex business logic, or multiple stakeholders. DO NOT use for simple
  CRUDs, UI changes, or fixes. Trigger: "spec", "specification",
  "write spec", "this is complex".
author: fcojaviergon
license: MIT
tags: [sdlc, specification, architecture, solo-founder, requirements]
---

# Spec: $ARGUMENTS

## When to use this skill

Use when:
- Feature touches 10+ files or 3+ modules
- There are external integrations (APIs, webhooks, services)
- Business logic with rules and edge cases
- Data migration or schema change
- Feature that affects auth, payments, or sensitive data

DO NOT use when:
- Simple CRUD
- UI/style change
- Bug fix
- Feature < 5 files with clear logic
→ In those cases, go directly to /plan-feature

## Instructions

### Phase 0: Check for PDP context
If the arguments reference a PDP file (e.g. `@docs/pdp-*.md`):
- Read the PDP and identify the relevant module(s)
- Use the WBS tasks, estimates, dependencies, and risks as the starting point
- Pre-populate the spec with data from the PDP
- Skip redundant discovery questions

### Phase 1: Discovery (with the founder)

Ask only what's necessary:
1. "What problem does it solve for the end user?"
2. "Are there technical or business constraints?"
3. "What should it NOT do?" (out of scope)

If there's a repo, use Explore to scan the affected code.

### Phase 2: Generate Spec

Create specs/[feature-name].md (max 1-2 pages):

```markdown
# Spec: [Feature Name]

**Author**: [name]
**Date**: [today]
**Status**: Draft | Approved | Implemented
**Complexity**: High | Very High

## Problem
[2-3 sentences. What problem exists and for whom.]

## Proposed Solution
[Concise description. Include Mermaid diagram if complex flow.]

## Acceptance Criteria
Use EARS format when applicable:
- WHEN [trigger], the system SHALL [behavior]
- WHILE [state], the system SHALL [behavior]
- WHERE [condition], the system SHALL [behavior]

## Interfaces / Contracts
[Endpoints, schemas, payloads — only if applicable]

## Out of Scope
- [Explicit: what will NOT be done]

## Dependencies
- [External services, APIs, other modules]

## Risks
| Risk | Impact | Mitigation |

## Tasks Preview
[High-level numbered list, ~5-8 tasks max.]
```

### Phase 3: Review

Present to the founder and ask:
- "Do the acceptance criteria cover what you need?"
- "Is anything missing from out of scope?"
- "Do you approve to move to /plan-feature?"

### Phase 4: Handoff

Once approved:
1. Mark status as "Approved"
2. Suggest: "/plan-feature @specs/[name].md"

## Rules
1. **Max 2 pages** — if you need more, split into 2+ specs
2. **Acceptance criteria > prose** — each criterion must be testable
3. **Don't over-specify** — the spec says WHAT, not HOW
4. **Out of scope is mandatory** — protects from scope creep
5. **The spec is versioned** — lives in specs/ within the repo
