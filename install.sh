#!/bin/bash

### Functions Block ###
command_installed() {
    if ! [ -x "$(command -v "$1")" ]; then
        return 1
    else
        return 0
    fi
}

maybe_update_pkg_manager() {
    if command_installed "apt-get"; then
        echo "Updating apt-get"
        apt-get update
    fi
}

install() {
    if command_installed "brew"; then
        brew install "$1"
    elif command_installed "yum"; then
        yum install -y "$1"
    elif command_installed "apt-get"; then
        apt-get install "$1"
    else
        echo "error can't install package $1"
        return 1;
    fi
}

try_install() {
    if command_installed "$1"; then
        echo "$1"' already installed'
    else
        echo 'Error: '"$1"' is not installed.' >&2
        echo 'Trying to install '"$1"
        install "$1"
    fi
}

### Installations that need specific commands ###
install_package_manager_if_mac() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Running MacOS. Checking if brew is installed"
        if command_installed "brew"; then
            echo "Brew already installed. Continuing to next step."
        else
            echo "Brew not installed. Installing now."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            echo "Done instaling Brew."
        fi
    else
        echo "Not running MacOs. No need to try to install Brew."
    fi
}

install_reattach_to_user_namespace_if_mac() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Running MacOS. Checking if reattech-to-user-namespace is installed."
        try_install reattach-to-user-namespace
    else
        echo "Not running MacOs. No need to try to install reattach-to-user-namespace."
    fi
}

install_git() {
    try_install git
    git config --global http.sslVerify false
}

install_fzf() {
    if command_installed "fzf"; then
        echo "fzf already installed"
        return
    fi

    if command_installed "brew"; then
        brew install fzf
        "$(brew --prefix)/opt/fzf/install":
    else
        echo "Installing fzf through git"
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
    fi
}

pull_dotfiles_from_github() {
    DOTFILES_REPO=https://github.com/LucasIME/dotfiles.git
    echo ".cfg" >> .gitignore
    git clone --bare $DOTFILES_REPO "$HOME"/.cfg
    config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
    mkdir -p .config-backup && \
        config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | \
        xargs -I{} mv {} .config-backup/{}
    $config checkout
    $config reset --hard
    $config pull
    $config config --local status.showUntrackedFiles no
}

install_oh_my_zsh() {
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh      )"
}

install_oh_my_zsh_plugins() {
    echo "Installing zsh syntax highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting

    echo "Installing zsh autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

    echo "Installing zsh completions"
    git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}"/plugins/zsh-completions

    try_install autojump
}

install_pure_prompt() {
    mkdir -p "$HOME/.zsh"
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
}

install_tmux_plugins() {
    echo "Cloning and installing Tmux plugin manager: tpm"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

### Main ###

install_package_manager_if_mac
install_reattach_to_user_namespace_if_mac
maybe_update_pkg_manager
install_git

programs_to_install=(vim neovim tmux zsh ripgrep)

for program in "${programs_to_install[@]}"; do try_install "$program"; done;

install_fzf
install_tmux_plugins
install_oh_my_zsh
install_oh_my_zsh_plugins
pull_dotfiles_from_github
install_pure_prompt
