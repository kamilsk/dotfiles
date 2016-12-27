ssh-add >/dev/null 2>&1

alias v+="source .virtenv/bin/activate"
alias v-="deactivate"

alias g+="git fetch --all -p && git pull && git submodule update --init --recursive"
alias g-="git reset --hard && git clean -df && git submodule update --init --recursive"
alias g@="git config user.name 'Kamil Samigullin' && git config user.email 'kamil@samigullin.info'"
function g^ {
    if [ "$1" = "" ]; then
        echo "usage: g^ <url>"
        return 1
    fi
    git remote add mirror "$1"
}
export -f g^

alias netl="netstat -an | grep LISTEN"
