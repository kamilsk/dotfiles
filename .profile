ssh-add >/dev/null 2>&1

alias v+="source .virtenv/bin/activate"
alias v-="deactivate"

alias g+="git fetch --all -p && git pull"
alias g-="git reset --hard && git clean -df"
alias g@="git config user.name 'Kamil Samigullin' && git config user.email 'kamil@samigullin.info'"

alias netl="netstat -an | grep LISTEN"
