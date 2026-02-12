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

### Phase 2: Module Decomposition

```
Project
├── M1: Setup & Infrastructure
├── M2: Authentication & Users
├── M3-MN: [Core Business Modules]
├── MN+1: Integrations
├── MN+2: Admin Panel
└── MN+3: QA & Go-Live
```

### Phase 3: Per-Task Estimation

For EACH feature:

| Field | Description |
|-------|-------------|
| ID | M1-T01, M2-T01, etc. |
| Module | Parent module name |
| Task | Clear description |
| Type | Frontend / Backend / Fullstack / Infra / QA / Design |
| Complexity | Low / Medium / High / Very High |
| Estimated MH | Man-hours |
| Profile | Junior / Semi-Senior / Senior / Tech Lead / Architect |
| Dependencies | Prerequisite IDs |
| Risk | Low / Medium / High |
| Phase | MVP / Phase 2 |
| Notes | Assumptions, exclusions |

#### Estimation Reference (MH)

**Frontend:**
- Simple UI component: 2-4
- Standard form (3-5 fields): 4-8
- Complex form (10+ fields): 8-16
- List view + filters: 8-16
- Dashboard with charts: 16-32
- Multi-step wizard: 16-24
- Responsive adaptation: +30% on base

**Backend:**
- Simple CRUD: 4-8
- CRUD with validations: 8-16
- API with complex logic: 16-32
- External REST integration: 8-24
- SOAP/legacy integration: 16-40
- Notifications (email/push): 16-24
- Roles and permissions: 16-32
- Background jobs: 12-24
- File upload + processing: 8-16

**Infrastructure:**
- Dev setup (Docker): 4-8
- Basic CI/CD: 8-16
- CI/CD staging + prod: 16-32
- Basic IaC: 16-24
- Monitoring: 8-16

**QA:**
- Unit tests per module: 8-16
- Integration tests: 12-24
- E2E tests: 16-32
- Performance testing: 16-24

**Management:**
- Kickoff + planning: 8-16
- Sprint planning (per sprint): 4-8
- Code review (per sprint): 8-16
- Technical documentation: 16-32
- Go-live support: 8-16

#### Context Multipliers
- Legacy: x1.3-1.5
- Ambiguous requirements: x1.2-1.4
- APIs without docs: x1.5
- Compliance: x1.3
- Multi-language: x1.2
- Multi-tenant: x1.3-1.5

#### Contingency Buffer
- Well defined: +15%
- Moderate: +25%
- Exploratory: +35%

### Phase 4: Deliverables

**Document 1: PDP Markdown** (docs/pdp-[name].md)
1. Executive Summary
2. Scope (In/Out scope + Assumptions)
3. Proposed Architecture (Mermaid diagram)
4. Complete WBS
5. Estimation summary (by module + by profile + totals)
6. Timeline (weeks)
7. Suggested team
8. Risks
9. Exclusions

**Document 2: Excel** (docs/pdp-[name].xlsx)
Use script: `python ~/.claude/skills/pdp-generator/scripts/generate_pdp_xlsx.py`
Sheets: Detailed WBS, Summary by Module, Summary by Profile,
Cost Calculator (USD + CLP with editable rates)

### Phase 5: Validation
- [ ] All tasks have unique ID
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

1. For each module in the WBS, classify as:
   - **Complex** (10+ files, integrations, business logic) → `/write-spec @docs/pdp-[name].md`
   - **Simple** (CRUD, UI, config) → `/plan-feature @docs/pdp-[name].md`
2. The spec/plan skills will read the PDP to pre-populate:
   - Module scope and tasks from the WBS
   - Estimated hours as a reference baseline
   - Dependencies and risks already identified
3. As each module is implemented, use `/time-track` to log actual hours
   against the PDP estimates

Suggest: "The PDP is ready. Want me to start with a module?
I can run `/write-spec @docs/pdp-[name].md` for complex modules
or `/plan-feature @docs/pdp-[name].md` for simpler ones."

## Rules
1. **Always include Out of Scope** — avoids consulting problems
2. **Estimate honestly** — better +20% than -20%
3. **Separate MVP from Nice-to-Have** clearly
4. **The "iceberg"** — auth, error handling, validations, logging,
   deployment = ~40% of the effort. Don't omit.
5. **Management != 0 MH** — include PM, meetings, code review, docs
