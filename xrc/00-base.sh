#!/usr/bin/env bash

#stty -ixon

UNAME=$(uname)
export VISUAL=vim
export EDITOR="${VISUAL}"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export DOTFILES_PREFIX="${HOME}/.dotfiles"

if [ -d "${HOME}/.local" ]
then
  export PATH="${HOME}/.local/bin:${PATH}"
fi

DOTFILES_OS="$(${DOTFILES_PREFIX}/bin/find_os.sh)"

# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cp-force="$(command -v 'cp')"
alias mv-force="$(command -v 'mv')"
alias cp='cp -i'
alias mv='mv -i'
