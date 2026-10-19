#!/usr/bin/env bats

# Each Bats test deliberately gets its own exported fixture state.
# shellcheck disable=SC2030,SC2031

setup() {
  bats_require_minimum_version 1.5.0
  export SELF_UPDATE_TEST_ROOT="${BATS_TEST_TMPDIR}/dotfiles"
  export UPDATE_CALLS="${BATS_TEST_TMPDIR}/calls"
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":"0.163.0","appServerVersion":"0.163.0"}'
  export CODEX_QUERY_EXIT=0 CODEX_UPDATE_EXIT=0 PLANNOTATOR_UPDATE_EXIT=0
  export SHELL=/bin/bash
  unset ZSH
  local commands="${BATS_TEST_TMPDIR}/commands"
  mkdir -p "${commands}" "${SELF_UPDATE_TEST_ROOT}/bin" "${SELF_UPDATE_TEST_ROOT}/toolset"
  touch "${UPDATE_CALLS}"

  # Run the real script with only its root redirected to a disposable fixture.
  # Expand the fixture root in the child script, not while generating it.
  # shellcheck disable=SC2016
  sed 's|^root=.*|root="${SELF_UPDATE_TEST_ROOT}"|' \
    "${BATS_TEST_DIRNAME}/../bin/self-update" >"${SELF_UPDATE_TEST_ROOT}/bin/self-update"
  ln -s "$(command -v jq)" "${commands}/jq"
  cat >"${commands}/stub" <<'SH'
#!/bin/bash
name=${0##*/}
echo "${name} $*" >>"${UPDATE_CALLS}"
case "${name} $*" in
  'codex app-server daemon version')
    echo "${CODEX_VERSION_JSON}"
    exit "${CODEX_QUERY_EXIT}"
    ;;
  'codex app-server daemon update --from-cli --yes') exit "${CODEX_UPDATE_EXIT}" ;;
  'plannotator update') exit "${PLANNOTATOR_UPDATE_EXIT}" ;;
  'docker images '*) echo 'example/image:latest' ;;
esac
SH
  chmod +x "${commands}/stub"
  local command
  for command in git git_config brew mas docker plannotator codex; do
    ln -s stub "${commands}/${command}"
  done
  ln -s "${commands}/stub" "${SELF_UPDATE_TEST_ROOT}/toolset/Apps"
  ln -s "${commands}/stub" "${SELF_UPDATE_TEST_ROOT}/bin/unquarantine"
  # Exclude real package managers and optional tools (especially Go's cleanup).
  export PATH="${commands}:/usr/bin:/bin"
}

run_update() {
  run /bin/bash "${SELF_UPDATE_TEST_ROOT}/bin/self-update" "$@"
}

@test "all checks Plannotator and syncs Codex after brew, last" {
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":"0.162.1","appServerVersion":"0.162.1"}'
  run_update all
  [ "${status}" -eq 0 ]
  grep -q '^plannotator update$' "${UPDATE_CALLS}"
  grep -q '^codex app-server daemon update --from-cli --yes$' "${UPDATE_CALLS}"
  local brew_line plannotator_line codex_line
  brew_line=$(grep -n '^brew doctor' "${UPDATE_CALLS}" | cut -d: -f1)
  plannotator_line=$(grep -n '^plannotator update$' "${UPDATE_CALLS}" | cut -d: -f1)
  codex_line=$(grep -n '^codex app-server daemon version$' "${UPDATE_CALLS}" | cut -d: -f1)
  [ "${brew_line}" -lt "${plannotator_line}" ]
  [ "${plannotator_line}" -lt "${codex_line}" ]
  [ "$(tail -n 2 "${UPDATE_CALLS}" | head -n 1)" = 'codex app-server daemon update --from-cli --yes' ]
}

@test "matching Codex versions do not restart or pin the daemon" {
  run_update codex
  [ "${status}" -eq 0 ]
  [[ "${output}" == *'up to date'* ]]
  run ! grep -q '^codex app-server daemon update' "${UPDATE_CALLS}"
  run ! grep -q '^brew ' "${UPDATE_CALLS}"
}

@test "an old running process is refreshed even when the package matches" {
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":"0.163.0","appServerVersion":"0.162.1"}'
  run_update codex
  [ "${status}" -eq 0 ]
  grep -q '^codex app-server daemon update --from-cli --yes$' "${UPDATE_CALLS}"
}

@test "an old package is refreshed even when the running process matches" {
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":"0.162.1","appServerVersion":"0.163.0"}'
  run_update codex
  [ "${status}" -eq 0 ]
  grep -q '^codex app-server daemon update --from-cli --yes$' "${UPDATE_CALLS}"
}

@test "a stopped current daemon is left stopped" {
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":"0.163.0","appServerVersion":null}'
  run_update codex
  [ "${status}" -eq 0 ]
  run ! grep -q '^codex app-server daemon update' "${UPDATE_CALLS}"
}

@test "a stopped outdated daemon package is updated" {
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":"0.162.1","appServerVersion":null}'
  run_update codex
  [ "${status}" -eq 0 ]
  grep -q '^codex app-server daemon update --from-cli --yes$' "${UPDATE_CALLS}"
}

@test "an absent daemon is not installed" {
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":null,"appServerVersion":null}'
  run_update codex
  [ "${status}" -eq 0 ]
  [[ "${output}" == *'not installed'* ]]
  run ! grep -q '^codex app-server daemon update' "${UPDATE_CALLS}"
}

@test "missing optional executables are skipped" {
  rm "${BATS_TEST_TMPDIR}/commands/codex" "${BATS_TEST_TMPDIR}/commands/plannotator"
  run_update plannotator codex
  [ "${status}" -eq 0 ]
  run ! grep -Eq '^(plannotator|codex) ' "${UPDATE_CALLS}"
}

@test "Plannotator delegates release checks and installation to its native updater" {
  run_update plannotator
  [ "${status}" -eq 0 ]
  [ "$(grep -c '^plannotator ' "${UPDATE_CALLS}")" -eq 1 ]
  grep -q '^plannotator update$' "${UPDATE_CALLS}"
  run ! grep -Eq '^(brew|codex) ' "${UPDATE_CALLS}"
}

@test "strict mode stops on a Plannotator update failure" {
  export PLANNOTATOR_UPDATE_EXIT=1
  run_update plannotator codex
  [ "${status}" -eq 1 ]
  run ! grep -q '^codex ' "${UPDATE_CALLS}"
}

@test "keep-going reports Plannotator failure and still checks Codex" {
  export PLANNOTATOR_UPDATE_EXIT=1
  run_update --keep-going all
  [ "${status}" -eq 2 ]
  [[ "${output}" == *'finished with failures:'*'plannotator update'* ]]
  grep -q '^codex app-server daemon version$' "${UPDATE_CALLS}"
}

@test "failed Codex version query never triggers an update" {
  export CODEX_QUERY_EXIT=7
  run_update --keep-going codex plannotator
  [ "${status}" -eq 2 ]
  [[ "${output}" == *'sync_codex_daemon'* ]]
  run ! grep -q '^codex app-server daemon update' "${UPDATE_CALLS}"
  grep -q '^plannotator update$' "${UPDATE_CALLS}"
}

@test "malformed or incomplete Codex responses fail without updating" {
  local response
  for response in 'not json' '{}' '{"cliVersion":"0.163.0","managedCodexVersion":"","appServerVersion":null}'; do
    export CODEX_VERSION_JSON="${response}"
    run_update --keep-going codex
    [ "${status}" -eq 2 ]
    run ! grep -q '^codex app-server daemon update' "${UPDATE_CALLS}"
  done
}

@test "missing jq fails visibly without restarting Codex" {
  rm "${BATS_TEST_TMPDIR}/commands/jq"
  # macOS may also ship /usr/bin/jq; shadow it to simulate an unavailable parser.
  printf '#!/bin/bash\nexit 127\n' >"${BATS_TEST_TMPDIR}/commands/jq"
  chmod +x "${BATS_TEST_TMPDIR}/commands/jq"
  run_update --keep-going codex
  [ "${status}" -eq 2 ]
  run ! grep -q '^codex app-server daemon update' "${UPDATE_CALLS}"
}

@test "Codex update failure respects strict and keep-going modes" {
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":"0.162.1","appServerVersion":"0.162.1"}'
  export CODEX_UPDATE_EXIT=7
  run_update codex plannotator
  [ "${status}" -eq 1 ]
  run ! grep -q '^plannotator update$' "${UPDATE_CALLS}"
  run_update --keep-going codex plannotator
  [ "${status}" -eq 2 ]
  grep -q '^plannotator update$' "${UPDATE_CALLS}"
}
