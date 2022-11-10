#!/usr/bin/env bash

_bins="${HOME}/.dotfiles/bin"
_brew="/opt/homebrew/bin:/opt/homebrew/sbin"
_dock="${HOME}/.docker/bin"
_hack="${HOME}/go/bin"

# How to control your PATH
#
# ```bash
# $ zsh -xl
#
# $ cat /etc/zprofile
# $ /usr/libexec/path_helper -s
#
# $ cat ~/.zprofile
#
# $ la /etc/paths.d/
#
# $ brew --prefix
# $ brew shellenv
# ```
#
# Docs:
# - https://www.softec.lu/site/DevelopersCorner/MasteringThePathHelper
# - https://unix.stackexchange.com/questions/22979/path-helper-and-zsh
[[ $SHLVL -eq 1 ]] && export PATH="${_hack}:${_bins}:${_brew}:${_dock}:${PATH}"

path() {
  for arg in "${@}"; do
    case "${arg}" in
    check)
      echo "${PATH}" | tr ':' '\n' | xargs file
      return 0
      ;;

    has)
      shift
      for path in "${@}"; do
        echo Looking for "${path}"
        local strict any
        strict=$([[ ":${PATH}:" == *":${path}:"* ]] && echo "➕" || echo "➖")
        any=$(echo "${PATH}" | tr ':' '\n' | grep "${path}")
        printf 'strict: %s\n\n' "${strict}"
        if [ -z "${any}" ]; then
          printf 'any: %s\n\n' "➖"
        else
          printf 'any:\n%s\n\n' "${any}"
        fi
      done
      return 0
      ;;

    *)
      echo Unknown command: "${arg}"
      return 1
      ;;
    esac
  done

  echo "${PATH}" | tr ':' '\n' | cat
}

[[ $SHLVL -eq 2 ]] && "${@}"
