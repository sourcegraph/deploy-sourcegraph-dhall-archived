#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"/..
set -euo pipefail

DHALL_FILE="./package.dhall"

DEPENDENCIES=()

mapfile -t DEPENDENCIES < <(dhall resolve --no-cache --transitive-dependencies --file "${DHALL_FILE}")

for dependency in "${DEPENDENCIES[@]}"; do
	DEPENDENCY_FILE=$(cut -d' ' -f1 <<<"$dependency")
	if test -f "$DEPENDENCY_FILE" && [[ "$DEPENDENCY_FILE" =~ \.dhall$ ]]; then

		echo "${DEPENDENCY_FILE}"
		dhall freeze --all --inplace "${DEPENDENCY_FILE}"
	fi
done
