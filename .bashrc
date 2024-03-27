# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export LS_COLORS=$LS_COLORS:'ow=1;34:'
export COLORTERM=truecolor
export XDG_CONFIG_HOME=~/.config
export NVM_DIR="$HOME/.nvm"
export PATH=$PATH:/usr/local/go/bin:/home/nealwp/.local/bin

if command -v nvim > /dev/null 2>&1; then
    export EDITOR='nvim'
elif command -v vim > /dev/null 2>&1; then
    export EDITOR='vim'
else
    export EDITOR='vi'
fi

HISTCONTROL=ignoreboth
HISTSIZE= HISTFILESIZE=

# shell options
shopt -s histappend
shopt -s checkwinsize
shopt -s autocd

# enable bash completiong
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\W\[\033[00m\] \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\W \$ '
fi

# setup nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ls aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -alF --color=auto --group-directories-first'
alias l='ls -CF'

# grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# editor aliases
alias vim='$EDITOR'
alias v='$EDITOR .'

# git aliases
alias ga='git add .'
alias gac='git add . && git commit -m'
alias gba='git branch -a'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gp='git push'
alias gP='git pull'
alias gpu='git push -u origin $(git branch --show-current)'
alias gs='git status'
