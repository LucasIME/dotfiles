#!/bin/zsh
set -e  # Exit immediately if any command fails

echo "Starting verification script"

# Function to check if a command exists
check_command() {
  if ! command -v "$1" &> /dev/null; then
    echo "Error: $1 is not installed." >&2
    exit 1
  fi
}

check_fzf() {
  if [ -x "$HOME/.fzf/bin/fzf" ]; then
    echo "fzf is installed"
  else
    echo "Error: fzf is not installed." >&2
    exit 1
  fi
}

check_fzf_ctrl_r() {
  bindkey | grep history | grep "\^R" && echo "Fzf configured for history search" || echo "Fzf NOT configured for history search"
}

check_dotfiles() {
  # Expected files come from `COPY . /tmp/expected/` in the Dockerfile, so they
  # live under their stow subdirectories, not the repo root.
  diff -q "$HOME/.vimrc" "/tmp/expected/vim/.vimrc" && echo "Vim config is correct" || { echo "Error: Vim config is not correct." >&2; exit 1; }
  diff -q "$HOME/.tmux.conf" "/tmp/expected/tmux/.tmux.conf" && echo "Tmux config is correct" || { echo "Error: Tmux config is not correct." >&2; exit 1; }
  diff -q "$HOME/.zshrc" "/tmp/expected/zsh/.zshrc" && echo "Zsh config is correct" || { echo "Error: Zsh config is not correct." >&2; exit 1; }
}

check_zsh_plugins() {
  source "$HOME/.antidote/antidote.zsh"

  # Plugins are cloned lazily on first shell startup; trigger that here so a
  # non-interactive test run populates them before we check.
  antidote load

  local plugins=(
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-completions"
    "zsh-users/zsh-syntax-highlighting"
  )

  for plugin in "${plugins[@]}"; do
    if antidote path "$plugin" &> /dev/null; then
      echo "$plugin installed"
    else
      echo "$plugin not found (antidote failed to clone it)"
      exit 1
    fi
  done
}

# Check for required tools
check_command git
check_command zsh
check_command tmux
check_command vim
check_command nvim
check_command rg
check_fzf
check_fzf_ctrl_r
check_dotfiles
check_zsh_plugins

echo "All required tools are installed."
