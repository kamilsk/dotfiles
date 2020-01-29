#!/usr/bin/env bash

set -o nounset
set -o pipefail

declare -a arr=(
    '0.5.5-4-gcaf34db'
    '0.5.5-alpha-4-gcaf34db'
    '0.5.0-8-gcfce164'
    '0.5.0-beta-8-gcfce164'
    '1.11.0-1-ga4bc8a5'
    '1.11.0-rc1-1-ga4bc8a5'
    '0.7.0-166-g4d85c5c5'
)

for latest in "${arr[@]}"; do

    if [[ "${latest}" =~ -[0-9]+-g[a-z0-9]+$ ]]; then
        ahead=$(echo ${latest} | rev | cut -d - -f2-2 | rev)
        latest=$(echo ${latest} | rev | cut -d - -f3- | rev)
    fi
    if [[ "${latest}" =~ - ]]; then
        latest=$(echo ${latest} | sed 's/-/ /' | awk '{print $1" ["$2"]"}')
    fi
    if [[ "${ahead-}" ]]; then
        latest=$(echo ${latest} ${ahead}↑)
    fi
    echo ${latest}

done
