#!/usr/bin/env zsh

set -o nounset
set -o pipefail

alias some_alias="true"

function some_func { true; }

function lookup() {
  if [[ "${1:-}" == "git" ]]; then
    local alias
    alias="$(git config alias."${2:-}")"
    echo git alias: "${alias}"

    if echo "${alias}" | grep "!git_" >/dev/null; then
      lookup "$(echo "${alias}" | awk '{print $1}' | sed 's/!//g')"
    fi
    return
  fi

  local target
  target="$(command -v "${1:-}")"
  if [[ ! -f "${target}" ]]; then
    if [[ "${target}" =~ ^alias ]]; then
      echo "${target}"
    else
      which "${target}"
    fi
    return
  fi

  if file "${target}" | grep 'shell script'; then
    cat "${target}"
    return
  fi

  if file "${target}" | grep 'text'; then
    less "${target}"
    return
  fi

  file "${target}"
}

"${@}"
