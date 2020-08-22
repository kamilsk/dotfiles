#!/usr/bin/env bash

# Completion

if command -v brew >/dev/null; then
  if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
    # shellcheck source=/usr/local/etc/bash_completion
    source "$(brew --prefix)"/etc/bash_completion
  fi
fi
