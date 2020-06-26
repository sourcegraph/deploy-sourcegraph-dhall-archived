#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -euxo pipefail

pwd
# sudo apt-get install tree --yes
# tree src/
echo
echo "./src ---"
ls ./src
echo
echo "./src/deps ---"
ls ./src/deps
echo
echo "./src/deps/k8s ---"
ls ./src/deps/k8s
echo
echo "./src/deps/k8s/schemas ---"
ls ./src/deps/k8s/schemas
echo
echo "cat ./src/deps/k8s/schemas/io.k8s.api.apps.v1.Daemonset.dhall ---"
cat ./src/deps/k8s/schemas/io.k8s.api.apps.v1.Daemonset.dhall

dhall --explain --file ./package.dhall >/dev/null
