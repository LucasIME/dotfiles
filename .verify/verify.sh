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

check_fzf_ctrl_r() {
  bindkey | grep history | grep "\^R" && echo "Fzf configured for history search" || echo "Fzf NOT configured for history search"
}

# Check for required tools
check_command git
check_command zsh
check_command tmux
check_command vim
check_command nvim
check_command rg
check_command fzf
check_fzf_ctrl_r

echo "All required tools are installed."
