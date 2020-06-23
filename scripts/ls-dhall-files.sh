#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -eu pipefail

IGNORE_DIRS=(
  "src/deps"
)

fd --extension dhall --exclude "${IGNORE_DIRS[@]}"
