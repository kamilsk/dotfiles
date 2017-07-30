#!/usr/bin/env bash
# cp bash_completion.d/go.sh /usr/local/etc/bash_completion.d/go

function _go() {
  cur="${COMP_WORDS[COMP_CWORD]}"

  case "${COMP_WORDS[COMP_CWORD-1]}" in
    "go")
      comms="build clean doc env fix fmt generate get install list run test tool version vet"
      COMPREPLY=($(compgen -W "${comms}" -- ${cur}))
      ;;
    *)
      files=$(find ${PWD} -mindepth 1 -maxdepth 1 -type f -iname "*.go" -exec basename {} \;)
      dirs=$(find ${PWD} -mindepth 1 -maxdepth 1 -type d -not -name ".*" -exec basename {} \;)
      repl="${files} ${dirs}"
      COMPREPLY=($(compgen -W "${repl}" -- ${cur}))
      ;;
  esac

  return 0
}

complete -F _go go
