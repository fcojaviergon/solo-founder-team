# Solo Founder SDLC Kit for Claude Code

Complete kit of Skills, Agents, Hooks, and configuration for a
professional development workflow as a solo founder using Claude Code.

## What's Included

| # | Component | Type | Purpose |
|---|-----------|------|---------|
| | **CONFIG** | | |
| 1 | CLAUDE.md template | Config | Project constitution |
| 2 | global-settings.json | Config | Hooks (Biome, build, protection, notifications) |
| 3 | project-settings.json | Config | Safe per-project permissions |
| | **SDLC SKILLS** | | |
| 4 | /plan-feature | Skill | Plan features with actionable plan |
| 5 | /implement | Skill | Implement tasks (references custom skills) |
| 6 | /test-verify | Skill+fork | Testing + build verification + biome |
| 7 | /review-code | Skill+fork | Code review (verifies conventions) |
| 8 | /commit-ship | Skill | Git + PR with pre-flight checks |
| 9 | /write-docs | Skill | Documentation |
| 10 | /triage-bug | Skill | Bug diagnosis and classification |
| 11 | /write-spec | Skill | Formal spec for complex features (selective SDD) |
| | **BUSINESS SKILLS** | | |
| 12 | /pdp-generator | Skill | Quotation: WBS + MH estimation + Excel |
| 13 | /bootstrap-repo | Skill+fork | Quick repo onboarding |
| 14 | /log-decision | Skill | Automatic ADRs |
| 15 | /sprint-retro | Skill+fork | Retrospective + continuous improvement |
| 16 | /time-track | Skill | Actual vs. estimated hours |
| | **AGENTS** | | |
| 17 | qa-tester | Agent | Isolated QA (tests + build + lint) |
| 18 | security-reviewer | Agent | Security audit (read-only) |
| | **HOOKS** | | |
| 19 | File protection | PreToolUse | Blocks .env, .git, node_modules |
| 20 | Per-file Biome | PostToolUse | Auto-fix lint+format per file |
| 21 | Global Build + Biome | Stop | Full verification on finish |
| 22 | Stop notification | Stop | macOS alert on finish |
| 23 | Input notification | Notification | Alert when waiting for input |
| 24 | Session logging | Stop | Log for time tracking |

## Installation

### Option A: npx (recommended)

```bash
# Install global skills, agents, and hooks:
npx github:fcojaviergon/solo-founder-team

# Configure a project:
cd /path/to/your/project
npx github:fcojaviergon/solo-founder-team init
```

### Option B: curl (no Node.js required)

```bash
# Install globals:
curl -fsSL https://raw.githubusercontent.com/fcojaviergon/solo-founder-team/main/remote-install.sh | bash

# Configure a project:
cd /path/to/your/project
curl -fsSL https://raw.githubusercontent.com/fcojaviergon/solo-founder-team/main/remote-install.sh | bash -s -- init
```

### Option C: Git clone (for development/customization)

```bash
git clone https://github.com/fcojaviergon/solo-founder-team.git
cd solo-founder-team
./install.sh
```

### What it installs

**Global** (`~/.claude/`):
- 13 global skills in `~/.claude/skills/`
- 2 agents in `~/.claude/agents/`
- Hooks and settings in `~/.claude/settings.json`

**Per project** (with `init`):
- `CLAUDE.md` (template to edit)
- `.claude/settings.json` (project permissions)
- `docs/` (documentation structure)

### Step 3: Edit CLAUDE.md

Open `CLAUDE.md` and replace the `[PLACEHOLDERS]` with your stack and conventions.

### Step 4: Add your custom skills (optional)

If you have frontend/backend skills specific to your project:

```bash
mkdir -p .claude/skills/my-frontend
# Copy your SKILL.md there
mkdir -p .claude/skills/my-backend
# Copy your SKILL.md there
```

## Daily Usage

### Typical workflow

```
# Simple feature (< 10 files)
/plan-feature add search filter              # Plan
/implement                                    # Implement
/test-verify                                  # Verify
/commit-ship                                  # Ship

# Complex feature (10+ files, integrations, dense logic)
/write-spec payment system with Stripe        # Formal spec first
/plan-feature @specs/stripe-payments.md       # Plan from the spec
/implement                                    # Implement (optional subagents)
/test-verify                                  # Verify
/review-code                                  # Review
/commit-ship                                  # Ship
```

### Useful commands

| What you want | What you type |
|--------------|---------------|
| New feature | `/plan-feature [description]` |
| Implement | `/implement` or `/implement task 3` |
| Test | `/test-verify` |
| Review | `/review-code` |
| Ship | `/commit-ship` |
| Bug | `/triage-bug [description]` |
| Formal spec (complex features) | `/write-spec [description]` |
| Quote a project | `/pdp-generator [description]` |
| Repo onboarding | `/bootstrap-repo` |
| Log a decision | `/log-decision [what we decided]` |
| Retrospective | `/sprint-retro` |
| Log hours | `/time-track 3h on auth module` |
| Check hours progress | `/time-track how much have we spent?` |
| Document | `/write-docs [what to document]` |

## Architecture

```
~/.claude/                        <- GLOBAL (all projects)
├── settings.json                 Hooks + global config
├── skills/                       Reusable skills
│   ├── plan-feature/
│   ├── implement/
│   ├── test-verify/
│   ├── review-code/
│   ├── commit-ship/
│   ├── write-docs/
│   ├── triage-bug/
│   ├── write-spec/
│   ├── pdp-generator/
│   │   ├── scripts/
│   │   ├── templates/
│   │   └── resources/
│   ├── bootstrap-repo/
│   ├── log-decision/
│   ├── sprint-retro/
│   └── time-track/
└── agents/
    ├── qa-tester.md
    └── security-reviewer.md

my-project/                       <- PER PROJECT
├── CLAUDE.md                     Project constitution
├── .claude/
│   ├── settings.json             Project permissions
│   └── skills/                   Skills specific to THIS repo
│       ├── my-frontend/          <- Your custom skill
│       └── my-backend/           <- Your custom skill
└── docs/
    ├── active-plan.md
    ├── architecture.md
    ├── repo-overview.md
    ├── timesheet.csv
    ├── bugs-found.md
    ├── decisions/
    │   └── README.md
    └── retros/
```

## The Feedback Loop

```
/pdp-generator -> estimates MH
        |
/time-track -> records actual MH
        |
/sprint-retro -> detects deviations
        |
Updates estimation-reference.md
        |
Next /pdp-generator -> more accurate
```

## Prerequisites

- Claude Code installed (Pro or Max recommended)
- Node.js + npm
- Biome: `npm install -D @biomejs/biome`
- Python 3 (for PDP Excel script)
- jq (for hooks): `brew install jq`
- openpyxl (for Excel): `pip install openpyxl`

## Notes

- Biome hooks assume you use Biome. If you use ESLint/Prettier,
  edit global-settings.json and change the commands.
- Notifications use `osascript` (macOS). On Linux, replace with
  `notify-send`.
- Prettier is denied by default. If you need it, remove it from
  project-settings.json.
