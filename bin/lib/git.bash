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

  GIT_COMMITTER_DATE="${_cd}" git commit --amend --date="${_ad}" --no-edit ${1+"${@}"}
}

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

  local -a _msg=()
  if [[ ${#} -gt 0 ]]; then
    _msg=(-m "${*}")
  elif [[ ! -t 0 ]]; then
    _msg=(-F -)
  fi

  GIT_COMMITTER_DATE="${_ts}" git commit --date="${_ts}" ${_msg[0]+"${_msg[@]}"}
}

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
  branch=$(git branch --show-current)
  if [ -z "${branch}" ]; then
    echo "git-push: detached HEAD" >&2
    return 1
  fi

  for remote in $(git remote | grep -Ev '^(upstream|fork-.*)$'); do
    git push --tags "${remote}" "${branch}"
  done
}
#end
