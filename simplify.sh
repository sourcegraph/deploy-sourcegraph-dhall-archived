#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"
set -euxo pipefail

custom_dhall="/Users/ggilmore/dev/mess/dhall-haskell/.stack-work/install/x86_64-osx/ea78e8ceb412898ba4b8442c7212899c8291a970f3876b8b748734d24e36033f/8.6.5/bin/dhall"

generate_file="./generate-plain.dhall"
schema_file="./src/deps/k8s/schemas.dhall"

component_name="PreciseCodeIntel"
output_file="./src/base/precise-code-intel/simple.dhall"

simplfied_file=$(echo "(${generate_file}).${component_name}" | "$custom_dhall" schemas --record "$schema_file")

echo "$simplfied_file" >"$output_file"
