#!/usr/bin/env bash

fsnotes() { cd "${HOME}/Library/Mobile Documents/iCloud~co~fluder~fsnotes/Documents" || return 1; }

obsidian() { cd "${HOME}/Library/Mobile Documents/iCloud~md~obsidian/Documents" || return 1; }

tap() { cd "$(brew --prefix)/Library/Taps/${1:-}" || return 1; }
