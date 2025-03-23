#!/usr/bin/env bash

if command -v nvim
then
    alias vim='nvim'
elif command -v
then
    alias vim='gvim -v'
fi
