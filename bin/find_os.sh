#!/usr/bin/env bash

set -euo pipefail

if [ -z "${OSTYPE:-}" ]
then
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "linux"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "mac"
  elif [[ "$OSTYPE" == "cygwin" ]]; then
    echo "cygwin"
  elif [[ "$OSTYPE" == "msys" ]]; then
    echo "msys"
  elif [[ "$OSTYPE" == "freebsd"* ]]; then
    echo "freebsd"
  fi
elif uname >> /dev/null
then
  THIS_OS="$(uname -s)"
  if [[ "${THIS_OS}" == "Darwin" ]]; then
    echo "mac"
  elif [[ "${THIS_OS}" == "Linux" ]]; then
    echo "linux"
  elif [[ "${THIS_OS^^}" == "CYGWIN"* ]]; then
    echo "cygwin"
  elif [[ "${THIS_OS^^}" == "MSYS"* ]]; then
    echo "msys"
  fi
fi
