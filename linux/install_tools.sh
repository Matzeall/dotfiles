#!/usr/bin/env bash
# Run as normal user — sudo is invoked per command where root is needed.
set -euo pipefail



### Helpers ###################################################################
# Called before each tool block:
#   - prints a separator with the tool name
#   - re-sources ~/.profile (picks up PATH changes, e.g. ~/.local/bin)
#   - clears bash's command hash so fresh binaries resolve immediately
section() {
  printf '\n\033[1;36m═════ %s ═══════════════════════════════\033[0m\n' "$1"
  if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile" || true
  fi
  hash -r
}

have() { command -v "$1" >/dev/null 2>&1; }

skip() { printf '\033[1;33m  -- %s\033[0m\n' "$*"; }
ok()   { printf '\033[1;32m  ok %s\033[0m\n' "$*"; }



### package installation ##########################################################

section "apt packages"
sudo apt update
# already-installed packages are a no-op
sudo apt install -y \
  bat \
  ncdu \
  curl \
  btop \
  lazygit \
  python3 python3-pip python3-venv \
  xclip \
  ripgrep \
  flatpak \


node_major=24  # to upgrade just bump version and re-run script
section "node (NodeSource repository for apt, Node ${node_major} LTS)"
if dpkg -s nodejs 2>/dev/null | grep -q nodesource && node --version 2>/dev/null | grep -q "^v${node_major}\."; then
  skip "already installed — $(node --version)"
else
  arch="$(dpkg --print-architecture)"
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor --yes -o /etc/apt/keyrings/nodesource.gpg
  sudo tee /etc/apt/sources.list.d/nodesource.sources >/dev/null <<EOF
Types: deb
URIs: https://deb.nodesource.com/node_${node_major}.x
Suites: nodistro
Components: main
Architectures: ${arch}
Signed-By: /etc/apt/keyrings/nodesource.gpg
EOF
  sudo apt update
  sudo apt install -y nodejs      # replaces Ubuntu's older nodejs
  ok "node $(node --version) (npm $(npm --version))"
fi


section "tree-sitter-cli (npm)"
if have tree-sitter; then
  skip "already installed — $(tree-sitter --version 2>&1 | head -n1)"
else
  sudo npm install -g tree-sitter-cli   # npm is system-wide via NodeSource
  ok "tree-sitter $(tree-sitter --version 2>&1 | head -n1)"
fi


section "flathub remote" #########################################################
if flatpak remotes --system 2>/dev/null | grep -qi flathub; then
  skip "flathub already configured"
else
  sudo flatpak remote-add --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo
  ok "flathub added"
fi



section "SUMMARY" ################################################################
for cmd in batcat ncdu curl btop lazygit xclip rg node npm python3 pip3 flatpak tree-sitter; do
  if have "$cmd"; then
    printf '  ok   %s\n' "$cmd"
  else
    printf '  MISS %s\n' "$cmd"
  fi
done
