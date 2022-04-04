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

function suggest() {
  local iso="%Y-%m-%d 08:00:00 %z" # truncated ISO 8601-like format, see `git log`
  local target=${1:-5}

  local short
  short=$(git --no-pager log --format=%cs -1)

  # TODO:feat use stderr to output stats and stdout to output --short
  #  it will be better and shows the stats instead two calls
  local suggest1 suggest2
  suggest1=$(maintainer github contribution suggest --short --target="${target}" "${short}"/0)
  suggest1=$(date -jf %FT%T +"${iso}" "${suggest1}" 2>/dev/null)
  suggest2=$(git --no-pager log --format=%ci -1)

  local suggest
  if [[ "${suggest1}" > "${suggest2}" ]]; then
    short=$(date -jf %Y-%m-%d +%Y-%m-%d "${suggest1}" 2>/dev/null)
    suggest=$(datetime --jitter "${suggest1}")
  else
    short=$(date -jf %Y-%m-%d +%Y-%m-%d "${suggest2}" 2>/dev/null)
    suggest=$(datetime --jitter "${suggest2}")
  fi
  # TODO:bug it shows incomplete state, see date 2022-04-04/10
  # maintainer github contribution suggest --delta --target="${target}" "${short}"/10 1>&2
  maintainer github contribution lookup "${short}"/10 1>&2
  echo "${suggest}"
}

function datetime() {
  local iso="%Y-%m-%d %H:%M:%S %z" # ISO 8601-like format, see `git log`
  local minute=$((60))
  local hour=$((60 * minute))
  local day=$((24 * hour))

  local jitter=0
  if [[ "${1:-}" =~ --jitter ]]; then
    jitter=$((RANDOM % (3 * hour) + hour))
    shift
  fi

  local mutator
  mutator=$(echo "${@:-}" | sed 's:\([[:alpha:]]\):\1 :g')
  if [ -z "${mutator}" ]; then
    date +"${iso}"
    return
  fi

  # $ datetime $(git log --pretty=format:'%ci' | head -1)
  # -> -416d12H17M
  if [[ "$mutator" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2} ]]; then
    local now req sign=+
    now=$(($(date +%s) - jitter))
    req=$(date -jf "${iso}" +%s "${mutator}")
    [ "${now}" -gt "${req}" ] && sign=-

    local days=$(((now - req) / day))
    local hours=$(((now - req - days * day) / hour))
    local minutes=$(((now - req - days * day - hours * hour) / minute))

    local result="${sign}${days#-}d"
    if [ $hours -ne 0 ]; then
      result+="${hours#-}H"
    fi
    if [ $minutes -ne 0 ]; then
      result+="${minutes#-}M"
    fi
    echo "${result}"
    return
  fi

  # $ datetime -416d12H17M
  # -> 2022-01-09 08:35:31 +0300
  local sign=+
  if [[ "${mutator}" == -* ]]; then
    mutator="${mutator##-}"
    sign=-
  fi

  local v
  for m in $(echo "${mutator}" | cat); do
    v+="-v${sign}${m} "
  done
  eval "date -j ${v}+'${iso}'"
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
