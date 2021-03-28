#!/usr/bin/env bash

function activate() {
  if [[ -f bin/activate ]]; then
    source bin/activate
    return
  fi
  if [[ -f .virtenv/bin/activate ]]; then
    source .virtenv/bin/activate
    return
  fi
  (echo >&2 'nothing to do')
  return 1
}

function datetime() {
  local iso="%Y-%m-%dT%H:%M:%S%Z"

  local mutator
  mutator=$(echo "${1:-}" | sed 's:\([[:alpha:]]\):\1 :g')
  if [ -z "${mutator}" ]; then
    date +${iso}
    return
  fi

  # $ datetime 2021-03-28
  # -> -416d
  if [[ "$mutator" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    local day=$((24*60*60))
    local now req
    now=$(date +%s)
    req=$(date -jf %Y-%m-%d +%s "${mutator}")
    echo $(((req - now) / day))d
    return
  fi

  # $ datetime -416d
  # -> 2021-03-28
  local sign=+
  if [[ "${mutator}" == -* ]]; then
    mutator="${mutator##-}"
    sign=-
  fi

  local v
  for m in $(echo "${mutator}" | cat); do
    v+="-v${sign}${m} "
  done
  eval "date -j ${v}+${iso}"
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

function newdir() {
  if [[ -z "${1:-}" ]]; then
    echo 'Please provide a dir name'
    return
  fi
  mkdir -p "${1}"
  cd "${_}" || return
}

function realpath() {
  if [[ -z "${1:-}" ]]; then
    echo 'Please provide a file/dir name'
    return
  fi
  echo "$(cd "$(dirname "${1}")" && pwd)/${1}"
}

if command -v lsof >/dev/null; then
  function wholisten() {
    local port=${1:-}
    if [[ -z "${port}" ]]; then
      lsof -nP | grep LISTEN
    else
      lsof -nP -i4TCP:"${port}" | grep LISTEN
    fi
  }
fi

[[ $SHLVL -eq 2 ]] && "${@}"
