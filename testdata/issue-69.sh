#!/usr/bin/env bash

set -o nounset
set -o pipefail

while IFS= read -r latest; do

    if [[ ${latest} =~ -[0-9]+-g[a-z0-9]{7}$ ]]; then
        ahead=$(echo ${latest} | rev | cut -d - -f2-2 | rev)
        latest=$(echo ${latest} | rev | cut -d - -f3- | rev)
    fi
    if [[ ${latest} =~ - ]]; then
        latest=$(echo ${latest} | sed 's/-/ /' | awk '{print $1" ["$2"]"}')
    fi
    if [[ ${ahead} ]]; then
        latest=$(echo -e ${latest} ${ahead}↑)
    fi
    echo ${latest}

done
