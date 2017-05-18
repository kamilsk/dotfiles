if [ "$(ps cax | grep ssh | awk '{print $1}')" = '' ]; then
    ssh-add >/dev/null 2>&1
fi

set +o histexpand

function git_config {
    git config --global alias.up        '!git fetch --all -p && git pull && git submodule update --init --recursive'
    git config --global alias.down      '!git reset --hard && git clean -df && git submodule update --init --recursive'

    # git add <пропущенное> и git commend - прикрепляем к последнему коммиту
    git config --global alias.commend 'commit --amend --no-edit'

    # правильно форсим
    git config --global alias.force     "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); git push -f origin \$branch"
    git config --global alias.please    "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); git push --force-with-lease origin \$branch"

    # правильно инициализируем
    git config --global alias.it        '!git init && git commit -m "root" --allow-empty'

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
    git config --global alias.shorty    'status --short --branch'
    git config --global alias.branches  'for-each-ref --sort=committerdate refs/heads/ --format="%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))"'

    # графический лог
    git config --global alias.grog      'log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
}

function git_jira_flow {
    git config alias.flow     "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); commit() { git commit -m \"[\$branch] \$1\"; }; commit"
    git config alias.progress "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); git commit --amend --no-edit && git push --force-with-lease mirror \$branch"
    git config alias.ready    'commit --amend'
}

function git_github_flow {
    git config alias.issue  "!commit() { git commit -m \"issue \$1\"; }; commit"
    git config alias.issues "!commit() { git commit -m \"issues \$1\"; }; commit"
    git config alias.fix    "!commit() { git commit -m \"fix issue \$1\"; }; commit"
    git config alias.fixes  "!commit() { git commit -m \"fix issues \$1\"; }; commit"
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

alias docker+img="docker images --all | tail -n +2 | sort -f"
alias docker-img="docker+img | grep -v '<none>'"
alias docker+="docker-img | awk '{print \$1\":\"\$2}' | xargs -n1 docker pull"
alias docker-="docker+img | grep '<none>' | awk '{print \$3}' | xargs docker rmi -f && docker system prune -f"
alias connect="docker~"
function docker~ {
    docker exec -it $1 /bin/sh
}

alias g@="git config user.name 'Kamil Samigullin' && git config user.email 'kamil@samigullin.info'"
alias g+="git fetch --all -p && git pull && git submodule update --init --recursive"
alias g-="git reset --hard && git clean -df && git submodule update --init --recursive"
alias g^="branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); for remote in \$(git remote | grep -v upstream); do git push \$remote \$branch --tags; done"

alias v+="source .virtenv/bin/activate"
alias v-="deactivate"
alias pip+="sudo pip install --upgrade pip; pip list | cut -f1 -d' ' | xargs -n1 sudo pip install --upgrade"

alias brew+="brew update && brew upgrade && \
             brew cleanup && brew cask cleanup && \
             brew doctor && brew cask doctor && \
             brew prune"
alias composer+="sudo composer self-update && composer global update"
alias gem+="sudo gem update --system; gem list | cut -f1 -d' ' | xargs -n1 sudo gem update"
alias npm+="npm install -g npm && npm update -g"

alias netl="netstat -an | grep LISTEN"

export GOPATH="$HOME/Development/go"
export COMPOSERPATH="$HOME/.composer"

export PATH="$PATH:/usr/local/sbin:$GOPATH/bin:$COMPOSERPATH/vendor/bin"

# TODO refactoring, ignore below

alias b-="brew unlink $1 && brew link $2"
alias boxup="vagrant box list | awk '{print \$1}' | sort | uniq | xargs -n1 vagrant box update --box \$1"
alias gnetstat="sudo lsof -i -nP"
alias pippush="python setup.py sdist bdist_wheel upload"
