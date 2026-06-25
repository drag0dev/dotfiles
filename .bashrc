#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

alias n="nvim"
alias tmux="tmux -2"

export EDITOR='nvim'
export PS1="[\e[1;34m\u\e[m@\e[0;31m\h\e[m \W]\$ "
. "$HOME/.cargo/env"
