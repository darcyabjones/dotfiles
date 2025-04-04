#!/usr/bin/env bash

if command -v brew >> /dev/null
then
    if [ -z "${HOMEBREW_PREFIX:-}" ]
    then
        export HOMEBREW_PREFIX="$(brew --prefix)"
    fi

    eval "$(brew shellenv)"
fi


if [ -d "/Applications/Alacritty.app" ]
then
    ALACRITTY_PREFIX="/Applications/Alacritty.app"
else
    ALACRITTY_PREFIX="$("${DOTFILES_PREFIX}"/bin/find_mac_application.sh "Alacritty")"
fi

if [ ! -z "${ALACRITTY_PREFIX:-}" ] && [ -d "${ALACRITTY_PREFIX:-}/Contents/MacOS" ]
then
  export PATH="${ALACRITTY_PREFIX}/Contents/MacOS/:${PATH}"
fi

# Sets dircolors for mac
export LSCOLORS="ExCxdxdxBxheaghbadAbAbxx"
