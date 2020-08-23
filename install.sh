#!/bin/bash

### Functions Block ###
command_installed() {
    if ! [ -x "$(command -v $1)" ]; then
        return 1
    else
        return 0
    fi
}

install() {
    if command_installed "brew"; then
        brew install $1
    elif command_installed "yum"; then
        yum install -y $1
    elif command_installed "apt-get"; then
        apt-get $1
    else
        echo "error can't install package $1"
        return 1;
    fi
}

try_install() {
    if command_installed $1; then
        echo $1' already installed'
    else
        echo 'Error: '$1' is not installed.' >&2
        echo 'Trying to install '$1
        install $1
    fi
}

### Installations that need specific commands ###
install_git() {
    try_install git
    git config --global http.sslVerify false
}

install_fzf() {
    if command_installed "brew"; then
        brew install fzf
        $(brew --prefix)/opt/fzf/install
    else
        echo "Could not install fzf"
    fi
}

pull_dotfiles_from_github() {
    nf
    DOTFILES_REPO=https://github.com/LucasIME/dotfiles.git
    echo ".cfg" >> .gitignore
    git clone --bare $DOTFILES_REPO $HOME/.cfg
    config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
    mkdir -p .config-backup && \
        config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
        xargs -I{} mv {} .config-backup/{}
    $config checkout
    $config reset --hard
    $config pull
    $config config --local status.showUntrackedFiles no
}

install_oh_my_zsh() {
    sh -c "$(curl -fsSLk https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

install_oh_my_zsh_plugins() {
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    try_install autojump
}

install_pure_prompt() {
    mkdir -p "$HOME/.zsh"
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
}

### Main ###

install_git
install_fzf

programs_to_install=(vim tmux zsh ripgrep)

for program in "${programs_to_install[@]}"; do try_install "$program"; done;

install_oh_my_zsh
install_oh_my_zsh_plugins
pull_dotfiles_from_github
install_pure_prompt
