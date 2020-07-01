#!/usr/bin/env bash

set -euo pipefail

if ! command -v watchexec &>/dev/null; then
  echo "'watchexec' is not installed. Please install 'watchexec' via 'brew install watchexec' or from https://github.com/watchexec/watchexec"
  exit 1
fi

trap "exit" SIGINT

watchexec --clear --exts dhall "$@"
