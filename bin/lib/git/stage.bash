#!/usr/bin/env bash

git-stsh() { git stash --keep-index -m "${*}"; }

git-staash() { git stash --include-untracked -m "${*}"; }

git-staaash() { git stash --all -m "${*}"; }
