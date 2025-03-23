#!/usr/bin/env bash

# On a mac it usually only sources the bash_profiles.
# We want to load bashrc for interactive sessions.
# $- tells us if it's interactive.
# Note that inside the bashrc it also checks to see if it's interactive.
if [ -s "${HOME}/.bashrc" ] && [[ "$-" = *"i"* ]]; then
  . "${HOME}/.bashrc"
fi
