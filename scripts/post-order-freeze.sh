#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -euo pipefail

DHALL_FILE="./package.dhall"

DEPENDENCIES=()

mapfile -t DEPENDENCIES < <(dhall resolve --no-cache --transitive-dependencies --file "${DHALL_FILE}")

for dependency in "${DEPENDENCIES[@]}"; do
  DEPENDENCY_FILE=$(cut -d' ' -f1 <<<"$dependency")
  echo "${DEPENDENCY_FILE}"

  dhall freeze --all --inplace "${DEPENDENCY_FILE}"
done
