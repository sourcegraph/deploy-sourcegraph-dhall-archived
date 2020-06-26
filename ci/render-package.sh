#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -euxo pipefail

ls
pwd
# sudo apt-get install tree --yes
# tree src/
cat ./src/deps/k8s/schemas/io.k8s.api.apps.v1.Daemonset.dhall

dhall --explain --file ./package.dhall >/dev/null
