#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias tkn='cat ~/token'
PS1='[\u@\h \W]\$ '

export EDITOR='nvim'
. "$HOME/.cargo/env"
