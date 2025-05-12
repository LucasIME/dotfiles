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

# Use neovim by default
alias vim="nvim"

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export JAVA_HOME=`/usr/libexec/java_home -v 15`
export PATH=/Users/lmeireles/.cargo/bi:$PATH:$HOME/anaconda3/bin:/usr/local/sbin
export GOPATH=/Users/lmeireles/Projects/GoProjs

ZSH_THEME="" # No theme because I'm usign Pure: https://github.com/sindresorhus/pure

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Zsh plugins
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

# Adding zsh-completions to fpath. Should be just before sourcing oh-my-zsh
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
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

# Pure promp
fpath+=$HOME/.zsh/pure
PURE_PROMPT_SYMBOL="λ"

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

# Utility to generate a shell command based on a prompt - based on https://github.com/day50-dev/llmehelp
my_shell_hook() {
  local QUESTION="$BUFFER"
  local SHELL=$(ps -p $$ -o command= | awk '{print $1}')
  local PROMPT="
  You are an experienced Linux engineer with expertise in all Linux
  commands and their
  functionality across different Linux systems.

  Given a task, generate a single command or a pipeline
  of commands that accomplish the task efficiently.
  This command is to be executed in the current shell, $SHELL.
  For complex tasks or those requiring multiple
  steps, provide a pipeline of commands.
  Ensure all commands are safe and prefer modern ways. For instance,
  homectl instead of adduser, ip instead of ifconfig, systemctl, journalctl, etc.
  Make sure that the command flags used are supported by the binaries
  usually available in the current system or shell.
  If a command is not compatible with the
  system or shell, provide a suitable alternative.

  The system information is: $(uname -a) (generated using: uname -a).
  The user is $USER. Use sudo when necessary

  Create a command to accomplish the following task: $QUESTION

  If there is text enclosed in paranthesis, that's what ought to be changed

  Output only the command as a single line of plain text, with no
  quotes, formatting, or additional commentary. Do not use markdown or any
  other formatting. Do not include the command into a code block.
  Don't include the shell itself (bash, zsh, etc.) in the command.
  "
  local model='gemma3'

  BUFFER="$QUESTION ... $model"
  zle -R
  local response=$(ollama run $model <<< "$PROMPT")
  local COMMAND=$(echo "$response" | sed 's/```//g' | tr -d '\n')
  echo "$(date) {$QUESTION | $response}" >> /tmp/shell-hook
  if [[ -n "$COMMAND" ]] ; then
      BUFFER="$COMMAND"
      CURSOR=${#BUFFER}
  else
      BUFFER="$QUESTION ... no results"
  fi
}

zle -N my_shell_hook

bindkey '^Xx' my_shell_hook

source <(fzf --zsh)

setopt APPEND_HISTORY

# zprof
