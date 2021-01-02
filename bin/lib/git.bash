#!/usr/bin/env bash

#include:bin/lib/git/aliases.bash|uncomment
alias pull=git-pull
alias push=git-push
#end

#include:bin/lib/git/sync.bash|uncomment
git-pull() {
  if ! git diff-index --quiet HEAD; then
    git stash
    trap '{ git stash pop; }' EXIT
  fi

  git fetch --all --prune --prune-tags --tags
  git pull --force --rebase
  git submodule update --init --recursive
}

git-push() {
  local branch
  branch=$(git branch | cut -f2 -d' ' | awk 'NF > 0')

  for remote in $(git remote | grep -v upstream); do
    git push "${remote}" "${branch}" --tags
  done
}
#end
