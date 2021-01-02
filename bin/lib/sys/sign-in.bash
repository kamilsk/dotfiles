#!/usr/bin/env bash

sign-in() {
  if command -v ngrok >/dev/null && test -v NGROK_TOKEN; then
    ngrok authtoken "${NGROK_TOKEN}"
  fi
}
