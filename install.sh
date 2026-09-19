#!/usr/bin/env bash
# Symlinks ~/.claude/skills/humanizer to this repo. Safe to re-run: a
# no-op if already linked correctly, and backs up (never deletes)
# anything unexpected found there rather than overwriting it.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$REPO_DIR"
TARGET="$HOME/.claude/skills/humanizer"

if [ ! -f "$REPO_DIR/SKILL.md" ]; then
  echo "error: $REPO_DIR/SKILL.md doesn't exist -- is this the humanizer-skill repo?" >&2
  exit 1
fi

mkdir -p "$HOME/.claude/skills"

if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$SOURCE" ]; then
  echo "OK   $TARGET -> $SOURCE (already linked)"
elif [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
  BACKUP="${TARGET}.bak.$(date +%Y%m%d%H%M%S)"
  echo "Backing up existing $TARGET -> $BACKUP"
  mv "$TARGET" "$BACKUP"
  ln -s "$SOURCE" "$TARGET"
  echo "OK   $TARGET -> $SOURCE  (previous contents saved to $BACKUP)"
else
  ln -s "$SOURCE" "$TARGET"
  echo "OK   $TARGET -> $SOURCE"
fi

echo
echo "Skill is live immediately -- no shell restart needed."
