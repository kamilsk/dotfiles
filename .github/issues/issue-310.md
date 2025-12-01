---
id: 310
database_id: 1252487892
node_id: I_kwDOCTsueM5Kp3LU
status: closed
title: "git: pull from remote"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/310
created_at: 2022-05-30T09:55:47Z
updated_at: 2022-07-29T15:09:45Z
---

# git: pull from remote

**Motivation:** there is no way to specify a remote for pulling.

```bash
git-pull () {
        if ! git diff-index --quiet HEAD
        then
                git stash
                trap '{ git stash pop; }' EXIT
        fi
        git fetch --all --prune --prune-tags --tags
        git pull --force --rebase
        git submodule update --init --recursive
}
```

But sometimes, I work with forks and want to sync branches from upstream.

```bash
$ pull
# fetch from attached remote
$ git remote add upstream fork.git
$ pull upstream main
# fetch from specified remote
```
