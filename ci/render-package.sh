#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -euxo pipefail

PACKAGE_FILE="${PACKAGE_FILE:-"package.dhall"}"

dhall --explain --file "${PACKAGE_FILE}" >/dev/null
