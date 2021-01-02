#!/usr/bin/env bash

clone() {
  # working with specific ssh key. examples
  #  - -k ~/.ssh/id_ed25519
  #  - --key ~/.ssh/id_ed25519
  #  - --key=~/.ssh/id_ed25519
  local key args=()
  while (($# > 0)); do
    case "${1}" in
    -k|--key)
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

  # working with git. examples
  #  - clone git@github.com:octolab/pkg.git
  #  - clone git@github.com:octolab/pkg.git dst
  #  - clone git@github.com:octolab/pkg.git#v0.12.0
  #  - clone git@github.com:octolab/pkg.git#v0.12.0 dst
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

  # working with files. examples
  #  - clone file
  #  - clone file dst
  #  - clone dir
  #  - clone dir dst
  if [ -z "${dst}" ]; then dst="copy of $(basename "${src}")"; fi
  if [ -f "${src}" ]; then cp "${src}" "${dst}" && cd "${dst}" || return 1; fi
  if [ -d "${src}" ]; then cp -r "${src}" "${dst}" && cd "${dst}" || return 1; fi
  return 0
}
