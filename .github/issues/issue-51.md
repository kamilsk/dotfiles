---
id: 51
database_id: 481488221
node_id: MDU6SXNzdWU0ODE0ODgyMjE=
status: closed
title: "go checks"
labels: []
url: https://github.com/kamilsk/dotfiles/issues/51
created_at: 2019-08-16T07:49:32Z
updated_at: 2019-09-14T07:08:11Z
---

# go checks

- check-go-mod.sh
```
!/bin/bash
 set -e
 ERR=$( go mod tidy -v 2>&1 )
 if [[ "$ERR" =~ "unused" ]]; then
     echo $ERR
     exit 1
 fi
 exit 0
```
- check_go_fmt.sh
```
#!/bin/bash
# This script is used by the CI to check if the code is gofmt formatted.

set -euo pipefail

GOFMT_DIFF=$(IFS=$'\n'; gofmt -d $( find . -type f -name '*.go' ) )
if [[ -n "${GOFMT_DIFF}" ]]; then
    echo "${GOFMT_DIFF}"
    echo
    echo "The go source files aren't gofmt formatted."
    exit 1
fi
```
- check_go_generate.sh
```bash
#!/bin/bash
# This script is used by the CI to check if 'go generate ./...' is up to date.
#
# Note: If the generated files aren't up to date then this script updates
# them despite printing an error message so running it the second time
# might not print any errors. This isn't very useful locally during development
# but it works well with the CI that downloads a fresh version of the repo
# each time before executing this script.

set -euo pipefail

TEMP_DIR=$( mktemp -d )
function cleanup() {
    rm -rf "${TEMP_DIR}"
}
trap cleanup EXIT

cp -r . "${TEMP_DIR}/"
go generate ./...
if ! diff -r . "${TEMP_DIR}"; then
    echo
    echo "The generated files aren't up to date."
    echo "Update them with the 'go generate ./...' command."
    exit 1
fi
```
- check_go_mod.sh
```
#!/bin/bash
# This script is used to ensure that the go.mod file is up to date.

set -euo pipefail

go mod tidy

if [ ! -z "$(git status --porcelain)" ]; then
    git status
    echo
    echo "The go.mod is not up to date."
    exit 1
fi
```

https://github.com/golang/mock/tree/master/ci
