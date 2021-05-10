#!/usr/bin/env bash

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
