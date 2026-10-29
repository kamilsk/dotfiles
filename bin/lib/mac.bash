#!/usr/bin/env bash

function flushdns() {
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
}

function fix_xcrun() {
  sudo xcode-select --reset
  sudo rm -rf /Library/Developer/CommandLineTools
  if ! xcode-select --install; then
    sudo xcode-select --install
  fi
}

# Touch ID for sudo: /etc/pam.d/sudo includes sudo_local first, and unlike
# /etc/pam.d/sudo itself, which a macOS update restores, sudo_local survives updates
function touch_sudo() {
  local file=/etc/pam.d/sudo_local
  if grep -Eq '^auth[[:space:]]+sufficient[[:space:]]+pam_tid\.so' "${file}" 2>/dev/null; then
    echo "Touch ID for sudo is already enabled in ${file}"
    return
  fi
  if [ -f "${file}" ]; then
    # appended, so a pam_reattach line already there stays before it, as it must
    echo 'auth       sufficient     pam_tid.so' | sudo tee -a "${file}" >/dev/null
  else
    sed -E 's/^#(auth[[:space:]]+sufficient[[:space:]]+pam_tid\.so)/\1/' "${file}.template" |
      sudo tee "${file}" >/dev/null
  fi
  cat "${file}"
}
