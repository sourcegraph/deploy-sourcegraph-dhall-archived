#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -eu pipefail

DHALL_FILES=()

mapfile -t DHALL_FILES < <(scripts/ls-dhall-files.sh)

function format() {
  local file="$1"

  local FORMAT_ARGS=(
    "format"
    "--inplace"
    "${file}"
  )

  if [ "${CHECK:-"false"}" == "true" ]; then
    FORMAT_ARGS+=("--check")
  fi

  result=$(dhall "${FORMAT_ARGS[@]}" 2>&1)
  rc=$?

  if [ -n "$result" ]; then
    echo "${file}:"
    echo "$result"
    echo
  fi

  exit "$rc"
}
export -f format

./scripts/parallel_run.sh format {} ::: "${DHALL_FILES[@]}"
