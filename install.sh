#!/usr/bin/env bash
set -e # stop when error occurs

# make the script agnostic to where it is called from
REPO="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$HOME/.config"

# shared
ln -sf "$REPO/shared/wezterm.lua" "$HOME/.wezterm.lua"
# ln -sf "$REPO/shared/nvim" "$HOME/.config/nvim"

# linux-only
# ln -sf "$REPO/linux/bashrc" "$HOME/.bashrc"
