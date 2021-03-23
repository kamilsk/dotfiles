#!/usr/bin/env bash

# Environment

set +o histexpand

export GOPATH="${HOME}/go"
export PATH="${HOME}/.dotfiles/bin:${GOPATH}/bin:/usr/local/sbin:${PATH}"

function sign-in() {
    if command -v ngrok >/dev/null && test -v NGROK_TOKEN; then
      ngrok authtoken "${NGROK_TOKEN}"
    fi

    if command -v travis >/dev/null && test -v GITHUB_TOKEN; then
      travis login --com --github-token="${GITHUB_TOKEN}"
    fi
}

# Common

alias ..="cd ../"
alias ...="cd ../../"
alias dotfiles="cd ~/.dotfiles"

alias cwd="pwd | tr -d '\n' | pbcopy"
alias dots="ls \.*"

alias isodate="date +'%Y-%m-%d'"
alias isodatetime="date +'%Y-%m-%dT%H:%M:%S%Z'"
alias timestamp="date +%s"

alias append="cat <<EOF >>"
alias edit="cat <<EOF >"

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

# macOS

alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"

function fix_xcrun() {
  sudo xcode-select --reset
  sudo rm -rf /Library/Developer/CommandLineTools
  if ! xcode-select --install; then
    sudo xcode-select --install
  fi
}

function touch_sudo() {
  cat /etc/pam.d/sudo
  if ! grep 'pam_tid.so' /etc/pam.d/sudo; then
    echo '# sudo: auth account password session' >/tmp/sudo
    echo 'auth       sufficient     pam_tid.so' >>/tmp/sudo
    cat </etc/pam.d/sudo | grep -v '# sudo' >>/tmp/sudo
    sudo mv /tmp/sudo /etc/pam.d/sudo
    cat /etc/pam.d/sudo
  fi
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

# Fun

alias shrug='echo "¯\_(ツ)_/¯"'
alias tflip='echo "（╯°□°）╯︵┻━┻"'

# Git

function pull() {
  git fetch --all --tags || true
  git pull --all --force --prune --rebase
  git submodule update --init --recursive
}

function push() {
  local branch
  branch="$(git branch | cut -f2 -d' ' | awk 'NF > 0')"
  for remote in $(git remote | grep -v upstream); do
    git push "${remote}" "${branch}" --tags
  done
}

alias g@="git config user.name 'Kamil Samigullin' && git config user.email 'kamil@samigullin.info'"
alias g+="pull"
alias g-="git tableflip"
alias g^="push"

# Docker

if command -v docker >/dev/null; then
  function container() {
    docker exec -it "${1}" /bin/sh
  }

  function containers() {
    case "${1-}" in
    all)
      docker ps --all | tail -n +2
      ;;
    *)
      docker ps | tail -n +2
      ;;
    esac
  }

  function images() {
    case "${1-}" in
    all)
      docker images --all | tail -n +2
      ;;
    clean)
      docker rmi "$(docker images -q -f dangling=true)" 2>/dev/null
      docker system prune -f
      ;;
    pull)
      images "$@" | awk '{print $1":"$2}' | xargs -n1 docker pull
      ;;
    *)
      docker images | grep -v '<none>' | tail -n +2
      ;;
    esac
  }

  function truncate_docker_logs() {
    truncate -s 0 "$(docker inspect --format='{{.LogPath}}' "${1}")"
  }

  function volume() {
    docker run --rm -it -v "${1}":/view -w /view alpine:latest
  }

  function volumes() {
    case "${1-}" in
    all)
      docker volume ls | tail -n +2
      ;;
    clean)
      volumes all |
        awk '{print $2}' |
        grep -E '[[:alnum:]]{64}' |
        xargs docker volume rm
      ;;
    *)
      volumes all | grep -E -v '[[:alnum:]]{64}' || true
      ;;
    esac
  }
fi

# Package management

if command -v brew >/dev/null; then
  alias brew+="brew_update"
fi
if command -v composer >/dev/null; then
  alias composer+="sudo composer self-update; \
                   composer global update"
fi
if command -v gem >/dev/null; then
  alias gem+="sudo gem update --system; \
              gem list | cut -d ' ' -f1 | xargs -n1 sudo gem update"
fi
if command -v npm >/dev/null; then
  alias npm+="npm install -g npm && npm update -g"
fi
if command -v pip >/dev/null; then
  alias pip+="pip list | cut -d ' ' -f1 | xargs -n1 sudo pip install --upgrade"
elif command -v pip3 >/dev/null; then
  alias pip+="pip3 list | cut -d ' ' -f1 | tail -n +3 | xargs -n1 pip3 install --upgrade"
fi

# Python

alias v@="python3 -m venv .virtenv"
alias v+="source .virtenv/bin/activate"
alias v-="deactivate"
alias v^="pip list | cut -d ' ' -f1 | tail -n +3 | xargs -n1 pip install --upgrade"

# Sublime

if ! command -v subl >/dev/null && [[ -x "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ]]; then
  alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
fi

# Ubuntu

if ! command -v journalctl >/dev/null; then
  alias oom="sudo journalctl -k | grep -i -e memory -e oom"
fi

# Visual Studio Code

if ! command -v code >/dev/null && [[ -x "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]]; then
  alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
fi
