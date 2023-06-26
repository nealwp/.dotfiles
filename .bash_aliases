#!/bin/bash
alias vim=nvim
alias ll='ls -alF --group-directories-first'
alias ga='git add .'
alias gp='git push'
alias gs='git status'
alias gpu='git push -u origin ${git branch --show-current}'

gc(){
    git commit -m "$1"
}

gac(){
    git add . && git commit -m "$1"
}
