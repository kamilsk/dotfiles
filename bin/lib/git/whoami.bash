#!/usr/bin/env bash

git-whoami() {
  echo "$(git config user.name) <$(git config user.email)>"
}
