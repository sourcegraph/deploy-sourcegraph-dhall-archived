#!/usr/bin/env bash

set -euo pipefail

DHALL_FILE="$1"

DEPENDENCIES=()

mapfile -t DEPENDENCIES < <(dhall resolve --no-cache --transitive-dependencies --file "${DHALL_FILE}")

for dependency in "${DEPENDENCIES[@]}"; do
  DEPENDENCY_FILE=$(cut -d' ' -f1 <<<"$dependency")
  echo "${DEPENDENCY_FILE}"

  dhall freeze --all --inplace "${DEPENDENCY_FILE}"
done
