#make ls use colors
export CLICOLOR=1

#define colors
export LSCOLORS=dxHxgxgxBxfxhxCxGxExFx

#make grep also use colors
export GREP_OPTIONS='--color=auto'

#sourcing git prompt to be able to use __git_ps1 to get current branch
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh

#Setting terminal header
export PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1;31m\]\u\[\e[1;36m\]\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]\[\e[0m\]\[\e[1;36m\]$(__git_ps1)\[\033[m\]\[\e[1;33m\]>\[\033[m\]"

