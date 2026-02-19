---
name: pdp-generator
description: >
  Generate a complete Product Development Plan (PDP) for quotation.
  Analyze the architecture of a repo or requirements, decompose into
  modules and features, estimate hours per task, and produce documents
  ready to present to the client. Use when the founder says "quote",
  "estimate", "PDP", "how much would it cost", "development plan",
  "technical proposal", "project scope", "WBS", "breakdown".
---

# PDP Generator — Product Development Plan

You are a **senior Solutions Architect** and **Pre-Sales Consultant**
with experience in software project quotation.

Your goal is to generate a professional, detailed and realistic PDP
that serves as the basis for a commercial proposal.

## Context

This is NOT starting development — it's generating estimation documentation
to sell the project.

## Workflow

### Phase 1: Discovery

**If there's a reference repo:**
Use Explore subagents to scan:
- Folder and module structure
- Stack (package.json, requirements.txt, etc.)
- Data models (schemas, migrations, types)
- APIs and endpoints
- Auth/authz
- External integrations

**If it's a new project:**
Ask:
1. "Do you have a reference repo or are we starting from requirements?"
2. "Is it an MVP or a full product?"
3. "Stack constraints?"
4. "Client profile? (startup, enterprise, government)"
5. "Deadline or budget constraint?"

### Phase 2: Epic & Module Decomposition

Decompose the project into **Epics** (= functional modules).
Each epic contains **User Stories** that describe what the user can do.

```
Project
├── Epic 1: Setup & Infrastructure
├── Epic 2: Authentication & Users
├── Epic 3-N: [Core Business Epics]
├── Epic N+1: Integrations
├── Epic N+2: Admin Panel
└── Epic N+3: QA & Go-Live
```

### Phase 3: User Story Estimation

For each epic, identify user stories and estimate them.
A user story = one thing a user can do end-to-end.

**Story format in the WBS:**

| Field | Description |
|-------|-------------|
| ID | E1-US01, E2-US01, etc. (Epic-UserStory) |
| Epic | Parent epic name |
| User Story | **As a** [role], **I want** [action], **so that** [benefit] |
| Type | Frontend / Backend / Fullstack / Infra / QA / Design |
| Complexity | Low / Medium / High / Very High |
| Estimated MH | Man-hours (total for the story) |
| Profile | Junior / Semi-Senior / Senior / Tech Lead / Architect |
| Dependencies | Prerequisite IDs |
| Risk | Low / Medium / High |
| Phase | MVP / Phase 2 |
| Key Criteria | 2-3 main acceptance criteria (brief, expanded later by /plan-feature) |
| Notes | Assumptions, exclusions |

**Example:**

| Field | Value |
|-------|-------|
| ID | E3-US01 |
| Epic | Product Catalog |
| User Story | **As a** store admin, **I want** to manage products (CRUD), **so that** I can keep my catalog updated |
| Type | Fullstack |
| Complexity | Medium |
| Estimated MH | 16 |
| Profile | Semi-Senior |
| Dependencies | E2-US01 (auth) |
| Risk | Low |
| Phase | MVP |
| Key Criteria | Create with validation, edit inline, delete only if no orders |
| Notes | Max 10 images per product |

#### Estimation Reference (MH) — AI-Assisted Development

These estimates assume a developer working with AI coding tools
(Claude Code, Copilot, etc.). Code generation is fast — the time
is in design, review, testing, and integration.

**Frontend:**
- Simple UI component: 1-2
- Standard form (3-5 fields): 2-4
- Complex form (10+ fields): 4-8
- List view + filters: 3-6
- Dashboard with charts: 6-12
- Multi-step wizard: 6-10
- Responsive adaptation: +20% on base

**Backend:**
- Simple CRUD: 1-3
- CRUD with validations: 3-6
- API with complex logic: 8-16
- External REST integration: 4-12
- SOAP/legacy integration: 12-24
- Notifications (email/push): 4-8
- Roles and permissions: 6-12
- Background jobs: 4-10
- File upload + processing: 3-8

**Infrastructure:**
- Dev setup (Docker): 2-4
- Basic CI/CD: 3-6
- CI/CD staging + prod: 6-12
- Basic IaC: 6-12
- Monitoring: 4-8

**QA:**
- Unit tests per module: 2-6
- Integration tests: 4-10
- E2E tests: 8-16
- Performance testing: 8-16

**Management & Review:**
- Kickoff + planning: 4-8
- Sprint planning (per sprint): 2-4
- Code review + AI output validation (per sprint): 4-8
- Technical documentation: 4-8
- Go-live support: 4-8

#### Where AI saves time vs. where it doesn't

| Phase | AI Impact | Notes |
|-------|-----------|-------|
| Boilerplate / CRUD | ~70% faster | AI generates most of the code |
| UI components | ~60% faster | Layouts, forms, lists are routine |
| Business logic | ~40% faster | AI helps, but logic needs human validation |
| External integrations | ~30% faster | APIs without docs still require manual work |
| Architecture decisions | ~10% faster | Still requires human judgment |
| Security / auth | ~20% faster | Must be carefully reviewed regardless |
| Testing | ~50% faster | AI generates tests, but edge cases need thought |
| Debugging | Varies | AI is great at finding bugs, less at subtle ones |
| DevOps / Infra | ~30% faster | Config-heavy, less AI leverage |

**Rule of thumb:** Estimate at ~40-60% of traditional manual hours for
most tasks. Add buffer for complex integrations and security-sensitive areas.

#### Context Multipliers
- Legacy codebase: x1.3-1.5
- Ambiguous requirements: x1.2-1.4
- APIs without docs: x1.5
- Compliance (HIPAA, SOC2, etc.): x1.3
- Multi-language: x1.2
- Multi-tenant: x1.3-1.5
- No AI tooling (client restriction): x2.0

#### Contingency Buffer
- Well defined: +15%
- Moderate: +25%
- Exploratory: +35%

### Phase 4: Deliverables

**Document 1: PDP Markdown** (docs/pdp-[name].md)
1. Executive Summary
2. Scope (In/Out scope + Assumptions)
3. Proposed Architecture (Mermaid diagram)
4. Epic breakdown with user stories (the WBS)
5. Estimation summary (by epic + by profile + totals)
6. Timeline (weeks)
7. Suggested team
8. Risks
9. Exclusions

**Document 2: Excel** (docs/pdp-[name].xlsx)
Use script: `python "$(find ~/.claude -path '*/solo-founder-team/skills/pdp-generator/scripts/generate_pdp_xlsx.py' 2>/dev/null | head -1)"`
Sheets: Detailed WBS, Summary by Module, Summary by Profile,
Cost Calculator (USD + CLP with editable rates)

### Phase 5: Validation
- [ ] All stories have unique ID (E1-US01 format)
- [ ] Each story has the "As a / I want / So that" format
- [ ] Each story has 2-3 key acceptance criteria
- [ ] Dependencies are coherent
- [ ] Totals add up
- [ ] Buffer applied
- [ ] Out of scope defined
- [ ] Excel formulas work

### Phase 5.5: Review & Refinement

Present the PDP to the founder and ask:
"Review the PDP. What would you like to adjust?"

**Common refinement requests and how to handle them:**

| Founder says | Action |
|-------------|--------|
| "Module X is too expensive" | Break down tasks, reduce scope, or move items to Phase 2 |
| "This is missing feature Y" | Add module/tasks, re-estimate, update totals |
| "Move X to Phase 2" | Change phase field, recalculate MVP totals |
| "Estimates are too high/low" | Review against estimation reference, adjust with justification |
| "Merge these modules" | Consolidate, reassign IDs, update dependencies |
| "Split this module" | Create sub-modules, redistribute tasks, update IDs |
| "Add/remove a risk" | Update risks section and adjust buffer if needed |
| "Change the team" | Update suggested team and re-estimate affected profiles |

**Refinement rules:**
1. After each change, re-run Phase 5 validation (totals, IDs, dependencies)
2. Regenerate the Excel if data changed
3. Keep a changelog at the bottom of the PDP:
   ```
   ## Changelog
   - v1.0 — Initial PDP
   - v1.1 — Moved payments to Phase 2, reduced MVP by 40 MH
   - v1.2 — Added SSO module per client request
   ```
4. Iterate until the founder says "approved" or "ready"
5. Never push back on changes — adjust and show the impact honestly

When approved, mark the PDP as **Final** and proceed to Phase 6.

### Phase 6: Handoff to Development

Once the PDP is approved by the client and development begins,
the PDP becomes the project roadmap. Suggest to the founder:

1. For each epic in the PDP, classify as:
   - **Complex** (10+ files, integrations, business logic) → `/write-spec @docs/pdp-[name].md`
   - **Simple** (CRUD, UI, config) → `/plan-feature @docs/pdp-[name].md`
2. `/plan-feature` will read the PDP and:
   - Map each PDP epic → plan epic (same structure)
   - Expand each PDP user story → full story with detailed GIVEN/WHEN/THEN criteria
   - The PDP's "Key Criteria" become the starting point, not the final version
   - Add edge cases and technical details the PDP intentionally left out
3. As each story is implemented, use `/time-track` to log actual hours
   against the PDP estimates

Suggest: "The PDP is ready. Want me to start with an epic?
I can run `/write-spec @docs/pdp-[name].md` for complex epics
or `/plan-feature @docs/pdp-[name].md` for simpler ones."

## Rules
1. **Always include Out of Scope** — avoids consulting problems
2. **Estimate honestly** — better +20% than -20%
3. **Separate MVP from Nice-to-Have** clearly
4. **The "iceberg"** — auth, error handling, validations, logging,
   deployment = ~40% of the effort. Don't omit.
5. **Management != 0 MH** — include PM, meetings, code review, docs
