#!/usr/bin/env bash

brew-list() {
  {
    brew list --formula | awk '{print $1" https://formulae.brew.sh/formula/"$1}' &
    brew list --cask | awk '{print $1" https://formulae.brew.sh/cask/"$1}'
  } | sort | column -t | bat
}
