#!/usr/bin/env bash

export DOT=$HOME/.dotfiles

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && source "/usr/local/etc/profile.d/bash_completion.sh"

for script in "${DOT}"/bin/lib/*.bash; do
  # shellcheck source=./../../bin/lib/env.bash
  source "${script}"
done
