#!/bin/bash
# ============================================================
# 🚀 Solo Founder SDLC Kit — Installer
# ============================================================
# Installs global skills, agents, hooks and base configuration
# for a complete development + quotation workflow.
#
# Usage:
#   chmod +x install.sh
#   ./install.sh
#
# To install project files (CLAUDE.md, settings,
# project skills), run from the root of your repo:
#   ./install.sh init
# ============================================================

set -e

VERSION="1.0.0"

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

KIT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Detect execution context for user-facing messages
if [[ "$0" == *"node_modules"* ]] || [[ "$0" == *"_npx"* ]]; then
    CMD_NAME="npx solo-founder-team"
else
    CMD_NAME="$0"
fi

print_header() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}  🚀 Solo Founder SDLC Kit — Installer${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

print_step() {
    echo -e "${GREEN}  ✓${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}  ⚠${NC} $1"
}

print_error() {
    echo -e "${RED}  ✗${NC} $1"
}

print_version() {
    echo "solo-founder-team v${VERSION}"
}

print_usage() {
    echo "Usage: solo-founder-team [command]"
    echo ""
    echo "Commands:"
    echo "  (default)    Install global skills, agents, and hooks to ~/.claude/"
    echo "  init         Configure current project (CLAUDE.md, settings, docs/)"
    echo "  --help       Show this help"
    echo "  --version    Show version number"
    echo ""
    echo "Examples:"
    echo "  ${CMD_NAME}          # Install global toolkit"
    echo "  ${CMD_NAME} init     # Setup current project"
    echo ""
}

# ─── Install Global Skills ────────────────────────────────
install_global() {
    echo -e "\n${BOLD}📦 Installing Global Skills (~/.claude/skills/)${NC}\n"

    GLOBAL_SKILLS_DIR="$HOME/.claude/skills"
    mkdir -p "$GLOBAL_SKILLS_DIR"

    # SDLC Skills
    local skills=(
        "plan-feature"
        "implement"
        "test-verify"
        "review-code"
        "commit-ship"
        "write-docs"
        "triage-bug"
        "write-spec"
    )

    for skill in "${skills[@]}"; do
        mkdir -p "$GLOBAL_SKILLS_DIR/$skill"
        cp "$KIT_DIR/global-skills/$skill/SKILL.md" "$GLOBAL_SKILLS_DIR/$skill/SKILL.md"
        print_step "Skill: /\$skill"
    done

    # Business Skills
    local biz_skills=(
        "pdp-generator"
        "bootstrap-repo"
        "log-decision"
        "sprint-retro"
        "time-track"
    )

    for skill in "${biz_skills[@]}"; do
        mkdir -p "$GLOBAL_SKILLS_DIR/$skill"
        if [ -d "$KIT_DIR/global-skills/$skill/scripts" ]; then
            cp -r "$KIT_DIR/global-skills/$skill/scripts" "$GLOBAL_SKILLS_DIR/$skill/"
        fi
        if [ -d "$KIT_DIR/global-skills/$skill/templates" ]; then
            cp -r "$KIT_DIR/global-skills/$skill/templates" "$GLOBAL_SKILLS_DIR/$skill/"
        fi
        if [ -d "$KIT_DIR/global-skills/$skill/resources" ]; then
            cp -r "$KIT_DIR/global-skills/$skill/resources" "$GLOBAL_SKILLS_DIR/$skill/"
        fi
        cp "$KIT_DIR/global-skills/$skill/SKILL.md" "$GLOBAL_SKILLS_DIR/$skill/SKILL.md"
        print_step "Skill: /$skill"
    done

    echo -e "\n${BOLD}🤖 Installing Agents (~/.claude/agents/)${NC}\n"

    mkdir -p "$HOME/.claude/agents"
    cp "$KIT_DIR/agents/qa-tester.md" "$HOME/.claude/agents/"
    print_step "Agent: qa-tester"
    cp "$KIT_DIR/agents/security-reviewer.md" "$HOME/.claude/agents/"
    print_step "Agent: security-reviewer"

    echo -e "\n${BOLD}⚙️  Installing Global Settings (~/.claude/settings.json)${NC}\n"

    if [ -f "$HOME/.claude/settings.json" ]; then
        cp "$HOME/.claude/settings.json" "$HOME/.claude/settings.json.backup.$(date +%s)"
        print_warn "Backup of existing settings.json created"
    fi
    cp "$KIT_DIR/config/global-settings.json" "$HOME/.claude/settings.json"
    print_step "Global settings with hooks installed"

    echo -e "\n${GREEN}${BOLD}✅ Global installation complete${NC}"
    echo -e "   Skills: ${#skills[@]} SDLC + ${#biz_skills[@]} Business = $((${#skills[@]} + ${#biz_skills[@]})) total"
    echo -e "   Agents: 2"
    echo -e "   Hooks: 5 (PreToolUse + PostToolUse + Stop×2 + Notification)"
}

# ─── Install Project Files ────────────────────────────────
install_project() {
    echo -e "\n${BOLD}📁 Installing Project Files (.claude/ + docs/)${NC}\n"

    if [ ! -d ".git" ]; then
        print_error "You are not at the root of a git repository."
        print_error "Navigate to your project and run: ${CMD_NAME} init"
        exit 1
    fi

    PROJECT_NAME=$(basename "$(pwd)")

    # .claude/settings.json (project)
    mkdir -p .claude
    if [ -f ".claude/settings.json" ]; then
        cp ".claude/settings.json" ".claude/settings.json.backup.$(date +%s)"
        print_warn "Backup of existing .claude/settings.json created"
    fi
    cp "$KIT_DIR/config/project-settings.json" ".claude/settings.json"
    print_step ".claude/settings.json (project permissions)"

    # CLAUDE.md
    if [ -f "CLAUDE.md" ]; then
        print_warn "CLAUDE.md already exists — not overwriting"
        print_warn "See $KIT_DIR/config/CLAUDE.md.template for reference"
    else
        sed "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" \
            "$KIT_DIR/config/CLAUDE.md.template" > "CLAUDE.md"
        print_step "CLAUDE.md created (edit the [PLACEHOLDERS])"
    fi

    # docs/
    mkdir -p docs/decisions docs/retros specs
    if [ ! -f "docs/active-plan.md" ]; then
        echo "# Active Plan\n\nNo active plan. Use /plan-feature to create one." \
            > docs/active-plan.md
        print_step "docs/active-plan.md"
    fi
    if [ ! -f "docs/decisions/README.md" ]; then
        echo "# Technical Decisions (ADRs)\n\n| Date | Decision | Status |\n|------|----------|--------|\n| | | |" \
            > docs/decisions/README.md
        print_step "docs/decisions/README.md"
    fi

    echo -e "\n${GREEN}${BOLD}✅ Project configured${NC}"
    echo -e "   Remember to edit CLAUDE.md with your stack and conventions"
    echo -e "   Your frontend/backend skills go in .claude/skills/"
}

# ─── Main ─────────────────────────────────────────────────
print_header

case "${1:-}" in
    --project|init)
        install_project
        ;;
    --global)
        install_global
        ;;
    --help|-h)
        print_usage
        exit 0
        ;;
    --version|-v)
        print_version
        exit 0
        ;;
    *)
        install_global
        echo ""
        echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${BOLD}  Next step:${NC}"
        echo -e "  Navigate to your project and run:"
        echo -e "  ${BLUE}cd /path/to/your/project && ${CMD_NAME} init${NC}"
        echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        ;;
esac

echo ""
