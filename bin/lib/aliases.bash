#!/usr/bin/env bash

alias ..='cd ../'
alias ...='cd ../../'
alias dotfiles='cd ~/.dotfiles'

alias cwd='pwd | tr -d "\n" | pbcopy'
alias dots='ls .*'

alias isodate='date +%Y-%m-%d'
alias isodatetime='date +%Y-%m-%dT%H:%M:%S%Z'
alias timestamp='date +%s'

alias append='cat <<EOF >>'
alias edit='cat <<EOF >'

alias md5='openssl md5'
alias sha1='openssl sha1'
alias sha256='openssl sha256'
alias sha512='openssl sha512'

alias run='./Taskfile'

alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/'

alias g@='git config user.name "Kamil Samigullin" && git config user.email "kamil@samigullin.info"'
alias g+='pull'
alias g-='git nah'
alias g^='push'

alias v@='python3 -m venv .virtenv'
alias v+='source .virtenv/bin/activate'
alias v-='deactivate'
alias v^='pip list | cut -d" " -f1 | tail -n +3 | xargs -n1 pip install --upgrade'

if command -v composer >/dev/null; then
  alias composer+='sudo composer self-update; \
                   composer global update'
fi

if command -v gem >/dev/null; then
  alias gem+='sudo gem update --system; \
              gem list | cut -d" " -f1 | xargs -n1 sudo gem update'
fi

if command -v npm >/dev/null; then
  alias npm+='npm install -g npm && npm update -g'
fi

if command -v pip >/dev/null; then
  alias pip+='pip list | cut -d" " -f1 | xargs -n1 sudo pip install --upgrade'
elif command -v pip3 >/dev/null; then
  alias pip+='pip3 list | cut -d" " -f1 | tail -n +3 | xargs -n1 pip3 install --upgrade'
fi

if ! command -v sublime >/dev/null && [ -d '/Applications/Sublime Text.app' ]; then
  alias sublime='open -a "Sublime Text"'
fi

if ! command -v journalctl >/dev/null; then
  alias oom='sudo journalctl -k | grep -i -e memory -e oom'
fi

if ! command -v code >/dev/null && [ -d '/Applications/Visual Studio Code.app' ]; then
  alias code='open -a "Visual Studio Code"'
fi
