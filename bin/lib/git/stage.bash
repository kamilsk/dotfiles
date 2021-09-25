#!/usr/bin/env bash

git-stst() { git stash push --staged -m "${*}"; }

git-stsh() { git stash push --keep-index -m "${*}"; }

git-staash() { git stash push --include-untracked -m "${*}"; }

git-staaash() { git stash push --all -m "${*}"; }
