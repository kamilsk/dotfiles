#!/usr/bin/env bash
# cp bash_completion.d/egg.sh /usr/local/etc/bash_completion.d/egg

_egg() {
    local cur prev

    return 0
}

complete -F _egg egg
