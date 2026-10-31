#!/usr/bin/env bats

# Each Bats test deliberately gets its own exported fixture state.
# shellcheck disable=SC2030,SC2031

setup() {
  bats_require_minimum_version 1.5.0
  export SELF_UPDATE_TEST_ROOT="${BATS_TEST_TMPDIR}/dotfiles"
  export UPDATE_CALLS="${BATS_TEST_TMPDIR}/calls"
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":"0.163.0","appServerVersion":"0.163.0"}'
  export CODEX_QUERY_EXIT=0 CODEX_UPDATE_EXIT=0 PLANNOTATOR_UPDATE_EXIT=0 DOCKER_INFO_EXIT=0
  export PLANNOTATOR_CHECK_EXIT=0 PLANNOTATOR_LATEST='' PREPARE_EXIT=0 PREPARE_CA='' INSTALL_SH_EXIT=0 INSTALL_SH_MISMATCH=''
  unset CURL_CA_BUNDLE GIT_HTTP_LOW_SPEED_LIMIT GIT_HTTP_LOW_SPEED_TIME
  # a temp folder of its own, so a staged update left behind is seen
  export TMPDIR="${BATS_TEST_TMPDIR}/tmp"
  mkdir -p "${TMPDIR}"
  # Plannotator as install.sh leaves it: the binary in ~/.local/bin, the data folder next to it,
  # and the upstream script with the one silent download self-update adapts.
  export HOME="${BATS_TEST_TMPDIR}/home"
  export PLANNOTATOR_DATA="${HOME}/.plannotator" PLANNOTATOR_INSTALL_SH="${BATS_TEST_TMPDIR}/install.sh"
  mkdir -p "${HOME}/.local/bin" "${PLANNOTATOR_DATA}"
  echo '{"v":1,"flags":[]}' >"${PLANNOTATOR_DATA}/install-flags.json"
  cat >"${PLANNOTATOR_INSTALL_SH}" <<'SH'
#!/bin/bash
REPO="backnotprop/plannotator"
{
  echo "install.sh $*"
  echo "install.sh: lock $(cat "${PLANNOTATOR_DATA}/update.lock" 2>/dev/null)"
  echo "install.sh: update ${PLANNOTATOR_UPDATE_VERSION-} sha256 ${PLANNOTATOR_EXPECTED_SHA256-}"
  echo "install.sh: git ${GIT_HTTP_LOW_SPEED_LIMIT-} ${GIT_HTTP_LOW_SPEED_TIME-} ca ${CURL_CA_BUNDLE##*/}"
} >>"${UPDATE_CALLS}"
tmp_file=/dev/null binary_url=https://example.invalid/plannotator-darwin-arm64
curl -fsSL -o "$tmp_file" --speed-limit 1 --speed-time 60 "$binary_url"
if [ -n "${INSTALL_SH_MISMATCH}" ]; then
  : >"${PLANNOTATOR_UPDATE_MISMATCH_FILE}"
  exit 1
fi
exit "${INSTALL_SH_EXIT}"
SH
  export SHELL=/bin/bash SCUTIL_HOST=test-host UNAME_HOST=Mac
  unset ZSH
  # A live daemon socket, linked from CODEX_HOME into a short directory the way Codex does it:
  # BATS_TEST_TMPDIR is too long for a Unix socket path on macOS (104 bytes).
  export CODEX_HOME="${BATS_TEST_TMPDIR}/codex"
  CODEX_SOCKET_DIR=$(mktemp -d /tmp/codex-test.XXXXXX)
  mkdir -p "${CODEX_HOME}/app-server-control"
  perl -MIO::Socket::UNIX -e 'IO::Socket::UNIX->new(Local => $ARGV[0], Listen => 1) or die "$!\n"' \
    "${CODEX_SOCKET_DIR}/sock"
  ln -s "${CODEX_SOCKET_DIR}/sock" "${CODEX_HOME}/app-server-control/app-server-control.sock"
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
if [ -n "${HOMEBREW_BUNDLE_INSTALL_CLEANUP-}${HOMEBREW_BUNDLE_FORCE_INSTALL_CLEANUP-}" ]; then
  echo "${name}: cleanup requested by the environment" >>"${UPDATE_CALLS}"
fi
case "${name} $*" in
  'codex app-server daemon version')
    echo "${CODEX_VERSION_JSON}"
    exit "${CODEX_QUERY_EXIT}"
    ;;
  'codex app-server daemon update --from-cli --yes') exit "${CODEX_UPDATE_EXIT}" ;;
  'plannotator update')
    # the native updater refuses a lock it holds to be live
    if [ -e "${PLANNOTATOR_DATA}/update.lock" ]; then
      echo 'Another update is already running.' >&2
      exit 1
    fi
    exit "${PLANNOTATOR_UPDATE_EXIT}"
    ;;
  'plannotator update --check')
    if [ -n "${PLANNOTATOR_LATEST}" ]; then
      printf 'Plannotator %s is available (you have 0.28.44).\nUpdate: plannotator update\n' "${PLANNOTATOR_LATEST}"
    else
      echo 'Plannotator 0.28.44 is installed. Up to date (checked just now).'
    fi
    exit "${PLANNOTATOR_CHECK_EXIT}"
    ;;
  'plannotator data-dir') echo "${PLANNOTATOR_DATA}" ;;
  'plannotator update-prepare '*)
    [ "${PREPARE_EXIT}" -eq 0 ] || exit "${PREPARE_EXIT}"
    staged=$(mktemp -d "${TMPDIR}/plannotator-update-XXXXXX")
    cp "${PLANNOTATOR_INSTALL_SH}" "${staged}/install.sh"
    echo 'plannotator-darwin-arm64=0123abcd' >"${staged}/expected-sha256"
    [ -z "${PREPARE_CA}" ] || echo 'PEM' >"${staged}/curl-ca-bundle.pem"
    echo "${staged}"
    ;;
  'git -C '*' status --porcelain')
    # the tree turns dirty from the GIT_DIRTY_FROM-th check on: 1 is the start, 2 the end
    checks=$(($(cat "${UPDATE_CALLS}.status" 2>/dev/null || echo 0) + 1))
    echo "${checks}" >"${UPDATE_CALLS}.status"
    if [ "${checks}" -ge "${GIT_DIRTY_FROM:-0}" ] && [ "${GIT_DIRTY_FROM:-0}" -gt 0 ]; then
      echo ' M bin/self-update'
    fi
    ;;
  'docker images '*) echo 'example/image:latest' ;;
  'docker info') exit "${DOCKER_INFO_EXIT}" ;;
  'scutil --get LocalHostName')
    [ -n "${SCUTIL_HOST}" ] || exit 1
    echo "${SCUTIL_HOST}"
    ;;
  'uname -n') echo "${UNAME_HOST}" ;;
esac
SH
  chmod +x "${commands}/stub"
  local command
  for command in git git_config brew mas docker codex scutil uname curl; do
    ln -s stub "${commands}/${command}"
  done
  ln -s "${commands}/stub" "${HOME}/.local/bin/plannotator"
  ln -s "${commands}/stub" "${SELF_UPDATE_TEST_ROOT}/toolset/Apps"
  ln -s "${commands}/stub" "${SELF_UPDATE_TEST_ROOT}/bin/unquarantine"
  # Exclude real package managers and optional tools (especially Go's cleanup).
  export PATH="${commands}:${HOME}/.local/bin:/usr/bin:/bin"
}

teardown() {
  rm -rf "${CODEX_SOCKET_DIR}"
}

run_update() {
  run /bin/bash "${SELF_UPDATE_TEST_ROOT}/bin/self-update" "$@"
}

@test "all checks Plannotator and syncs Codex after brew, last" {
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":"0.162.1","appServerVersion":"0.162.1"}'
  run_update all
  [ "${status}" -eq 0 ]
  grep -q '^plannotator update --check$' "${UPDATE_CALLS}"
  grep -q '^codex app-server daemon update --from-cli --yes$' "${UPDATE_CALLS}"
  local brew_line plannotator_line codex_line
  brew_line=$(grep -n '^brew doctor' "${UPDATE_CALLS}" | cut -d: -f1)
  plannotator_line=$(grep -n '^plannotator update --check$' "${UPDATE_CALLS}" | cut -d: -f1)
  codex_line=$(grep -n '^codex app-server daemon version$' "${UPDATE_CALLS}" | cut -d: -f1)
  [ "${brew_line}" -lt "${plannotator_line}" ]
  [ "${plannotator_line}" -lt "${codex_line}" ]
  # the last step; only the end-of-run git check and reset come after it
  [ "$(grep -v '^git ' "${UPDATE_CALLS}" | tail -n 1)" = 'codex app-server daemon update --from-cli --yes' ]
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

@test "a stopped daemon is skipped without asking it, even in strict mode" {
  # a reboot empties /tmp and leaves the link dangling; a daemon never installed has no link
  rm -rf "${CODEX_SOCKET_DIR}"
  run_update all
  [ "${status}" -eq 0 ]
  [[ "${output}" == *'Codex daemon is not running; skipping'* ]]
  run ! grep -q '^codex ' "${UPDATE_CALLS}"
  rm "${CODEX_HOME}/app-server-control/app-server-control.sock"
  run_update codex
  [ "${status}" -eq 0 ]
  run ! grep -q '^codex ' "${UPDATE_CALLS}"
}

@test "a null app-server version in the response is left alone" {
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":"0.163.0","appServerVersion":null}'
  run_update codex
  [ "${status}" -eq 0 ]
  run ! grep -q '^codex app-server daemon update' "${UPDATE_CALLS}"
}

@test "an old package with a null app-server version is updated" {
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":"0.162.1","appServerVersion":null}'
  run_update codex
  [ "${status}" -eq 0 ]
  grep -q '^codex app-server daemon update --from-cli --yes$' "${UPDATE_CALLS}"
}

@test "a response without a package is not installed" {
  export CODEX_VERSION_JSON='{"cliVersion":"0.163.0","managedCodexVersion":null,"appServerVersion":null}'
  run_update codex
  [ "${status}" -eq 0 ]
  [[ "${output}" == *'not installed'* ]]
  run ! grep -q '^codex app-server daemon update' "${UPDATE_CALLS}"
}

@test "brew steps are quiet by default, except the live output of brew bundle" {
  run_update brew
  [ "${status}" -eq 0 ]
  grep -q '^brew bundle --file=.* --verbose --upgrade' "${UPDATE_CALLS}"
  grep -q '^brew doctor$' "${UPDATE_CALLS}"
  run ! grep -q -- '--verbose' <(grep -v '^brew bundle ' "${UPDATE_CALLS}")
}

@test "--verbose reaches every brew step and combines with --keep-going" {
  local flags
  for flags in '-v' '--verbose' '-k -v' '-v -k'; do
    : >"${UPDATE_CALLS}"
    # shellcheck disable=SC2086 # the flags are split on purpose
    run_update ${flags} brew
    [ "${status}" -eq 0 ]
    [[ "${output}" != *'unknown type'* ]]
    grep -q '^brew bundle --file=.* --verbose --upgrade' "${UPDATE_CALLS}"
    grep -q '^brew cu .* --verbose$' "${UPDATE_CALLS}"
    grep -q '^brew doctor --verbose$' "${UPDATE_CALLS}"
  done
}

@test "the LocalHostName Brewfile is installed with cleanup, whatever uname says" {
  mkdir -p "${SELF_UPDATE_TEST_ROOT}/toolset"
  echo 'brew "git"' >"${SELF_UPDATE_TEST_ROOT}/toolset/test-host.Brewfile"
  run_update brew
  [ "${status}" -eq 0 ]
  grep -q '^brew bundle --file=.*/toolset/test-host.Brewfile --verbose --upgrade --force --force-cleanup$' "${UPDATE_CALLS}"
}

@test "without scutil the host comes from uname" {
  mkdir -p "${SELF_UPDATE_TEST_ROOT}/toolset"
  echo 'brew "git"' >"${SELF_UPDATE_TEST_ROOT}/toolset/linux-box.Brewfile"
  export SCUTIL_HOST='' UNAME_HOST=linux-box.local
  run_update brew
  [ "${status}" -eq 0 ]
  grep -q '^brew bundle --file=.*/toolset/linux-box.Brewfile .*--force-cleanup$' "${UPDATE_CALLS}"
}

@test "without a host Brewfile nothing is cleaned up" {
  # the common Brewfile is a minimum: cleaning up to it once uninstalled every app
  mkdir -p "${SELF_UPDATE_TEST_ROOT}/toolset"
  touch "${SELF_UPDATE_TEST_ROOT}/toolset/test-host.Brewfile" # empty counts as missing
  export HOMEBREW_BUNDLE_INSTALL_CLEANUP=1 HOMEBREW_BUNDLE_FORCE_INSTALL_CLEANUP=1
  run_update brew
  [ "${status}" -eq 0 ]
  [[ "${output}" == *"no Brewfile for host 'test-host'"* ]]
  grep -q '^brew bundle --file=.*/toolset/Brewfile --verbose --upgrade --force$' "${UPDATE_CALLS}"
  run ! grep -q -- '^brew bundle.*cleanup' "${UPDATE_CALLS}"
  # the environment reaches other steps but not the common bundle
  grep -A1 '^brew bundle' "${UPDATE_CALLS}" >"${BATS_TEST_TMPDIR}/bundle"
  run ! grep -q 'cleanup requested' "${BATS_TEST_TMPDIR}/bundle"
}

@test "a clean run resets the tree at the end" {
  run_update docker
  [ "${status}" -eq 0 ]
  [ "$(tail -n 1 "${UPDATE_CALLS}")" = 'git reset --hard' ]
}

@test "local changes stop the run before any step" {
  export GIT_DIRTY_FROM=1
  run_update docker
  [ "${status}" -eq 1 ]
  [[ "${output}" == *'commit or stash them first'* ]]
  run ! grep -Eq '^(docker|git reset)' "${UPDATE_CALLS}"
}

@test "changes made during the run fail it instead of being reset" {
  export GIT_DIRTY_FROM=2 PLANNOTATOR_CHECK_EXIT=1
  run_update --keep-going docker plannotator
  [ "${status}" -eq 1 ]
  grep -q '^docker pull' "${UPDATE_CALLS}"
  [[ "${output}" == *'finished with failures:'*'plannotator_update'*'M bin/self-update'*'appeared during the run, so nothing was reset'* ]]
  [[ "${output}" != *'source '* ]]
  run ! grep -q '^git reset' "${UPDATE_CALLS}"
}

@test "missing optional executables are skipped" {
  rm "${BATS_TEST_TMPDIR}/commands/codex" "${HOME}/.local/bin/plannotator"
  run_update plannotator codex
  [ "${status}" -eq 0 ]
  run ! grep -Eq '^(plannotator|codex) ' "${UPDATE_CALLS}"
}

@test "an up-to-date Plannotator is only checked" {
  run_update plannotator
  [ "${status}" -eq 0 ]
  [[ "${output}" == *'Up to date'* ]]
  [ "$(grep -c '^plannotator ' "${UPDATE_CALLS}")" -eq 1 ]
  grep -q '^plannotator update --check$' "${UPDATE_CALLS}"
  run ! grep -Eq '^(curl|install\.sh|brew|codex) ' "${UPDATE_CALLS}"
}

@test "a new Plannotator release is installed by the adapted install.sh with a progress bar" {
  export PLANNOTATOR_LATEST=0.28.48
  run_update plannotator
  [ "${status}" -eq 0 ]
  [[ "${output}" == *'Plannotator 0.28.48 is available'*'Installing v0.28.48; the download shows its progress'* ]]
  grep -q '^plannotator update-prepare v0\.28\.48$' "${UPDATE_CALLS}"
  grep -q '^install\.sh --version v0\.28\.48 --non-interactive$' "${UPDATE_CALLS}"
  # an update, not a pin, so install.sh updates the Claude Code plugin; the checksum stays pinned
  grep -q '^install\.sh: update v0\.28\.48 sha256 plannotator-darwin-arm64=0123abcd$' "${UPDATE_CALLS}"
  grep -q '^install\.sh: git 1 60 ca $' "${UPDATE_CALLS}"
  grep -Eq '^install\.sh: lock pid=[0-9]+ group=[0-9]+ host=Mac boot= pidns=$' "${UPDATE_CALLS}"
  grep -q '^curl -fSL --progress-bar -o /dev/null --speed-limit 1 --speed-time 60 https://example.invalid/' "${UPDATE_CALLS}"
  run ! grep -q '^curl -fsSL' "${UPDATE_CALLS}"
  run ! grep -q '^plannotator update$' "${UPDATE_CALLS}"
  [ ! -e "${PLANNOTATOR_DATA}/update.lock" ]
  [ -z "$(ls -A "${TMPDIR}")" ]
}

@test "the CA bundle staged for an extra certificate reaches install.sh" {
  export PLANNOTATOR_LATEST=0.28.48 PREPARE_CA=1
  run_update plannotator
  [ "${status}" -eq 0 ]
  grep -q '^install\.sh: git 1 60 ca curl-ca-bundle\.pem$' "${UPDATE_CALLS}"
}

@test "without install-flags.json the release is installed with the defaults" {
  export PLANNOTATOR_LATEST=0.28.48
  rm "${PLANNOTATOR_DATA}/install-flags.json"
  run_update plannotator
  [ "${status}" -eq 0 ]
  grep -q '^install\.sh --version v0\.28\.48 --non-interactive$' "${UPDATE_CALLS}"
}

@test "a failed install is reported, not retried by the native updater" {
  export PLANNOTATOR_LATEST=0.28.48 INSTALL_SH_EXIT=4
  run_update plannotator
  [ "${status}" -eq 1 ]
  grep -q '^install\.sh ' "${UPDATE_CALLS}"
  run ! grep -q '^plannotator update$' "${UPDATE_CALLS}"
  [ ! -e "${PLANNOTATOR_DATA}/update.lock" ]
  [ -z "$(ls -A "${TMPDIR}")" ]
}

@test "a download that does not match the pinned checksum fails the step" {
  export PLANNOTATOR_LATEST=0.28.48 INSTALL_SH_MISMATCH=1
  run_update plannotator
  [ "${status}" -eq 1 ]
  [[ "${output}" == *'did not match the pinned checksum'* ]]
  run ! grep -q '^plannotator update$' "${UPDATE_CALLS}"
  [ ! -e "${PLANNOTATOR_DATA}/update.lock" ]
}

# a new release that self-update must leave to the native updater, saying why;
# the native updater stub refuses to run while the lock is still there
expect_native_update() {
  run_update plannotator
  local update_status=${status} update_output=${output}
  [[ "${output}" == *"self-update: plannotator: $1; using the native updater"* ]]
  grep -q '^plannotator update$' "${UPDATE_CALLS}"
  run ! grep -q '^install\.sh ' "${UPDATE_CALLS}"
  # the run's, for the caller to check
  status=${update_status} output=${update_output}
}

@test "an upstream install.sh without the known download line is not run" {
  export PLANNOTATOR_LATEST=0.28.48
  sed -i '' 's/curl -fsSL -o/curl -fsSL --retry 3 -o/' "${PLANNOTATOR_INSTALL_SH}"
  expect_native_update 'install.sh changed upstream, the download line was not found; adapt self-update'
  [ "${status}" -eq 0 ]
  [ ! -e "${PLANNOTATOR_DATA}/update.lock" ]
  [ -z "$(ls -A "${TMPDIR}")" ]
}

@test "a script that is not Plannotator's install.sh is not run" {
  export PLANNOTATOR_LATEST=0.28.48
  sed -i '' '/^REPO=/d' "${PLANNOTATOR_INSTALL_SH}"
  expect_native_update 'install.sh changed upstream, the download line was not found; adapt self-update'
  [ "${status}" -eq 0 ]
}

@test "an update that could not be staged is left to the native updater, with the lock released" {
  export PLANNOTATOR_LATEST=0.28.48 PREPARE_EXIT=75
  expect_native_update 'plannotator update-prepare did not stage the update'
  [ "${status}" -eq 0 ]
  [ ! -e "${PLANNOTATOR_DATA}/update.lock" ]
}

@test "a taken update lock is left to the native updater to judge" {
  export PLANNOTATOR_LATEST=0.28.48
  echo 'pid=1 group=2 host=Mac boot= pidns=' >"${PLANNOTATOR_DATA}/update.lock"
  expect_native_update "${PLANNOTATOR_DATA}/update.lock is taken"
  [ "${status}" -eq 1 ]
  [[ "${output}" == *'Another update is already running.'* ]]
  [ "$(cat "${PLANNOTATOR_DATA}/update.lock")" = 'pid=1 group=2 host=Mac boot= pidns=' ]
  run ! grep -q '^plannotator update-prepare' "${UPDATE_CALLS}"
}

@test "install options of the last install are left to the native updater" {
  export PLANNOTATOR_LATEST=0.28.48
  echo '{"v":1,"flags":["skip-claude-plugin"]}' >"${PLANNOTATOR_DATA}/install-flags.json"
  expect_native_update "the last install had options in ${PLANNOTATOR_DATA}/install-flags.json"
  [ "${status}" -eq 0 ]
  echo '{"v":2}' >"${PLANNOTATOR_DATA}/install-flags.json"
  : >"${UPDATE_CALLS}"
  expect_native_update "the last install had options in ${PLANNOTATOR_DATA}/install-flags.json"
  [ "${status}" -eq 0 ]
}

@test "a copy that install.sh does not manage is left to the native updater" {
  export PLANNOTATOR_LATEST=0.28.48
  mv "${HOME}/.local/bin/plannotator" "${BATS_TEST_TMPDIR}/commands/plannotator"
  expect_native_update "${BATS_TEST_TMPDIR}/commands/plannotator is not the copy install.sh manages"
  [ "${status}" -eq 0 ]
}

@test "an unknown answer of the release check is left to the native updater" {
  # the stub answers "up to date" unless told otherwise; replace that answer
  sed -i '' "s/is installed. Up to date (checked just now)./is somewhere else./" "${BATS_TEST_TMPDIR}/commands/stub"
  expect_native_update "unknown answer of 'plannotator update --check'"
  [ "${status}" -eq 0 ]
}

@test "strict mode stops on a Plannotator update failure" {
  export PLANNOTATOR_CHECK_EXIT=1
  run_update plannotator codex
  [ "${status}" -eq 1 ]
  run ! grep -q '^codex ' "${UPDATE_CALLS}"
}

@test "keep-going reports Plannotator failure and still checks Codex" {
  export PLANNOTATOR_CHECK_EXIT=1
  run_update --keep-going all
  [ "${status}" -eq 2 ]
  [[ "${output}" == *'finished with failures:'*'plannotator_update'* ]]
  grep -q '^codex app-server daemon version$' "${UPDATE_CALLS}"
}

@test "failed Codex version query never triggers an update" {
  export CODEX_QUERY_EXIT=7
  run_update --keep-going codex plannotator
  [ "${status}" -eq 2 ]
  [[ "${output}" == *'sync_codex_daemon'* ]]
  run ! grep -q '^codex app-server daemon update' "${UPDATE_CALLS}"
  grep -q '^plannotator update --check$' "${UPDATE_CALLS}"
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
  run ! grep -q '^plannotator ' "${UPDATE_CALLS}"
  run_update --keep-going codex plannotator
  [ "${status}" -eq 2 ]
  grep -q '^plannotator update --check$' "${UPDATE_CALLS}"
}

@test "Docker images are pulled when the daemon answers" {
  run_update docker
  [ "${status}" -eq 0 ]
  grep -q '^docker pull example/image:latest$' "${UPDATE_CALLS}"
  [[ "${output}" == *'Docker images were updated'* ]]
}

@test "a stopped Docker daemon is skipped and not reported as updated" {
  export DOCKER_INFO_EXIT=1
  run_update docker
  [ "${status}" -eq 0 ]
  [[ "${output}" == *'Docker daemon is not running; images were not updated'* ]]
  [[ "${output}" != *'Docker images were updated'* ]]
  run ! grep -Eq '^docker (images|pull)' "${UPDATE_CALLS}"
}
