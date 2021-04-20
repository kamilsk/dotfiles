#!/usr/bin/env bash

set -o nounset
set -o pipefail

alias demo_alias="test"

function demo_func() {
  true
}

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
    which "${target}"
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
