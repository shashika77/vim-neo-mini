#!/usr/bin/env bash
set -euo pipefail

if ! command -v nvim >/dev/null 2>&1; then
  echo "Neovim is required. Install it first (macOS: brew install neovim)." >&2
  exit 1
fi

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
timestamp="$(date +%Y%m%d-%H%M%S)"

if [ -e "$config_dir" ]; then
  mv "$config_dir" "${config_dir}.backup.${timestamp}"
  echo "Existing config saved to ${config_dir}.backup.${timestamp}"
fi
mkdir -p "$(dirname -- "$config_dir")"
cp -R "$script_dir/nvim" "$config_dir"

if [ -f "$HOME/.zshrc" ] && ! grep -qF '# Neovim aliases installed by setup backup' "$HOME/.zshrc"; then
  cat >> "$HOME/.zshrc" <<'ALIASES'

# Neovim aliases installed by setup backup
export EDITOR="nvim"
export VISUAL="nvim"
alias vim="nvim"
alias vi="nvim"
ALIASES
fi

echo "Neovim config installed. Open a new terminal, then run: nvim"
echo "On first launch, wait for plugins and language tools to install."
