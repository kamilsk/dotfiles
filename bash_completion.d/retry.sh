#!/usr/bin/env bash
# cp bash_completion.d/retry.sh /usr/local/etc/bash_completion.d/retry

_retry() {
    local cur prev

    return 0
}

complete -F _retry retry
