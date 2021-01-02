#!/usr/bin/env bats

# TODO:deprecated use bin instead
function datetime() {
  local iso="%Y-%m-%dT%H:%M:%S%Z"

  local mutator
  mutator=$(echo "${1:-}" | sed 's:\([[:alpha:]]\):\1 :g')
  if [ -z "${mutator}" ]; then
    date +${iso}
    return
  fi

  local sign=+
  if [[ "${mutator}" == -* ]]; then
    mutator="${mutator##-}"
    sign=-
  fi

  local v
  for m in $(echo "${mutator}" | cat); do
    v+="-v${sign}${m} "
  done
  eval "date -j ${v}+${iso}"
}

@test "'datetime' works well with complex input" {
  run datetime -1d1H
}
