#!/usr/bin/env bats

# A stub engine stands in for MacWhisper's mw: it records its arguments one per line
# and prints a canned two-speaker transcript, so no audio or model is needed.

setup() {
  bats_require_minimum_version 1.5.0
  load 'helper/support/load.bash'
  load 'helper/assert/load.bash'

  BIN=$(cd "$(dirname "${BATS_TEST_FILENAME}")/../bin" && pwd)
  STUB="${BATS_TEST_TMPDIR}/stub"
  export CALLS="${BATS_TEST_TMPDIR}/calls" STUB_EXIT=0
  mkdir -p "${STUB}"
  cat >"${STUB}/mw" <<'SH'
#!/bin/sh
for arg in "$@"; do printf '%s\n' "${arg}"; done >>"${CALLS}"
echo 'Transcribing...' >&2
[ "${STUB_EXIT}" -eq 0 ] || exit "${STUB_EXIT}"
printf 'Speaker 2\n00:00\nПривет.\n\nSpeaker 1\n00:04\nДобрый день.\n\nSpeaker 3\n00:08\nИ я тут.\n\nSpeaker 2\n00:10\nПока.\n'
SH
  chmod +x "${STUB}/mw"
  # no mw from the machine: only the stub, the command under test and the system tools
  export PATH="${STUB}:${BIN}:/usr/bin:/bin"
  export TRANSCRIBE_APP_DIRS="${BATS_TEST_TMPDIR}/apps"
  cd "${BATS_TEST_TMPDIR}" || return 1
  : >'call one.m4a'
  : >other.m4a
}

calls() { cat "${CALLS}"; }

@test "defaults reach the engine and the input goes last" {
  run transcribe 'call one.m4a'
  assert_success
  assert_equal "$(calls)" "transcribe
--model=parakeet-pro:nvidia_parakeet-v3
--language=ru
--speakers
--format=txt
--style=transcript
--group=people
--timestamps
call one.m4a"
}

@test "the transcript alone goes to stdout, the report to stderr" {
  run --separate-stderr transcribe 'call one.m4a'
  assert_success
  assert_line --index 0 'Speaker 2'
  refute_output --partial 'transcribe:'
  refute_output --partial 'Transcribing'
  [[ "${stderr}" == *'transcribe: engine mw (parakeet-pro:nvidia_parakeet-v3), language ru'* ]]
}

@test "own flags set language and format; subtitles get no transcript style" {
  run transcribe --lang=en --format srt 'call one.m4a'
  assert_success
  assert_equal "$(calls)" "transcribe
--model=parakeet-pro:nvidia_parakeet-v3
--language=en
--speakers
--format=srt
call one.m4a"
}

@test "pass-through arguments arrive unchanged and replace matching defaults" {
  run --separate-stderr transcribe 'call one.m4a' -- --model 'whisperkit:large v3' --no-speakers --style=subtitles --max-chars-per-line 42
  assert_success
  assert_equal "$(calls)" "transcribe
--language=ru
--format=txt
--timestamps
--model
whisperkit:large v3
--no-speakers
--style=subtitles
--max-chars-per-line
42
call one.m4a"
  [[ "${stderr}" == *'engine mw (whisperkit:large v3)'* ]]
}

@test "--names relabels speakers in order of appearance and keeps the rest" {
  run --separate-stderr transcribe 'call one.m4a' --names 'Паша, Камиль'
  assert_success
  assert_equal "$(grep -v -e '^$' -e '^00:' <<<"${output}" | paste -sd'|' -)" 'Паша|Привет.|Камиль|Добрый день.|Speaker 3|И я тут.|Паша|Пока.'
}

@test "-o writes a file and refuses to overwrite it without --force" {
  run transcribe 'call one.m4a' -o out.txt
  assert_success
  assert_output --partial 'transcribe: engine mw'
  run grep -c Speaker out.txt
  assert_output 4

  echo keep >out.txt
  run transcribe 'call one.m4a' -o out.txt
  assert_failure 2
  assert_output --partial 'out.txt exists; add --force'
  assert_equal "$(cat out.txt)" keep

  run transcribe 'call one.m4a' -o out.txt --force
  assert_success
  run grep -c Speaker out.txt
  assert_output 4
}

@test "several inputs need --output-dir and get one file each" {
  run transcribe 'call one.m4a' other.m4a
  assert_failure 2
  assert_output --partial '2 inputs need --output-dir'

  run transcribe 'call one.m4a' other.m4a --output-dir notes --format md
  assert_success
  [ -s 'notes/call one.md' ]
  [ -s notes/other.md ]
}

@test "two inputs with one destination are refused before any work" {
  mkdir -p b
  : >b/other.m4a
  run transcribe other.m4a b/other.m4a --output-dir notes
  assert_failure 2
  assert_output --partial 'two inputs would both write notes/other.txt'
  [ ! -e "${CALLS}" ]
}

@test "usage errors exit 2" {
  run transcribe
  assert_failure 2
  run transcribe missing.m4a
  assert_failure 2
  assert_output --partial 'no such file: missing.m4a'
  run transcribe 'call one.m4a' --model x
  assert_failure 2
  assert_output --partial 'engine options go after --'
  run transcribe 'call one.m4a' --format csv
  assert_failure 2
  run transcribe 'call one.m4a' -- --output x.txt
  assert_failure 2
  assert_output --partial 'use -o, --output-dir and --force'
}

@test "an engine failure exits 1" {
  export STUB_EXIT=3
  run transcribe 'call one.m4a'
  assert_failure 1
  assert_output --partial 'the engine failed on call one.m4a'
}

@test "mw is found inside MacWhisper.app when it is not on PATH" {
  mkdir -p "${TRANSCRIBE_APP_DIRS}/MacWhisper.app/Contents/MacOS"
  mv "${STUB}/mw" "${TRANSCRIBE_APP_DIRS}/MacWhisper.app/Contents/MacOS/mw"
  run transcribe 'call one.m4a'
  assert_success
  assert_line 'Speaker 2'
}

@test "no engine exits 127 with a hint" {
  rm "${STUB}/mw"
  run -127 transcribe 'call one.m4a'
  assert_failure 127
  assert_output --partial 'brew install --cask macwhisper'
}
