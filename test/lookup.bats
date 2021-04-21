#!/usr/bin/env bats

setup() {
  load 'helper/support/load.bash'
  load 'helper/assert/load.bash'

  local DIR BIN
  DIR=$(cd "$(dirname "${BATS_TEST_FILENAME}")" && pwd) # TODO:deprecated use bin instead
  BIN=$(cd "$(dirname "${BATS_TEST_FILENAME}")/../bin/" && pwd)
  PATH="${BIN}:${DIR}:${PATH}"
}

@test "'lookup' works well with git alias" {
  run lookup.bash lookup git m
  assert_success
  assert_output --partial "git alias: checkout master"
}

@test "'lookup' works well with git alias as inline script" {
  run lookup.bash lookup git mm
  assert_success
  assert_output --partial 'git alias: !git checkout master && git pull --rebase'
}

@test "'lookup' works well with git alias as shell script" {
  run lookup.bash lookup git cmm
  assert_success
  assert_output --partial 'git alias: !git_commit cmm'
  assert_output --partial 'bin/git_commit: Bourne-Again shell script text executable'
}

@test "'lookup' works well with a function under zsh, not sh|bash" {
  run lookup.bash lookup some_func
  assert_failure

  run lookup.zsh lookup some_func
  assert_success
  assert_output --partial 'some_func ()'
}

@test "'lookup' works well with an alias under zsh, not sh|bash" {
  run lookup.bash lookup some_alias
  assert_failure

  run lookup.zsh lookup some_alias
  assert_success
  assert_output --partial 'alias some_alias=true'
}

@test "'lookup' works well with shell script" {
  run lookup.bash lookup explain
  assert_success
  assert_output --partial 'bin/explain: Bourne-Again shell script text executable'
}

@test "'lookup' works well with text" {
  run lookup.bash lookup git_aliases
  assert_success
  assert_output --partial 'bin/git_aliases: Python script text executable'
}

@test "'lookup' works well with binary" {
  run lookup.bash lookup bash
  assert_success
  assert_output --partial '/bin/bash'
}
