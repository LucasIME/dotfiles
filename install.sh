#!/bin/bash

# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# if mac then install reattach-to-user-namespace
if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Running MacOS. Installing reattach-to-user-namespace."
        nix-env -iA nixpkgs.reattach-to-user-namespace
else
        echo "Not running MacOs. No need to try to install reattach-to-user-namespace."
fi

# install packages
nix-env -iA \
        nixpkgs.git \
        nixpkgs.vim \
        nixpkgs.neovim \
        nixpkgs.tmux \
        nixpkgs.autojump \
        nixpkgs.zsh \
        nixpkgs.zsh-syntax-highlighting \
        nixpkgs.zsh-autosuggestions \
        nixpkgs.zsh-completions \
        nixpkgs.oh-my-zsh \
        nixpkgs.pure-prompt \
        nixpkgs.fzf \
        nixpkgs.ripgrep \
        nixpkgs.stow \

stow alacritty
stow tmux
stow vim
stow zsh

# add zsh to login shells
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

