#!/usr/bin/env bash

_bins="${HOME}/.dotfiles/bin"
_brew="/opt/homebrew/bin:/opt/homebrew/sbin"
_hack="/usr/local/sbin:${HOME}/go/bin"

export PATH="${_bins}:${_brew}:${_hack}:${PATH}"

path() {
  if [ "${1:-}" = 'check' ]; then
    echo "${PATH}" | tr ':' '\n' | xargs file
    return $?
  fi

  echo "${PATH}" | tr ':' '\n' | cat
}
