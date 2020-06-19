#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -eu pipefail

DHALL_FILES=()

IGNORE_DIRS=(
  "deps"
)

mapfile -t DHALL_FILES < <(fd --extension dhall --exclude "${IGNORE_DIRS[@]}")

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

echo 'will cite' | parallel --citation &>/dev/null

parallel --keep-order --line-buffer format {} ::: "${DHALL_FILES[@]}"
