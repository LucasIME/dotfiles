#!/bin/sh

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
        yum install $1
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
    install "git"
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
    DOTFILES_REPO=https://github.com/LucasIME/dotfiles.git
    echo ".cfg" >> .gitignore
    git clone --bare $DOTFILES_REPO $HOME/.cfg
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    mkdir -p .config-backup && \
        config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
        xargs -I{} mv {} .config-backup/{}
    config checkout
    config reset --hard
    config pull
    config config --local status.showUntrackedFiles no
}

install_oh_my_zsh() {
    sh -c "$(curl -fsSLk https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

### Main ###

install_git
pull_dotfiles_from_github
install_fzf

programs_to_install=(vim tmux zsh ripgrep)

for program in "${programs_to_install[@]}"; do try_install "$program"; done;

install_oh_my_zsh

