# Common

if command -v ssh-agent > /dev/null; then
    if ! ps cax | grep ssh-agent &>/dev/null; then
        ssh-add >/dev/null 2>&1
    fi
fi

if command -v gpg-agent > /dev/null; then
    if ! ps cax | grep gpg-agent &>/dev/null; then
        echo 'todo register gpg' >/dev/null
    fi
fi

# Environment

set +o histexpand

export GOPATH="${HOME}"/Development/go # go env
export CMPSR_PATH="${HOME}"/.composer  # composer config --list --global
export GEM_PATH=                       # gem environment
export PIP_PATH=                       # pip show <pkg>
export NPM_PATH=                       # npm root -g
export PATH="${PATH}:/usr/local/sbin:${GOPATH}/bin:${CMPSR_PATH}/vendor/bin"

export GITHUB_TOKEN=
export CLICK_TOKEN=10000000-2000-4000-8000-160000000003 # demo
export FORMA_TOKEN=10000000-2000-4000-8000-160000000003 # demo
export GUARD_TOKEN=10000000-2000-4000-8000-160000000003 # demo
export PASSPORT_TOKEN=10000000-2000-4000-8000-160000000003 # demo

alias reload="exec $SHELL"
alias self-update="(cd ${HOME}/.dotfiles && git pull) && reload"

alias ..="cd ../"
alias ...="cd ../../"
alias cwd="pwd | tr -d '\n' | pbcopy"
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"

# Fun

alias shrug="echo '¯\_(ツ)_/¯'";
alias fight="echo '(ง'̀-'́)ง'";
alias tflip="echo '（╯°□°）╯︵┻━┻'";

# Git

function git_config {
    if command -v subl > /dev/null; then
        subl ~/.gitconfig --wait
        subl ~/.gitignore --wait
        if [ -f .git/config ]; then
            subl .git/config --wait
        fi
    fi

    # метаинформация
    git config --global alias.user      'config user.email'
    git config --global alias.current   '!git branch | cut -f2 -d" " | awk "NF > 0"'
    git config --global alias.release   '!git describe --tags | cut -d - -f 1'
    git config --global alias.stats     '!git log --pretty=format:"%an <%ae>" | sort | uniq -c'
    git config --global alias.week      '!git log --oneline --no-merges --all --author=$(git user) --since=1.week | cat'
    git config --global alias.month     '!git log --oneline --no-merges --all --author=$(git user) --since=1.month | cat'

    git config --global alias.up        '!git fetch --all -p && git pull && git submodule update --init --recursive'
    git config --global alias.down      '!git reset --hard && git clean -df && git submodule update --init --recursive'
    git config --global alias.sync      "!git fetch --all -p && git pull --rebase && for remote in \$(git remote | grep -v upstream); do git push \$remote \$(git current); done"

    git config --global alias.m         'checkout master'
    git config --global alias.mm        '!git checkout master && git pull --rebase'
    git config --global alias.mmm       '!git checkout master && git sync'

    git config --global alias.cmm       'commit -m'
    # git add <пропущенное> и git commend - прикрепляем к последнему коммиту
    git config --global alias.commend   'commit --amend --no-edit'

    # правильно форсим
    git config --global alias.force     "!for remote in \$(git remote | grep -v upstream); do git push -f \$remote \$(git current); done"
    git config --global alias.please    "!for remote in \$(git remote | grep -v upstream); do git push --force-with-lease \$remote \$(git current); done"

    # правильно инициализируем
    git config --global alias.it        '!git init && git cmm "root" --allow-empty'

    # скрывает только непроиндексированные изменения в отслеживаемых файлах
    git config --global alias.stsh      'stash --keep-index'
    # скрывает все изменения в отслеживаемых файлах
    # git stash
    # скрывает неотслеживаемые и отслеживаемые файлы
    git config --global alias.staash    'stash --include-untracked'
    # скрывает игнорируемые, неотслеживаемые и отслеживаемые файлы
    git config --global alias.staaash   'stash --all'

    # сжатый статус
    git config --global alias.st        'status --short --branch'
    git config --global alias.branches  'for-each-ref --sort=committerdate refs/heads/ --format="%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))"'
    git config --global alias.commits   'log --oneline --graph'

    # графический лог
    git config --global alias.grog      'log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'

    # цепляет текущую ветку к origin
    git config --global alias.attach    "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); attach() { git branch --set-upstream-to=\$1/\$branch \$branch; }; attach"
}

function git_flow_github {
    git config alias.fix   "!commit() { git cmm \"fix \$1\"; }; commit"
    git config alias.issue "!commit() { git cmm \"issue \$1\"; }; commit"
}

function git_flow_jira {
    git config alias.flow     "!commit() { git cmm \"[\$(git current)] \$1\"; }; commit"
    git config alias.progress "!git commit --amend --no-edit && git push --force-with-lease mirror \$branch"
    git config alias.ready    'commit --amend'
}

function git_mirror {
    git remote | grep mirror > /dev/null
    exists=$?
    if [ "${exists}" != 0 ]; then
        if [ "$1" = "" ]; then
            echo "usage: git_mirror <url>"
            return 1
        else
            git remote add mirror "$1"
        fi
    elif [ "$1" != "" ]; then
        git remote set-url mirror "$1"
    fi

    git config alias.pub "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); for remote in \$(git remote | grep -v upstream); do git push \$remote \$branch --tags; done"
}

function git_update_all {
    for item in $(ls); do
        if test -d $item && test -d $item/.git; then
            ( \
                echo "current directory is:" $item && cd $item; \

                # g+
                git fetch --all -p && git pull && git submodule update --init --recursive; \

                exists=$?; \
                if [ "${exists}" != 0 ]; then \
                    branch=$(git branch | cut -f2 -d' ' | awk 'NF > 0'); \
                    git branch --set-upstream-to=origin/$branch $branch; \
                fi \
            )
        fi;
    done
}

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
        case "$1" in
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
    alias images+="images | awk '{print \$1\":\"\$2}' | xargs -n1 docker pull"
    alias images-="(docker rmi \$(docker images -q -f dangling=true) 2>/dev/null || true) && docker system prune -f"
    alias volumes-="docker volume ls | tail +2 | awk '{print $$2}' | egrep '[[:alnum:]]{64}' | xargs docker volume rm || true"
    alias （╯°□°）╯︵┻━┻docker="images- && volumes-" # TODO eval "$(tflip)docker"
fi

# Package management

if command -v brew > /dev/null; then
    alias brew+="brew update && brew upgrade && brew cask upgrade; \
                 brew doctor && brew cask doctor; \
                 brew cleanup && brew prune"
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
