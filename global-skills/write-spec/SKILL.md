---
name: write-spec
description: >
  Generate a formal specification for complex features before
  planning. Use ONLY when the feature touches 10+ files, has
  external integrations, complex business logic, or multiple
  stakeholders. DO NOT use for simple CRUDs, UI changes, or fixes.
  Trigger: "spec", "specification", "write spec", "I need to
  define this well first", "this is complex".
---

# Spec: $ARGUMENTS

## When to use this skill

Use when:
- Feature touches 10+ files or 3+ modules
- There are external integrations (APIs, webhooks, services)
- Business logic with rules and edge cases
- Data migration or schema change
- Feature that affects auth, payments, or sensitive data
- You're going to delegate to parallel subagents

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
- Pre-populate the spec with:
  - Module scope from the WBS as the "Problem" section
  - Task breakdown as the "Tasks Preview"
  - Estimated hours as reference
  - Dependencies already identified in the PDP
  - Risks already identified in the PDP
- Skip redundant discovery questions — the PDP already answered them

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
[Concise description of the solution. Include Mermaid diagram
if there's a complex flow or interaction between services.]

## Acceptance Criteria
Use EARS format when applicable:
- WHEN [trigger], the system SHALL [behavior]
- WHILE [state], the system SHALL [behavior]
- WHERE [condition], the system SHALL [behavior]

Concrete examples:
1. WHEN user uploads file > 10MB, SHALL show error with limit
2. WHEN webhook fails 3 times, SHALL pause and notify by email
3. WHILE user not verified, SHALL block access to billing

## Interfaces / Contracts
[Endpoints, schemas, payloads — only if applicable]

```typescript
// POST /api/v1/feature
interface Request {
  // ...
}
interface Response {
  // ...
}
```

## Out of Scope
- [Explicit: what will NOT be done]

## Dependencies
- [External services, APIs, other modules]

## Risks
| Risk | Impact | Mitigation |
|------|--------|------------|

## Tasks Preview
[High-level numbered list, ~5-8 tasks max.
The fine detail is done by /plan-feature afterwards.]
1. [task 1]
2. [task 2]
...
```

### Phase 3: Review

Present to the founder and ask:
- "Do the acceptance criteria cover what you need?"
- "Is anything missing from out of scope?"
- "Do you approve to move to /plan-feature?"

### Phase 4: Handoff

Once approved:
1. Mark status as "Approved"
2. Suggest: "Should I run /plan-feature @specs/[name].md to generate the plan?"
3. /plan-feature reads the spec and generates the detailed plan in active-plan.md
4. If the feature is large, suggest subagent pattern:
   "Each task in the plan can be executed by an isolated subagent
   with an atomic commit after each one."

## Rules

1. **Max 2 pages** — if you need more, the feature is too large.
   Split it into 2+ specs.
2. **Acceptance criteria > prose** — the spec is a contract, not an essay.
   Each criterion must be testable.
3. **Don't over-specify** — leave room for implementation decisions.
   The spec says WHAT, not HOW (except for real technical constraints).
4. **Out of scope is mandatory** — protects the founder from scope creep,
   especially in consulting projects.
5. **The spec is versioned** — lives in specs/ within the repo, is committed,
   and can be referenced from PRs and ADRs.
