#!/bin/bash
# ============================================================
# Solo Founder SDLC Kit — Remote Installer
# ============================================================
# Uso:
#   curl -fsSL https://raw.githubusercontent.com/fcojaviergon/solo-founder-team/main/remote-install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/fcojaviergon/solo-founder-team/main/remote-install.sh | bash -s -- init
# ============================================================

set -e

REPO="fcojaviergon/solo-founder-team"
BRANCH="main"
TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT

echo "Downloading solo-founder-team..."
git clone --depth 1 --branch "$BRANCH" \
    "https://github.com/${REPO}.git" "$TMPDIR/solo-founder-team" 2>/dev/null

chmod +x "$TMPDIR/solo-founder-team/install.sh"
"$TMPDIR/solo-founder-team/install.sh" "$@"
