#!/bin/bash
set -e  # Exit immediately if any command fails

# Function to check if a command exists
check_command() {
  if ! command -v "$1" &> /dev/null; then
    echo "Error: $1 is not installed." >&2
    exit 1
  fi
}

# Check for required tools
check_command git
check_command zsh
check_command tmux
check_command rg

echo "All required tools are installed."
