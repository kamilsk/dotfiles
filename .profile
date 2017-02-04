if [ "$(ps cax | grep ssh | awk '{print $1}')" = '' ]; then
    ssh-add >/dev/null 2>&1
fi

set +o histexpand

function git_config {
    git config --global alias.up   '!git fetch --all -p && git pull && git submodule update --init --recursive'
    git config --global alias.down '!git reset --hard && git clean -df && git submodule update --init --recursive'

    # git add <пропущенное> и git commend - прикрепляем к последнему коммиту
    git config --global alias.commend 'commit --amend --no-edit'

    # правильно форсим
    git config --global alias.force   "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); git push -f origin \$branch"
    git config --global alias.please  "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); git push --force-with-lease origin \$branch"

    # правильно инициализируем
    git config --global alias.it      '!git init && git commit -m "root" --allow-empty'

    # скрывает только непроиндексированные изменения в отслеживаемых файлах
    git config --global alias.stsh    'stash --keep-index'
    # скрывает все изменения в отслеживаемых файлах
    # git stash
    # скрывает неотслеживаемые и отслеживаемые файлы
    git config --global alias.staash  'stash --include-untracked'
    # скрывает игнорируемые, неотслеживаемые и отслеживаемые файлы
    git config --global alias.staaash 'stash --all'

    # сжатый статус
    git config --global alias.st      'status --short --branch'
    git config --global alias.shorty  'status --short --branch'
    # графический лог
    git config --global alias.grog    'log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
    git config --global alias.branches 'for-each-ref --sort=committerdate refs/heads/ --format="%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))"'
}

function git_mirror {
    git remote -v | grep mirror > /dev/null
    exists=$?
    if [ "${exists}" != 0 ]; then
        if [ "$1" = "" ]; then
            echo "usage: g++ <url>"
            return 1
        else
            git remote add mirror "$1"
        fi
    elif [ "$1" != "" ]; then
        git remote set-url mirror "$1"
    fi
    git config alias.pub "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); git push origin \$branch --tags && git push mirror \$branch --tags"
}

alias docker+img="docker images --all | tail -n +2 | sort -f"
alias docker-img="docker+img | grep -v '<none>'"

alias g@="git config user.name 'Kamil Samigullin' && git config user.email 'kamil@samigullin.info'"
alias g+="git fetch --all -p && git pull && git submodule update --init --recursive"
alias g-="git reset --hard && git clean -df && git submodule update --init --recursive"
alias g^="branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); git push origin \$branch --tags && git push mirror \$branch --tags"

alias v+="source .virtenv/bin/activate"
alias v-="deactivate"

alias brew+="brew update && brew upgrade && \
             brew cleanup && brew cask cleanup && \
             brew doctor && brew cask doctor && \
             brew prune"
alias composer+="sudo composer self-update && composer global update"
alias docker+="docker-img | awk '{print \$1\":\"\$2}' | xargs -n1 docker pull"
alias gem+="sudo gem update --system; gem list | cut -f1 -d' ' | xargs -n1 sudo gem update"
alias npm+="npm install -g npm && npm update -g"
alias pip+="sudo pip install --upgrade pip; pip list | cut -f1 -d' ' | xargs -n1 sudo pip install --upgrade"

alias netl="netstat -an | grep LISTEN"

export GOPATH="$HOME/Development/go"
export COMPOSERPATH="$HOME/.composer"
export PATH="$PATH:/usr/local/sbin:$GOPATH/bin:$COMPOSERPATH/vendor/bin"

# refactoring, ignore below

alias b-="brew unlink $1 && brew link $2"
alias boxup="vagrant box list | awk '{print \$1}' | sort | uniq | xargs -n1 vagrant box update --box \$1"
alias gnetstat="sudo lsof -i -nP"
alias pippush="python setup.py sdist bdist_wheel upload"

alias reload="rm -rf $COMPOSERPATH/cache/files/kamilsk && echo 'Cache files of kamilsk was removed' && \
              rm -rf $COMPOSERPATH/cache/repo/https---packagist.org/provider-kamilsk* && echo 'Cache repo of kamilsk was removed' && \
              rm -rf vendor/kamilsk && echo 'Vendor of kamilsk was removed' && \
              composer install"
alias refresh="rm -rf $COMPOSERPATH/cache/files/kamilsk && echo 'Cache files of kamilsk was removed' && \
               rm -rf $COMPOSERPATH/cache/repo/https---packagist.org/provider-kamilsk* && echo 'Cache repo of kamilsk was removed' && \
               rm -rf vendor/kamilsk && echo 'Vendor of kamilsk was removed' && \
               composer update"
