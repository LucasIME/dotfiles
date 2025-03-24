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
  diff -q "$HOME/.vimrc" "/tmp/expected/.vimrc" && echo "Vim config is correct" || echo "Error: Vim config is not correct."
  diff -q "$HOME/.tmux.conf" "/tmp/expected/.tmux.conf" && echo "Tmux config is correct" || echo "Error: Tmux config is not correct."
  diff -q "$HOME/.zshrc" "/tmp/expected/.zshrc" && echo "Zsh config is correct" || echo "Error: Zsh config is not correct."
}


check_zsh_plugins() {
  if [[ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
    echo "zsh-autosuggestions installed"
  else
    echo "zsh-autosuggestions not found in expected folder"
    exit 1
  fi
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
