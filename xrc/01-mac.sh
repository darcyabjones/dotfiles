#!/usr/bin/env bash

if [ -z "${HOMEBREW_PREFIX:-}" ]
then
    if command -v brew >> /dev/null
    then
        export HOMEBREW_PREFIX="$(brew --prefix)"
    fi
fi

if [ -d "/Applications/Alacritty.app" ]
then
    ALACRITTY_PREFIX="/Applications/Alacritty.app"
else
    ALACRITTY_PREFIX="$("${DOTFILES_PREFIX}"/bin/find_mac_application.sh "Alacritty")"
fi

if [ -d "${ALACRITTY_PREFIX}/Contents/MacOS" ]
then
  export PATH="${ALACRITTY_PREFIX}/Contents/MacOS/:${PATH}"
fi

if [ -s "$(brew --prefix nvm)/nvm.sh" ]
then
  . "$(brew --prefix nvm)/nvm.sh"
  . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

# Sets dircolors for mac
export LSCOLORS="ExCxdxdxBxheaghbadAbAbxx"
