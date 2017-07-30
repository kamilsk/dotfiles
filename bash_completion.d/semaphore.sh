#!/usr/bin/env bash
# cp bash_completion.d/semaphore.sh /usr/local/etc/bash_completion.d/retry

_semaphore() {
    local cur prev

    return 0
}

complete -F _semaphore semaphore
