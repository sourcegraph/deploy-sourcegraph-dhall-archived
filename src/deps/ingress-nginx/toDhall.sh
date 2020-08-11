#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"
set -euo pipefail

cd split-yaml
YAML_FILES=()
mapfile -t YAML_FILES < <(fd --extension yaml)

record="{=}"

for f in ${YAML_FILES[*]}; do
  kind=$(yq read "$f" 'kind')
  component=$(yq read "$f" --defaultValue root 'metadata.labels."app.kubernetes.io/component"')
  name=$(yq read "$f" 'metadata.name')
  dhallExpression=$(printf "let kubernetes = https://raw.githubusercontent.com/dhall-lang/dhall-kubernetes/master/1.17/package.dhall in kubernetes.%s.Type" "$kind")

  k8sDhall="$(yaml-to-dhall --file "$f" --records-loose "${dhallExpression}")"
  record="$record /\ { $component = { $kind = { $name = ${k8sDhall} } } }"
done

echo "$record" | dhall --explain --output nginx-ingress.dhall
dhall rewrite-with-schemas --schemas ../../k8s/schemas.dhall --inplace nginx-ingress.dhall
