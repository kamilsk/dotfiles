#!/bin/bash
#
# bash completion for semaphore
#
# ln -sf "$(pwd)"/bash_completion.d/semaphore.sh "$(brew --prefix)"/etc/bash_completion.d/semaphore

_semaphore() {
    local cur prev

    return 0
}

complete -F _known_hosts semaphore
