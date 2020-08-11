#!/usr/bin/env bash

set -ex

cd "$(dirname "${BASH_SOURCE[0]}")"/..

dhall-to-yaml --file ci/dhall/workflow.dhall --output "${OUTPUT:-".github/workflows/ci.yaml"}" --generated-comment

yarn
yarn prettier
