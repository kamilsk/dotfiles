#!/usr/bin/env bash

if ! command -v docker >/dev/null; then
  return
fi

function container() {
  docker exec -it "${1}" /bin/sh
}

function containers() {
  case "${1-}" in
  all)
    docker ps --all | tail -n +2
    ;;
  *)
    docker ps | tail -n +2
    ;;
  esac
}

function images() {
  case "${1-}" in
  all)
    docker images --all | tail -n +2
    ;;
  clean)
    docker rmi "$(docker images -q -f dangling=true)" 2>/dev/null
    docker system prune -f
    ;;
  pull)
    images "$@" | awk '{print $1":"$2}' | xargs -n1 docker pull
    ;;
  *)
    docker images | grep -v '<none>' | tail -n +2
    ;;
  esac
}

function truncate_docker_logs() {
  truncate -s 0 "$(docker inspect --format='{{.LogPath}}' "${1}")"
}

function volume() {
  docker run --rm -it -v "${1}":/view -w /view alpine:latest
}

function volumes() {
  case "${1-}" in
  all)
    docker volume ls | tail -n +2
    ;;
  clean)
    volumes all |
      awk '{print $2}' |
      grep -E '[[:alnum:]]{64}' |
      xargs docker volume rm
    ;;
  *)
    volumes all | grep -E -v '[[:alnum:]]{64}' || true
    ;;
  esac
}
