#!/usr/bin/env bash
# ln -s `pwd`/bash_completion.d/semaphore.sh /usr/local/etc/bash_completion.d/semaphore

_semaphore() {
    local cur prev

    return 0
}

complete -F _known_hosts semaphore
