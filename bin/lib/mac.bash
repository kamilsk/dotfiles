#!/usr/bin/env bash

function fix_xcrun() {
  sudo xcode-select --reset
  sudo rm -rf /Library/Developer/CommandLineTools
  if ! xcode-select --install; then
    sudo xcode-select --install
  fi
}

function touch_sudo() {
  cat /etc/pam.d/sudo
  if ! grep 'pam_tid.so' /etc/pam.d/sudo; then
    echo '# sudo: auth account password session' >/tmp/sudo
    echo 'auth       sufficient     pam_tid.so' >>/tmp/sudo
    cat </etc/pam.d/sudo | grep -v '# sudo' >>/tmp/sudo
    sudo mv /tmp/sudo /etc/pam.d/sudo
    cat /etc/pam.d/sudo
  fi
}
