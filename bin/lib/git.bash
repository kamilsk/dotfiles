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

git-contrib() {
  local _ts
  _ts=$(maintainer github contribution suggest git/3)

  GIT_COMMITTER_DATE="${_ts}" git commit --date="${_ts}" -m "${*}"
}

git-it() {
  git init

  if [[ -n "${1:-}" ]]; then
    local _ts
    _ts=$(datetime "${1:-}")

    GIT_COMMITTER_DATE="${_ts}" git commit --allow-empty --date="${_ts}" --edit -m root
    return
  fi
  git commit --allow-empty --edit -m root
}

git-undo() { git reset --soft HEAD~"${1:-1}"; }
#end

#include:bin/lib/git/stage.bash|uncomment
git-stst() { git stash push --staged -m "${*}"; }

git-stsh() { git stash push --keep-index -m "${*}"; }

git-staash() { git stash push --include-untracked -m "${*}"; }

git-staaash() { git stash push --all -m "${*}"; }
#end

#include:bin/lib/git/sync.bash|uncomment
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
  branch=$(git branch | cut -f2 -d' ' | awk 'NF > 0')

  for remote in $(git remote | grep -Ev '^(upstream|fork-.*)$'); do
    git push --tags "${remote}" "${branch}"
  done
}
#end

#todo:source
carloson() {
  git config user.name 'Kamil Samigullin'
  git config user.email 'consulting+carloson.ru@octolab.net'
  git config user.signingKey F243F63DC76D53B7
  git config commit.gpgSign true
  git config tag.gpgSign true
}
#end
