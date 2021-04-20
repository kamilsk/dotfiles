#!/usr/bin/env bats

setup() {
  load 'helper/support/load.bash'
  load 'helper/assert/load.bash'

  local DIR
  DIR=$(cd "$(dirname "${BATS_TEST_FILENAME}")" && pwd)
  PATH="${DIR}:${PATH}"
}

@test "'lookup' works well with git alias" {
  run lookup.sh lookup git m
  assert_success
  assert_output --partial "git alias: checkout master"
}

@test "'lookup' works well with git alias as inline script" {
  run lookup.sh lookup git mm
  assert_success
  assert_output --partial 'git alias: !git checkout master && git pull --rebase'
}

@test "'lookup' works well with git alias as shell script" {
  run lookup.sh lookup git cmm
  assert_success
  assert_output --partial 'git alias: !git_commit cmm'
  assert_output --partial 'bin/git_commit: Bourne-Again shell script text executable'
}

@test "'lookup' doesn't work well with a function" {
  run lookup.sh lookup demo_func
  assert_failure
}

@test "'lookup' doesn't work well with an alias" {
  run lookup.sh lookup demo_alias
  assert_failure
}

@test "'lookup' works well with shell script" {
  run lookup.sh lookup explain
  assert_success
  assert_output --partial 'bin/explain: Bourne-Again shell script text executable'
}

@test "'lookup' works well with text" {
  run lookup.sh lookup git_aliases
  assert_success
  assert_output --partial 'bin/git_aliases: Python script text executable'
}

@test "'lookup' works well with binary" {
  run lookup.sh lookup bash
  assert_success
  assert_output --partial '/bin/bash'
}
