#!/usr/bin/env bash

git-pull() {
  if ! git diff-index --quiet HEAD; then
    git stash -m 'stash before pull'
    trap '{ git stash pop; }' EXIT
  fi

  git pull --force --prune --rebase --tags "${@:---all}"
  git submodule update --init --rebase --recursive --remote
}

git-push() {
  local branch
  branch=$(git branch --show-current)
  if [ -z "${branch}" ]; then
    echo "git-push: detached HEAD" >&2
    return 1
  fi

  for remote in $(git remote | grep -Ev '^(upstream|fork-.*)$'); do
    git push --tags "${remote}" "${branch}"
  done
}
