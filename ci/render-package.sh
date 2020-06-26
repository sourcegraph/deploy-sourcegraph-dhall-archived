#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -euxo pipefail

ls
pwd
sudo apt-get install tree --yes
tree src/

dhall --explain --file ./package.dhall >/dev/null
