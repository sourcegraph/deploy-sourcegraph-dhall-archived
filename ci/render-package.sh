#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -euxo pipefail

ls
pwd
tree src/

dhall --explain --file ./package.dhall >/dev/null
