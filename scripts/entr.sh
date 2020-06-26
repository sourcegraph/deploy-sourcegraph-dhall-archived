#!/usr/bin/env bash

set -euo pipefail

if ! command -v entr &>/dev/null; then
	echo "'entr' is not installed. Please install 'entr' via 'brew install entr' or from http://eradman.com/entrproject/"
	exit 1
fi

trap "exit" SIGINT

LS_DHALL_SCRIPT="$(dirname "${BASH_SOURCE[0]}")/ls-dhall-files.sh"

while true; do
	"${LS_DHALL_SCRIPT}" | (entr -cd "$@" || true)
done
