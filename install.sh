#!/usr/bin/env bash

# TODO
#  - install oh my zsh
#  - install code alias (vscode)

set -o nounset
set -o pipefail

if ! command -v git > /dev/null; then
    echo Git not found
    exit 1
fi

if ! command -v ruby > /dev/null; then
    echo Ruby not found
    exit 1
fi

if ! command -v curl > /dev/null; then
    echo cURL not found
    exit 1
fi

if [ ! -d "${HOME}"/.dotfiles ]; then
    echo Installing dotfiles...
    mkdir -p "${HOME}"/.dotfiles
    git clone git@github.com:kamilsk/dotfiles.git "${HOME}"/.dotfiles

    echo 'source "${HOME}"/.dotfiles/.profile'      >> "${HOME}"/.bash_profile
    echo 'source "${HOME}"/.dotfiles/.bash_profile' >> "${HOME}"/.bash_profile

    echo 'source "${HOME}"/.dotfiles/.profile' >> "${HOME}"/.zshrc
    echo 'source "${HOME}"/.dotfiles/.zshrc'   >> "${HOME}"/.zshrc
fi

if ! command -v brew > /dev/null; then
    echo Installing Homebrew...
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo Applying useful Homebrew formulas...
declare -a pkgs=(
    ansible
    bat
    dep
    dive
    fzf
    git
    go
    httpie
    jq
    kubernetes-cli
    kubernetes-helm
    node
    php
    protobuf
    python
    zsh
    zsh-completions
)

brew update
for pkg in ${pkgs[@]}; do
    brew list $pkg &>/dev/null || brew install $pkg
done
