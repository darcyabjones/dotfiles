#!/usr/bin/env bash

if [ "$#" -eq 0 ]
then
  echo "$0 [REPL|message]"
fi

TITLE="${@}"

find_repl() {
  # This tests if we're in bash or zsh or whatever.
  # Obvs we're in bash if we're running this but whatever.
  REPL="$(ps -p $$ -o 'comm=')"
  # Sometimes this has a hyphen at the beginning
  REPL="${REPL/#-/}"
  echo "${REPL}"
}

generate_repl_title() {
  if [ ! -z "${HOSTNAME:-}" ]
  then
    HOSTNAME="$(hostname)"
  fi

  REPL="$(find_repl REPL)"

  if [ ! -z "${SSH_TTY:-}" ]
  then
      echo "${HOSTNAME} ${REPL}"
  else
      echo "${REPL}"
  fi
}

if [[ "${TITLE}" == "REPL" ]]
then
  TITLE="$(generate_repl_title)"
fi

echo -ne "\033]0;${TITLE}\007"
