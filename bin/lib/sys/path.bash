#!/usr/bin/env bash

books() {
  cd "$(
    gum choose \
      "${HOME}/Library/Mobile Documents/iCloud~com~apple~iBooks/Documents" \
      "${HOME}/Library/Containers/com.apple.BKAgentService/Data/Documents/iBooks/Books/Audiobooks"
  )" || return 1
  du -h -- * | sort -h
}

filetypes() {
  find "${1}" -type f -not -path "*/.*" |
    sed -n 's/.*\.\([^.]*\)$/\1/p' |
    sort |
    uniq
}

obsidian() { cd "${HOME}/Library/Mobile Documents/iCloud~md~obsidian/Documents" || return 1; }

taps() { cd "$(brew --prefix)/Library/Taps/${1:-}" || return 1; }
