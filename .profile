# Environment

set +o histexpand

export GOPATH="${HOME}"/Development/go # go env
export CPR_PATH="${HOME}"/.composer    # composer config --list --global
export GEM_PATH=                       # gem environment
export PIP_PATH=                       # pip show <pkg>
export NPM_PATH=                       # npm root -g
export PATH="${PATH}:/usr/local/sbin:${GOPATH}/bin:${HOME}/.dotfiles/bin"

export GITHUB_TOKEN=
export HUGS_TOKEN=10000000-2000-4000-8000-160000000003
export CLICK_TOKEN=$HUGS_TOKEN
export FORMA_TOKEN=$HUGS_TOKEN
export GUARD_TOKEN=$HUGS_TOKEN
export PASSPORT_TOKEN=$HUGS_TOKEN

# Common

alias ..="cd ../"
alias ...="cd ../../"
alias dotfiles="cd ~/.dotfiles"

alias cwd="pwd | tr -d '\n' | pbcopy"
alias dots="ls \.*"
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"

# Fun

alias shrug="echo '¯\_(ツ)_/¯'";
alias fight="echo '(ง'̀-'́)ง'";
alias tflip="echo '（╯°□°）╯︵┻━┻'";

# Git

alias g@="git config user.name 'Kamil Samigullin' && git config user.email 'kamil@samigullin.info'"
alias g+="git fetch --all -p && git pull && git submodule update --init --recursive"
alias g-="git reset --hard && git clean -df && git submodule update --init --recursive"
alias g^="branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); for remote in \$(git remote | grep -v upstream); do git push \$remote \$branch --tags; done"

# Docker

if command -v docker > /dev/null; then
    function container {
        docker exec -it $1 /bin/sh
    }
    function images {
        case "${1-}" in
            "all")
                docker images --all | tail -n +2 | sort -f
            ;;
            *)
                images all | grep -v '<none>'
            ;;
        esac
    }
    function volume {
        docker run --rm -it -v $1:/view -w /view alpine:latest
    }
    alias images+="docker_images update"
    alias images-="docker_images cleanup"
    alias volumes-="docker volume ls | tail +2 | awk '{print $$2}' | egrep '[[:alnum:]]{64}' | xargs docker volume rm || true"
    alias （╯°□°）╯︵┻━┻docker="images- && volumes-" # TODO eval "$(tflip)docker"
fi

# Package management

if command -v brew > /dev/null; then
    alias brew+="brew_update"
fi
if command -v composer > /dev/null; then
    alias composer+="sudo composer self-update; \
                     composer global update"
fi
if command -v gem > /dev/null; then
    alias gem+="sudo gem update --system; \
                gem list | cut -f1 -d' ' | xargs -n1 sudo gem update"
fi
if command -v npm > /dev/null; then
    alias npm+="npm install -g npm && npm update -g"
fi
if command -v pip > /dev/null; then
    alias pip+="pip list | cut -f1 -d' ' | xargs -n1 sudo pip install --upgrade"
elif command -v pip3 > /dev/null; then
    alias pip+="pip3 list | cut -f1 -d' ' | tail +3 | xargs -n1 pip3 install --upgrade"
fi

# Python

alias v+="source .virtenv/bin/activate"
alias v-="deactivate"

# Sublime

if ! command -v subl > /dev/null && [ -x "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ]; then
    alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
fi

# Visual Studio Code

if ! command -v code > /dev/null && [ -x "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]; then
    alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
fi
