#!/usr/bin/env bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

set -o noclobber
shopt -s extglob
shopt -s dotglob
shopt -s nullglob
shopt -s cdspell

# make less more friendly for non-text input files, see lesspipe(1)
if command -v lesspipe >> /dev/null
then
  eval "$(SHELL=/bin/sh lesspipe)"
fi

"${DOTFILES_PREFIX}/bin/set_windowtitle.sh" REPL
