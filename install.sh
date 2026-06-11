#!/usr/bin/env bash
# dirbanner installer ~ wires the chpwd hook into your shell rc, idempotently.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$HERE/dirbanner.sh"

# Pick the rc file for the current shell.
case "${SHELL##*/}" in
  zsh)  RC="${ZDOTDIR:-$HOME}/.zshrc" ;;
  bash) RC="$HOME/.bashrc" ;;
  *)    RC="$HOME/.zshrc" ;;   # sensible default
esac

MARK="# >>> dirbanner >>>"
END="# <<< dirbanner <<<"

if grep -qF "$MARK" "$RC" 2>/dev/null; then
  echo "dirbanner is already installed in $RC ~ nothing to do."
  exit 0
fi

# Some setups already define _dirbanner by hand; don't double up.
if grep -q "_dirbanner" "$RC" 2>/dev/null; then
  echo "Found an existing _dirbanner in $RC ~ leaving it alone."
  echo "Remove it first if you want the packaged version."
  exit 0
fi

{
  printf '\n%s\n' "$MARK"
  printf '%s\n' "source \"$SRC\""
  printf '%s\n' "$END"
} >> "$RC"

echo "Installed. Added a sourcing block to $RC"
echo "Open a new shell, or run:  source \"$RC\""
echo
echo "Then drop a .dirbanner file in any directory."
echo "Generate one with:  $HERE/new-banner"
