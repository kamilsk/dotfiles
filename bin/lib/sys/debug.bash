#!/usr/bin/env bash

debug() { env -i HOME="${HOME}" bash -clx "${*}"; }

explain() { open "https://explainshell.com/explain?cmd=${*}"; }
