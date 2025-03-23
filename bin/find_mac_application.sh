#!/bin/bash

# Thanks to https://stackoverflow.com/questions/51296900/on-macos-how-can-i-find-the-apps-path-which-opens-with-open-command 

if [ $# -ne 1 ]
then
  echo "$0 Application"
  exit 0
fi

APP=$1

if [ -d "${HOME}/Applications" ]
then
    APP_PTH="$(find "${HOME}/Applications" -name "${APP}.app" -maxdepth 1)"
fi

if [ -z "${APP_PTH:-}" ]
then
    APP_PTH="$(find /Applications -name "${APP}.app" -maxdepth 1)"
fi

if [ ! -z "${APP_PTH:-}" ]
then
    echo "${APP_PTH:-}"
fi
