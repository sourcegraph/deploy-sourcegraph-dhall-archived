#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/../..
set -euxo pipefail

yarn
if ! yarn run prettier-check; then
  echo "The files listed above aren't correctly formatted. Please run 'yarn prettier' and commit the result."
  exit 1
fi
