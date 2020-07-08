#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -euxo pipefail

FILES=(
  ./package.dhall
  ./generate-plain.dhall # generate isn't exported as a speed optimization
)

for file in "${FILES[@]}"; do
  dhall --explain --file "$file" >/dev/null
done
