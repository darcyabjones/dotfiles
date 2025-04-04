#!/usr/bin/env bash

if command -v nvim >> /dev/null
then
    alias vim='nvim'
elif command -v gvim >> /dev/null
then
    alias vim='gvim -v'
fi
