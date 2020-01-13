# MAIN BASH CONFIG 

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# if this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (linux)
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion.sh ]; then
	. /usr/share/bash-completion/bash_completion.sh
    elif [ -f /etc/bash_completion.sh ]; then
	. /etc/bash_completion.sh
    fi
fi

# enable programmable completion features (mac)
if [ -f $(brew --prefix)/etc/bash_completion.sh ]; then
    . $(brew --prefix)/etc/profile.d/bash_completion.sh
fi

# Set editor to vim and edit mode to vim
export VISUAL=nvim
export EDITOR="$VISUAL"

# Fix nvim colors inside tmux
if [ -n $TMUX ]; then
    alias nvim="TERM=screen-256color nvim"
fi

