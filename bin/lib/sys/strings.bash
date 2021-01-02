#!/usr/bin/env bash

lower() {
  if [ -t 0 ]; then
    echo "$*" | tr '[:upper:]' '[:lower:]'
  else
    tr '[:upper:]' '[:lower:]'
  fi
}

upper() {
  if [ -t 0 ]; then
    echo "$*" | tr '[:lower:]' '[:upper:]'
  else
    tr '[:lower:]' '[:upper:]'
  fi
}
