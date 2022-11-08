#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

alias wet='curl wttr.in/Temerin'
alias r="xplr"
alias n="nvim"
alias tmux="tmux -2"
alias ls="exa"
alias g="git"

# bun
export BUN_INSTALL="/home/drago/.bun"
export PATH="$BUN_INSTALL/bin:/home/drago/.fly/bin:$PATH"

export EDITOR='nvim'
export PS1="[\e[1;34m\u\e[m@\e[0;31m\h\e[m \W]\$ "
. "$HOME/.cargo/env"
