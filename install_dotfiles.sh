#!/usr/bin/env bash
set -e # stop when error occurs

# make the script agnostic to where it is called from
REPO="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$HOME/.config"

# shared
ln -sfn "$REPO/shared/.wezterm.lua" "$HOME/.wezterm.lua"
# ln -sf "$REPO/shared/nvim" "$HOME/.config/nvim"

# linux-only
ln -sfn "$REPO/linux/ubuntu-xdg-terminals.list" "$HOME/.config/ubuntu-xdg-terminals.list"
ln -sfn "$REPO/linux/.bashrc" "$HOME/.bashrc"
ln -sfn "$REPO/linux/.bash_env" "$HOME/.bash_env"
ln -sfn "$REPO/linux/.bash_aliases" "$HOME/.bash_aliases"
ln -sfn "$REPO/linux/.profile" "$HOME/.profile"
ln -sfn "$REPO/linux/bat" "$HOME/.config/bat"
