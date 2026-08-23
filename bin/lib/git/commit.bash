#!/usr/bin/env bash

# TODO:deps(datetime) implicit dependency
git-at() {
  local _ts
  _ts=$(datetime "${1}")

  GIT_COMMITTER_DATE="${_ts}" git commit --date="${_ts}" -m "${*:2}"
}

git-amend() {
  local _ad _cd
  # https://git-scm.com/docs/git-log#Documentation/git-log.txt-emaIem
  _ad=$(git --no-pager log -1 --format="%aI")
  # https://git-scm.com/docs/git-log#Documentation/git-log.txt-emcIem
  _cd=$(git --no-pager log -1 --format="%cI")

  # https://git-scm.com/docs/git-commit#_commit_information
  # https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---amend
  # https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---dateltdategt
  # https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---no-edit
  GIT_COMMITTER_DATE="${_cd}" git commit --amend --date="${_ad}" --no-edit "${@}"
}

# https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html, see "$* vs. $@"
git-commit() { git commit -m "${*}"; }

git-contrib() {
  local target=25
  while [[ ${#} -gt 0 ]]; do
    case "${1}" in
    -t | --target)
      if [[ -z "${2:-}" ]]; then
        echo "git-contrib: ${1} requires a value" >&2
        return 2
      fi
      target="${2}"
      shift 2
      ;;
    --)
      shift
      break
      ;;
    *) break ;;
    esac
  done

  local _ts
  if ! _ts=$(maintainer github contribution suggest --target "${target}" git/3) || [[ -z "${_ts}" ]]; then
    echo "git-contrib: cannot suggest a timestamp for target ${target}" >&2
    return 1
  fi

  # Arguments keep the "${*}" semantics of git-commit, so `git contrib chore: msg`
  # still works and a single quoted argument keeps its newlines. With no arguments
  # the message is read from stdin (heredoc, pipe, file) or, on a terminal, from
  # the editor -- that is the way to pass a body containing both quote characters.
  local -a _msg=()
  if [[ ${#} -gt 0 ]]; then
    _msg=(-m "${*}")
  elif [[ ! -t 0 ]]; then
    _msg=(-F -)
  fi

  GIT_COMMITTER_DATE="${_ts}" git commit --date="${_ts}" ${_msg[0]+"${_msg[@]}"}
}

# TODO:deps(datetime) implicit dependency
git-it() {
  git init

  if [[ -n "${1:-}" ]]; then
    local _ts
    _ts=$(datetime "${1:-}")

    GIT_COMMITTER_DATE="${_ts}" git commit --allow-empty --date="${_ts}" --edit -m 'init the repository'
    return
  fi
  git commit --allow-empty --edit -m 'init the repository'
}

git-undo() { git reset --soft HEAD~"${1:-1}"; }
