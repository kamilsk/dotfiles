#!/usr/bin/env bash

#include:bin/lib/git/aliases.bash|uncomment
alias pull=git-pull
alias push=git-push
#end

#include:bin/lib/git/commit.bash|uncomment
git-at() {
  local _ts
  _ts=$(datetime "${1}")

  GIT_COMMITTER_DATE="${_ts}" git commit --date="${_ts}" -m "${*:2}"
}

git-amend() {
  local _ad _cd
  _ad=$(git --no-pager log -1 --format="%aI")
  _cd=$(git --no-pager log -1 --format="%cI")

  GIT_COMMITTER_DATE="${_cd}" git commit --amend --date="${_ad}" --no-edit "${@}"
}

git-commit() { git commit -m "${*}"; }

git-contribute() {
  local _ts
  _ts=$(maintainer github contribution suggest --short "$(git --no-pager log -1 --format="%as")")

  GIT_COMMITTER_DATE="${_ts}" git commit --date="${_ts}" -m "${*}"
}

git-undo() { git reset --soft HEAD~"${1:-1}"; }
#end

#include:bin/lib/git/sync.bash|uncomment
git-pull() {
  if ! git diff-index --quiet HEAD; then
    git stash
    trap '{ git stash pop; }' EXIT
  fi

  git fetch --all --prune --prune-tags --tags
  git pull --force --rebase
  git submodule update --init --recursive --remote --rebase
}

git-push() {
  local branch
  branch=$(git branch | cut -f2 -d' ' | awk 'NF > 0')

  for remote in $(git remote | grep -v upstream); do
    git push "${remote}" "${branch}" --tags
  done
}
#end
