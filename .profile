# Environment

set +o histexpand

export GOPATH="${HOME}/Development/go"
export PATH="${HOME}/.dotfiles/bin:${GOPATH}/bin:${PATH}"

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

# macOS

function fix_xcrun {
    sudo xcode-select --reset
    xcode-select --install
}

function touch_sudo {
    if ! grep 'pam_tid.so' /etc/pam.d/sudo; then
        echo '# sudo: auth account password session' > /tmp/sudo
        echo 'auth       sufficient     pam_tid.so' >> /tmp/sudo
        cat /etc/pam.d/sudo | grep -v '# sudo' >> /tmp/sudo
        sudo mv /tmp/sudo /etc/pam.d/sudo
        cat /etc/pam.d/sudo
    fi
}

# Fun

alias shrug="echo ¯\_(ツ)_/¯";
alias fight="echo (ง'̀-'́)ง";
alias tflip="echo （╯°□°）╯︵┻━┻";

# Git

alias g@="git config user.name 'Kamil Samigullin' && git config user.email 'kamil@samigullin.info'"
alias g+="git pull --all --prune --tags --force --rebase && git submodule update --init --recursive"
alias g-="git reset --hard && git clean -df && git submodule deinit --all"
alias g^="branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); for remote in \$(git remote | grep -v upstream); do git push \$remote \$branch --tags; done"

# Docker

if command -v docker > /dev/null; then
    function container {
        docker exec -it $1 /bin/sh
    }
    function containers {
        case "${1-}" in
            "all")
                docker ps --all | tail +2
            ;;
            *)
                docker ps | tail +2
            ;;
        esac
    }
    function images {
        case "${1-}" in
            "all")
                docker images --all | tail +2
            ;;
            "clean")
                docker rmi $(docker images -q -f dangling=true) 2>/dev/null
                docker system prune -f
            ;;
            "pull")
                $0 | awk '{print $1":"$2}' | xargs -n1 docker pull
            ;;
            *)
                docker images | grep -v '<none>' | tail +2
            ;;
        esac
    }
    function volume {
        docker run --rm -it -v $1:/view -w /view alpine:latest
    }
    function volumes {
        case "${1-}" in
            "all")
                docker volume ls | tail +2
            ;;
            "clean")
                $0 all \
                | awk '{print $2}' \
                | egrep '[[:alnum:]]{64}' \
                | xargs docker volume rm
            ;;
            *)
                $0 all | egrep -v '[[:alnum:]]{64}'
            ;;
        esac
    }
    alias （╯°□°）╯︵┻━┻docker="images clean && volumes clean" # TODO:implement eval "$(tflip)docker"
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
