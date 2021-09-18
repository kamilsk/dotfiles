#!/usr/bin/env bash

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
