if [ "$(ps cax | grep ssh | awk '{print $1}')" = '' ]; then
    ssh-add >/dev/null 2>&1
fi

# Git

function git_config {
    git config --global alias.up        '!git fetch --all -p && git pull && git submodule update --init --recursive'
    git config --global alias.down      '!git reset --hard && git clean -df && git submodule update --init --recursive'
    git config --global alias.sync      "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); git fetch --all -p && git pull --rebase && for remote in \$(git remote | grep -v upstream); do git push \$remote \$branch; done"

    git config --global alias.cmm       'commit -m'
    # git add <пропущенное> и git commend - прикрепляем к последнему коммиту
    git config --global alias.commend   'commit --amend --no-edit'

    # правильно форсим
    git config --global alias.force     "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); for remote in \$(git remote | grep -v upstream); do git push -f \$remote \$branch; done"
    git config --global alias.please    "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); for remote in \$(git remote | grep -v upstream); do git push  --force-with-lease \$remote \$branch; done"

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

    # цепляет текущую ветку к origin
    git config --global alias.attach    "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); attach() { git branch --set-upstream-to=\$1/\$branch \$branch; }; attach"
}

function git_github_flow {
    git config alias.issue  "!commit() { git commit -m \"issue \$1\"; }; commit"
    git config alias.issues "!commit() { git commit -m \"issues \$1\"; }; commit"
    git config alias.fix    "!commit() { git commit -m \"fix issue \$1\"; }; commit"
    git config alias.fixes  "!commit() { git commit -m \"fix issues \$1\"; }; commit"
}

function git_jira_flow {
    git config alias.flow     "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); commit() { git commit -m \"[\$branch] \$1\"; }; commit"
    git config alias.progress "!branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); git commit --amend --no-edit && git push --force-with-lease mirror \$branch"
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
        if test -d $item; then
            ( \
                echo "current directiry is:" $item && cd $item; \

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

# TODO ревью https://csswizardry.com/2017/05/little-things-i-like-to-do-with-git/
function git_review_203 {
    git config alias.user      'config user.email'
    git config alias.branch    'branch | cut -f2 -d' ' | awk "NF > 0"'
    git config alias.release   'tag --list | sort -gr | head -1'

    git config alias.stats     'shortlog -sn --all --no-merges'
    git config alias.recent    'for-each-ref --count=10 --sort=-committerdate refs/heads/ --format="%(refname:short)"'
    git config alias.overview  'log --all --since="1 week" --oneline --no-merges'
    git config alias.recap     "log --all --oneline --no-merges --since='1 week' --author=\$(git user)"
    git config alias.today     "log --since='00:00:00' --all --no-merges --oneline --author=\$(git user)"
    git config alias.yesterday "log --since='1 day' --until='00:00:00' --all --no-merges --oneline --author=\$(git user)"
    git config alias.changelog "log --oneline --no-merges \$(git release).."
    git config alias.ahead     "log --oneline --no-merges origin/\$(git branch).."
    git config alias.behind    "log --oneline --no-merges ..origin/\$(git branch)"
}

alias g@="git config user.name 'Kamil Samigullin' && git config user.email 'kamil@samigullin.info'"
alias g+="git fetch --all -p && git pull && git submodule update --init --recursive"
alias g-="git reset --hard && git clean -df && git submodule update --init --recursive"
alias g^="branch=\$(git branch | cut -f2 -d' ' | awk 'NF > 0'); for remote in \$(git remote | grep -v upstream); do git push \$remote \$branch --tags; done"

# Docker

alias docker+img="docker images --all | tail -n +2 | sort -f"
alias docker-img="docker+img | grep -v '<none>'"
alias docker+="docker-img | awk '{print \$1\":\"\$2}' | xargs -n1 docker pull"
alias docker-="docker+img | grep '<none>' | awk '{print \$3}' | xargs docker rmi -f && docker system prune -f"
alias connect="docker~"
function docker~ {
    docker exec -it $1 /bin/sh
}

# Python

alias v+="source .virtenv/bin/activate"
alias v-="deactivate"
alias pip+="sudo pip install --upgrade pip; pip list | cut -f1 -d' ' | xargs -n1 sudo pip install --upgrade"

# Package management

alias brew+="brew update && brew upgrade && \
             brew cleanup && brew cask cleanup && \
             brew doctor && brew cask doctor && \
             brew prune"
alias composer+="sudo composer self-update && composer global update"
alias gem+="sudo gem update --system; gem list | cut -f1 -d' ' | xargs -n1 sudo gem update"
alias npm+="npm install -g npm && npm update -g"

# Network

alias netl="netstat -an | grep LISTEN"

# Environment

export GOPATH="$HOME/Development/go"
export COMPOSERPATH="$HOME/.composer"

# Recommendation

set +o histexpand

export PATH="$PATH:/usr/local/sbin:$GOPATH/bin:$COMPOSERPATH/vendor/bin"
export GITHUB_TOKEN="%place_here%"
