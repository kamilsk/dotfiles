#!/usr/bin/env bash

git-at() {
  local _ts
  # TODO:deps(datetime) implicit dependency
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

git-contribute() {
  local _ts
  _ts=$(maintainer github contribution suggest --short "$(git --no-pager log -1 --format="%as")")

  GIT_COMMITTER_DATE="${_ts}" git commit --date="${_ts}" -m "${*}"
}

git-undo() { git reset --soft HEAD~"${1:-1}"; }
