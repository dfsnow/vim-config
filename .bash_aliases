
# Setting up various bash aliases
alias c='clear'
alias l='ls -lah'
alias ll='ls -lah'
alias ld='du -h -d 1'
alias o='open .'

# Git related aliases, see .gitconfig
alias g='git'

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in $(git config --get-regexp '^alias\.' | cut -f 1 -d ' ' | cut -f 2 -d '.'); do

    alias g${al}="git ${al}"

    complete_func=_git_$(__git_aliased_command ${al})
    function_exists ${complete_fnc} && __git_complete g${al} ${complete_func}
done
unset al

# Alias for directory backtracking
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# fzf aliases
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# vim aliases to neovim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Determine OS platform
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" == "linux" ]; then
    # If available, use LSB to identify distribution
    if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
        export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    else
        export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
fi

# For Debian systems add alias for fd
if echo "$DISTRO" | grep -q "debian"; then alias fd=fdfind; fi
unset UNAME
