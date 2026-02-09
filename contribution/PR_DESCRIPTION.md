## Summary

- Add **Solo Founder SDLC Kit**: a complete development lifecycle framework for solo founders using Claude Code
- **13 skills** covering the full workflow from quotation to deployment (new `sdlc/` category)
- **2 isolated agents** for QA testing and security review
- **3 hooks** for file protection, auto-formatting, and session-end verification
- **1 settings** config with pragmatic permissions for solo dev workflows
- Includes **PDP Generator** with Python script for Excel quotation export, estimation reference tables, and templates

## Components Added

### Skills (`cli-tool/components/skills/sdlc/`)

| Skill | Purpose | Notes |
|-------|---------|-------|
| `plan-feature` | Plan features with requirements analysis and risk identification | Integrates with PDP |
| `implement` | Execute tasks from active plan following project conventions | Supports custom project skills |
| `test-verify` | Write tests + verify build/lint/types | Forked subagent |
| `review-code` | Senior code review (security, bugs, simplicity) | Forked subagent |
| `commit-ship` | Git commit + PR with pre-flight checks | Conventional commits |
| `write-docs` | Generate README, architecture docs, ADRs | Solo founder focused |
| `triage-bug` | Diagnose, classify (CRITICAL/HIGH/MEDIUM/LOW), propose fix | Logs to bugs-found.md |
| `write-spec` | Formal specification for complex features (10+ files) | EARS acceptance criteria |
| `pdp-generator` | Product Development Plan with WBS + Excel export | Bundled scripts + templates |
| `bootstrap-repo` | Quick repo onboarding and architecture summary | Forked subagent |
| `log-decision` | Architecture Decision Records (ADRs) | Versioned in docs/decisions/ |
| `sprint-retro` | Retrospective + continuous improvement | Forked subagent |
| `time-track` | Log actual vs. estimated hours for billing | CSV-based tracking |

### Agents (`cli-tool/components/agents/sdlc/`)

| Agent | Tools | Purpose |
|-------|-------|---------|
| `qa-tester` | Read, Grep, Glob, Bash | Full QA: tests, types, lint, build, cleanup scan |
| `security-reviewer` | Read, Grep, Glob | Read-only security audit: injection, auth, secrets, CORS |

### Hooks (`cli-tool/components/hooks/sdlc/`)

| Hook | Trigger | Purpose |
|------|---------|---------|
| `file-protection` | PreToolUse | Block writes to .env, .git/, node_modules/, dist/ |
| `biome-auto-format` | PostToolUse | Auto-format TS/JS/JSON/CSS with Biome |
| `session-end-verification` | Stop | Background lint + build check on session end |

### Settings (`cli-tool/components/settings/sdlc/`)

| Setting | Purpose |
|---------|---------|
| `solo-founder-permissions` | Allow common dev ops, block destructive commands |

## Workflows Enabled

```
Simple:   /plan-feature → /implement → /test-verify → /commit-ship
Complex:  /write-spec → /plan-feature → /implement → /test-verify → /review-code → /commit-ship
Quotation: /pdp-generator → /write-spec or /plan-feature → /implement → /time-track → /sprint-retro
```

## Test plan

- [ ] Verify all 13 SKILL.md files have valid YAML frontmatter (name, description, version, author, license, tags)
- [ ] Verify 2 agent .md files have valid YAML frontmatter and allowed-tools
- [ ] Verify 3 hook .json files are valid JSON with proper config structure
- [ ] Verify 1 settings .json file is valid JSON with permissions config
- [ ] Verify `pdp-generator` bundled resources load correctly (scripts/, templates/, resources/)
- [ ] Verify `generate_pdp_xlsx.py` runs with sample JSON input
- [ ] Test skill installation via CLI: `npx claude-code-templates@latest --skill sdlc/plan-feature --yes`
- [ ] Confirm no naming conflicts with existing components in the repository

https://github.com/fcojaviergon/solo-founder-team
