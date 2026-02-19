#!/bin/bash
# ============================================================
# Solo Founder Tech Team — v2.0 Migration Notice
# ============================================================
# This project is now a Claude Code plugin.
# The install.sh script is deprecated in favor of the plugin system.
# ============================================================

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
BOLD='\033[1m'

# Resolve script location
SCRIPT_PATH="$0"
while [ -L "$SCRIPT_PATH" ]; do
    SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
    SCRIPT_PATH="$(readlink "$SCRIPT_PATH")"
    [[ "$SCRIPT_PATH" != /* ]] && SCRIPT_PATH="$SCRIPT_DIR/$SCRIPT_PATH"
done
KIT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}  Solo Founder Tech Team v2.0 — Now a Claude Code Plugin${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  This kit is now distributed as a ${GREEN}Claude Code plugin${NC}."
echo ""
echo -e "  ${BOLD}Install (inside Claude Code):${NC}"
echo -e "  ${BLUE}/plugin marketplace add fcojaviergon/solo-founder-tech-team${NC}"
echo -e "  ${BLUE}/plugin install solo-founder-tech-team@solo-founder-tech-team${NC}"
echo ""
echo -e "  ${BOLD}Or use locally without installing:${NC}"
echo -e "  ${BLUE}claude --plugin-dir ${KIT_DIR}${NC}"
echo ""
echo -e "  ${BOLD}Then initialize your project:${NC}"
echo -e "  ${BLUE}/init-project${NC}  (inside Claude Code)"
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  ${YELLOW}Migration from v1.x:${NC}"
echo -e "  1. Remove old skills:  rm -rf ~/.claude/skills/{plan-feature,implement,...}"
echo -e "  2. Remove old hooks from ~/.claude/settings.json"
echo -e "  3. Install plugin with one of the commands above"
echo -e "  4. Run /init-project in each project"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
