# Solo Founder SDLC Kit — Contribution to claude-code-templates

Complete SDLC (Software Development Lifecycle) framework for solo founders using Claude Code. This kit provides an integrated set of skills, agents, hooks, and settings to manage professional development workflows from quotation through deployment.

## Components

### Skills (13) — `cli-tool/components/skills/sdlc/`

| # | Skill | Type | Description |
|---|-------|------|-------------|
| 1 | `plan-feature` | SDLC | Plan features with requirements analysis and risk identification |
| 2 | `implement` | SDLC | Execute implementation tasks from active plans |
| 3 | `test-verify` | SDLC (fork) | Write tests and verify build/lint/types |
| 4 | `review-code` | SDLC (fork) | Senior code review for bugs, security, conventions |
| 5 | `commit-ship` | SDLC | Git commit + PR with pre-flight checks |
| 6 | `write-docs` | SDLC | Generate/update README, architecture, ADRs |
| 7 | `triage-bug` | SDLC | Diagnose, classify, and propose bug fixes |
| 8 | `write-spec` | SDLC | Formal specs for complex features (10+ files) |
| 9 | `pdp-generator` | Business | Product Development Plan with WBS + Excel export |
| 10 | `bootstrap-repo` | Business (fork) | Quick repo onboarding summary |
| 11 | `log-decision` | Business | Architecture Decision Records (ADRs) |
| 12 | `sprint-retro` | Business (fork) | Retrospective + continuous improvement |
| 13 | `time-track` | Business | Log actual vs. estimated hours |

### Agents (2) — `cli-tool/components/agents/sdlc/`

| Agent | Description | Tools |
|-------|-------------|-------|
| `qa-tester` | Complete quality verification (tests, types, lint, build) | Read, Grep, Glob, Bash |
| `security-reviewer` | Security audit (read-only) for injection, auth, secrets, CORS | Read, Grep, Glob |

### Hooks (3) — `cli-tool/components/hooks/sdlc/`

| Hook | Trigger | Description |
|------|---------|-------------|
| `file-protection` | PreToolUse | Block writes to .env, .git/, node_modules/, .next/, dist/ |
| `biome-auto-format` | PostToolUse | Auto-format TS/JS/JSON/CSS with Biome after edits |
| `session-end-verification` | Stop | Background lint + build check on session end |

### Settings (1) — `cli-tool/components/settings/sdlc/`

| Setting | Description |
|---------|-------------|
| `solo-founder-permissions` | Pragmatic permission set: allow common dev ops, block destructive commands |

## Workflow

### Simple Features (<10 files)
```
/plan-feature → /implement → /test-verify → /commit-ship
```

### Complex Features (10+ files)
```
/write-spec → /plan-feature → /implement → /test-verify → /review-code → /commit-ship
```

### Project Quotation (PDP-Driven)
```
/pdp-generator → /write-spec (complex) or /plan-feature (simple) → /implement → /time-track → /sprint-retro
```

## How to Install in claude-code-templates

Copy the contents of `cli-tool/` into the root `cli-tool/` directory of the `davila7/claude-code-templates` repository:

```bash
# From the contribution directory
cp -r cli-tool/components/skills/sdlc/ <repo>/cli-tool/components/skills/sdlc/
cp -r cli-tool/components/agents/sdlc/ <repo>/cli-tool/components/agents/sdlc/
cp -r cli-tool/components/hooks/sdlc/ <repo>/cli-tool/components/hooks/sdlc/
cp -r cli-tool/components/settings/sdlc/ <repo>/cli-tool/components/settings/sdlc/
```

## Author

- **GitHub**: [fcojaviergon](https://github.com/fcojaviergon)
- **Project**: [solo-founder-team](https://github.com/fcojaviergon/solo-founder-team)
- **License**: MIT
