#!/usr/bin/env bash

#include:bin/lib/sys/clone.bash|uncomment
clone() {
  local key args=()
  while (($# > 0)); do
    case "${1}" in
    -k | --key)
      key="${2:-}"
      shift
      shift
      ;;
    --key=*)
      key="${1#*=}"
      shift
      ;;
    -*)
      echo Unknown option "${1}"
      return 1
      ;;
    *)
      args+=("${1}")
      shift
      ;;
    esac
  done
  set -- "${args[@]}"

  local src=${1:-} dst=${2:-}

  if [ -z "${src}" ]; then return 1; fi

  if [[ "${src}" == git@* ]]; then
    local rev=HEAD
    if [[ "${src}" == *#* ]]; then
      rev=$(cut -d'#' -f2 <<<"${src}")
      src=$(cut -d'#' -f1 <<<"${src}")
    fi
    if [ -z "${dst}" ]; then dst=$(basename "${src}" | sed 's/.git//g'); fi

    if [ -n "${key}" ]; then
      GIT_SSH_COMMAND="ssh -i ${key}" git clone "${src}" "${dst}" && cd "${dst}" || return 1
    else
      git clone "${src}" "${dst}" && cd "${dst}" || return 1
    fi
    git checkout "${rev}"
    return 0
  fi

  if [ -z "${dst}" ]; then dst="copy of $(basename "${src}")"; fi
  if [ -f "${src}" ]; then cp "${src}" "${dst}" && cd "${dst}" || return 1; fi
  if [ -d "${src}" ]; then cp -r "${src}" "${dst}" && cd "${dst}" || return 1; fi
  return 0
}
#end

#include:bin/lib/sys/debug.bash|uncomment
debug() { env -i HOME="${HOME}" bash -clx "${*}"; }

explain() { open "https://explainshell.com/explain?cmd=${*}"; }
#end

#include:bin/lib/sys/path.bash|uncomment
fsnotes() { cd "${HOME}/Library/Mobile Documents/iCloud~co~fluder~fsnotes/Documents" || return 1; }

obsidian() { cd "${HOME}/Library/Mobile Documents/iCloud~md~obsidian/Documents" || return 1; }

tap() { cd "$(brew --prefix)/Library/Taps/${1:-}" || return 1; }
#end

#include:bin/lib/sys/strings.bash|uncomment
lower() {
  if [ -t 0 ]; then
    echo "$*" | tr '[:upper:]' '[:lower:]'
  else
    tr '[:upper:]' '[:lower:]'
  fi
}

upper() {
  if [ -t 0 ]; then
    echo "$*" | tr '[:lower:]' '[:upper:]'
  else
    tr '[:lower:]' '[:upper:]'
  fi
}
#end
