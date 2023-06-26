#!/bin/bash
alias vim=nvim
alias ll='ls -alF --group-directories-first'
alias ga='git add .'
alias gp='git pull'
alias gs='git status'

gc(){
    git commit -m "$1"
}

gac(){
    git add . && git commit -m "$1"
}
