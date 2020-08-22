#!/usr/bin/env bash
# https://github.com/kamilsk/dotfiles/issues/73

set -o nounset
set -o pipefail

declare -a arr=(
  'https://github.com/kamilsk/retry.git'
  'git@github.com:kamilsk/retry.git'
  'https://kamilsk@bitbucket.org/kamilsk/retry.git'
  'git@bitbucket.org:kamilsk/retry.git'
  'ssh://git@stash.msk.avito.ru:7999/gl/item-aggregator.git'
)

for package in "${arr[@]}"; do

  package=${package/%.git/}
  package=${package/#https:\/\//}
  package=${package/#*@/}

  # use `declare -A map` in Bash 4 instead
  package=${package/stash.msk.avito.ru:7999/go.avito.ru}

  package=${package/:/\/}
  echo "${package}"

done
