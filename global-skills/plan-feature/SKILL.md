---
name: plan-feature
description: >
  Plan a new feature. Analyze requirements, define scope,
  identify risks and generate an actionable implementation plan
  with user stories and acceptance criteria.
  Use when the founder says "I want to add...", "I need...",
  "plan...", "new feature", "plan".
---

# Plan Feature: $ARGUMENTS

## Instructions

You are the Tech Lead planning for a solo developer. Be pragmatic.
Your job is to produce **developer-ready user stories** — not a copy of the PDP.

### Step 0: Determine context

**If arguments reference a PDP file** (e.g. `@docs/pdp-*.md`):
- Read the PDP and identify the relevant module(s)
- The PDP provides the WHAT (scope, tasks, estimates). Your job is to
  transform that into the HOW: user stories with clear acceptance criteria
  that a developer can pick up and implement
- Use the WBS as input, but DO NOT just copy the tasks. Expand them into
  user stories grouped by epic

**If arguments reference a spec file** (e.g. `@specs/*.md`):
- Read the spec and use its acceptance criteria as the foundation
- Transform spec criteria into implementable user stories

**If no reference file** — proceed to Step 1 as usual

### Step 1: Understand the Requirement
- What problem does it solve for the end user?
- What is the expected behavior (happy path)?
- What edge cases matter?

### Step 2: Impact Analysis
Use Explore subagents to scan the codebase:
- What files are affected?
- Are there dependencies or conflicts?
- Are DB migrations needed?

### Step 3: Generate Plan

Write to docs/active-plan.md using this structure:

```markdown
# Plan: [Feature / Module name]
**Date**: [today]
**Source**: [PDP module M3 | Spec: payments | New feature]
**Branch**: feat/[short-name]
**PDP Estimate**: [N MH] (if from PDP, as reference only)
<!-- gh-parent:#NNN (added by Step 5 if GitHub enabled) -->

---

## Epic 1: [Epic name — e.g. "User Authentication"]

### US-1.1: [User story title]
**As a** [role], **I want** [action], **so that** [benefit].

**Acceptance Criteria:**
- [ ] GIVEN [context] WHEN [action] THEN [result]
- [ ] GIVEN [context] WHEN [action] THEN [result]
- [ ] GIVEN [edge case] WHEN [action] THEN [expected handling]

**Technical notes:** [affected files, migrations, APIs — brief]
**Estimate ref:** [N MH from PDP, if applicable]
<!-- gh:#NNN -->

---

### US-1.2: [Next user story]
...

---

## Epic 2: [Next epic]

### US-2.1: ...

---

## Risks
| Risk | Impact | Mitigation |
|------|--------|------------|

## Done Criteria (global)
- [ ] All acceptance criteria pass
- [ ] Tests pass
- [ ] Build succeeds (npm run build)
- [ ] Biome check passes (npx @biomejs/biome check ./src)
```

### How to write good user stories from a PDP

The PDP gives you raw tasks like:
> M3-T01: CRUD de productos (Backend, 8 MH)
> M3-T02: Listado con filtros (Frontend, 12 MH)
> M3-T03: Upload de imágenes (Fullstack, 16 MH)

Transform them into stories with real value:

**Bad** (just copying the PDP):
> - [ ] CRUD de productos — 8 MH

**Good** (developer-ready user story):
> ### US-1.1: Product catalog management
> **As a** store admin, **I want** to create, edit and delete products,
> **so that** I can manage my catalog.
>
> **Acceptance Criteria:**
> - [ ] GIVEN I'm on /admin/products WHEN I click "New" THEN a form with name, price, description, category appears
> - [ ] GIVEN I submit a valid product WHEN price > 0 and name is unique THEN product is saved and appears in the list
> - [ ] GIVEN I edit a product WHEN I change the price THEN the new price reflects immediately in the storefront
> - [ ] GIVEN I delete a product WHEN it has active orders THEN show error "Cannot delete product with pending orders"

### Grouping rules

- **From PDP**: Group by PDP module → each module = 1 epic
- **From spec**: Group by spec sections or domain areas
- **New feature**: Group logically (backend, frontend, integration, or by user flow)
- **Single small feature**: 1 epic is fine, just list the stories

### Step 4: Confirm with the Founder

Present the plan and ask:
"Review the user stories. Are the acceptance criteria clear?
Should I adjust scope, split an epic, or add edge cases?"

Iterate until the founder approves.

### Step 5: GitHub Issues (Optional)

Check if a `.github-issues` file exists in the project root:
- If it contains `disabled` → skip this step entirely
- If it doesn't exist → ask: "Do you want to sync tasks to GitHub Issues? (y/n)"
  - If yes: create `.github-issues` file with `enabled`, verify `gh auth status`
  - If no: create `.github-issues` file with `disabled`, skip this step

If GitHub integration is enabled:
1. Ensure labels exist (create if missing):
   - `gh label create epic --color 3e4b9e --force`
   - `gh label create user-story --color 0075ca --force`
   - `gh label create from-pdp --color fbca04 --force` (only if PDP context)
2. Create one **epic issue** per epic:
   - Title: `[Epic] <epic name>`
   - Body: list of user stories in this epic
   - Labels: `epic` (+ `from-pdp` if PDP context)
3. Create one **issue per user story**:
   - Title: `US-X.Y: <story title>`
   - Body: the full story (As a / I want / So that) + acceptance criteria
   - Labels: `user-story`
   - Body includes: "Epic: #<epic-issue-number>"
4. Update active-plan.md with issue numbers:
   - Append `<!-- gh:#NNN -->` to each user story
   - Append `<!-- gh-parent:#NNN -->` to the plan header (first epic issue)
5. Report: "Created N epics and M user stories as GitHub issues"

## Rules

1. **Stories must be implementable** — a developer should be able to pick
   one story and know exactly what to build and how to verify it's done
2. **Acceptance criteria are mandatory** — no story without at least 2 criteria.
   Use GIVEN/WHEN/THEN format for clarity
3. **Include edge cases** — the value over the PDP is precisely this: thinking
   about what happens when things go wrong
4. **Don't over-plan** — if a story has 10+ criteria, split it into 2 stories
5. **PDP estimates are reference only** — include them but don't let them
   constrain the plan. The real estimate comes from the stories
