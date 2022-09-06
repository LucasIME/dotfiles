# zmodload zsh/zprof # Uncomment this lane and the last one to profile zsh startup time

# Alias for dotfiles config. Full tutorial at: https://legacy-developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Most used commands
alias mostused='history | awk '\''{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}'\'' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10'

# Show most changed files on git repo
alias gitmostused='git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10'

# Reset numbers of tmux windows
alias tmuxreset='tmux movew -r'

# Largest dirs
alias ldir='du -hs */ | sort -hr | head'

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export JAVA_HOME=`/usr/libexec/java_home -v 15`
export PATH=/Users/lmeireles/.cargo/bi:$PATH:$HOME/anaconda3/bin:/usr/local/sbin
export GOPATH=/Users/lmeireles/Projects/GoProjs

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="" # No theme because I'm usign Pure: https://github.com/sindresorhus/pure

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions autojump zsh-completions)

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

source $ZSH/oh-my-zsh.sh

# Vim mode
#bindkey -v
#export KEYTIMEOUT=1 # Making <ESC> to change mode be registered faster. Changes default delay from 0.4s to 0.1s
# Change cursor shape for different vi modes.
#    function zle-keymap-select {
#      if [[ ${KEYMAP} == vicmd ]] ||
#         [[ $1 = 'block' ]]; then
#        echo -ne '\e[1 q'
#
#      elif [[ ${KEYMAP} == main ]] ||
#           [[ ${KEYMAP} == viins ]] ||
#           [[ ${KEYMAP} = '' ]] ||
#           [[ $1 = 'beam' ]]; then
#        echo -ne '\e[5 q'
#      fi
#    }
#    zle -N zle-keymap-select

# _fix_cursor() {
#   echo -ne '\e[5 q'
#}

#precmd_functions+=(_fix_cursor)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Pure promp
fpath+=$HOME/.zsh/pure
PURE_PROMPT_SYMBOL="λ"

# added by travis gem
[ -f /Users/lmeireles/.travis/travis.sh ] && source /Users/lmeireles/.travis/travis.sh


autoload -U promptinit; promptinit
prompt pure

# Block for only loading nvm when using it, so shell starts faster
nvm() {
    unset -f nvm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm "$@"
}

node() {
    unset -f node
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    node "$@"
}

npm() {
    unset -f npm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    npm "$@"
}

setopt APPEND_HISTORY

# zprof
