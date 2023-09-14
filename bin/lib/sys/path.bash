#!/usr/bin/env bash

obsidian() { cd "${HOME}/Library/Mobile Documents/iCloud~md~obsidian/Documents" || return 1; }

tap() { cd "$(brew --prefix)/Library/Taps/${1:-}" || return 1; }
