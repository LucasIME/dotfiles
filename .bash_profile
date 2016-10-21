#make ls use colors
export CLICOLOR=1

#define colors
export LSCOLORS=dxHxgxgxBxfxhxCxGxExFx

#make grep also use colors
export GREP_OPTIONS='--color=auto'

#Setting terminal header
export PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1;31m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"

