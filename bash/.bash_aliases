# Alias common navigation commands
alias c='clear'
alias l='ls -hG --color=auto'
alias ls='ls -hG --color=auto'
alias ll='ls -lahG --color=auto'
alias ld='du -h -d 1'
alias o='open .'

# Git related aliases automatically added by .gitconfig
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

# Aliases for directory backtracking
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Fzf aliases
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Vim aliases to neovim
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
