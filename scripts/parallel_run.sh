#!/usr/bin/env bash

if ! command -v parallel &>/dev/null; then
  echo "'GNU parallel' is not installed. Please install 'parallel' via 'brew install parallel' or from https://savannah.gnu.org/projects/parallel/."
  echo "🚨 Do not install the version of 'parallel' provided by 'moreutils'!"
  exit 1
fi

# Remove parallel citation log spam.
echo 'will cite' | parallel --citation &>/dev/null

parallel --keep-order --line-buffer "$@"
