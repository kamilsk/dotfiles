#!/usr/bin/env bash

whisper() {
  local model=small memory args=("${@}")

  while [[ $# -gt 0 ]]; do
    case "${1}" in
    --model) model=${2} && shift 2 ;;
    *) shift 1 ;;
    esac
  done

  case "${model}" in
  tiny | tiny.en) memory=(-m 1g) ;;
  base | base.en) memory=(-m 1g) ;;
  small | small.en) memory=(-m 2g) ;;
  medium | medium.en) memory=(-m 5g) ;;
  large) memory=(-m 10g) ;;
  *) echo "unknown size: ${model}" >&2 && return 1 ;;
  esac

  docker run --rm -it \
    "${memory[@]}" \
    -v whisper-models:/root/.cache/whisper \
    -v "$(pwd)":/usr/src \
    ghcr.io/lifeosm/whisper:latest "${args[@]}"
}

transcribe() {
  whisper \
    --model small \
    --task transcribe \
    --language ru \
    -f vtt \
    "${@}"
}
