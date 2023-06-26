#!/bin/bash
alias vim=nvim
alias ll='ls -alF --group-directories-first'
alias ga='git add .'
alias gP='git pull'
alias gp='git push'

gc(){
    git commit -m $1
}
