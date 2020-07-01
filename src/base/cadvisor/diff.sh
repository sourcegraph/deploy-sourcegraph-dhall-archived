#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"
set -euo pipefail

record="{=}"

for f in *.yaml; do
  kind=$(yq read "$f" 'kind')
  dhallExpression=$(printf "let kubernetes = https://raw.githubusercontent.com/dhall-lang/dhall-kubernetes/master/1.17/package.dhall in kubernetes.%s.Type" "$kind")

  parsedFile="$(basename "$f" .yaml)-RAW-IMPORT.dhall"

  yaml-to-dhall "$dhallExpression" --records-loose --file "$f" --output "$parsedFile"

  k8sDhall="$(yaml-to-dhall --file "$f" --records-loose "${dhallExpression}")"
  record="$record /\ { $kind = ${k8sDhall} }"
done

echo "$record" | dhall

touch dhall/human/package.dhall
touch dhall/raw/package.dhall

asDhall() {
  kind="$1"
  name="$2"

  k8sYAML="$(kubectl get "$kind" "${name}" -o yaml)"

  dhallExpression=$(printf "let kubernetes = https://raw.githubusercontent.com/dhall-lang/dhall-kubernetes/master/1.17/package.dhall in kubernetes.%s.Type" "$kind")

  k8sDhall="$(echo "$k8sYAML" | yaml-to-dhall --records-loose "${dhallExpression}")"

  echo "{ ${kind} = ${k8sDhall} }"
}
export -f asDhall

buildRecord() {
  base="{=}"

  for kind in "DaemonSet" "ClusterRole" "PodSecurityPolicy" "ClusterRoleBinding"; do
    k8sDhall=$(asDhall "$kind" "cadvisor")
    base="$base /\ $k8sDhall"
  done

  echo "$base" | dhall
}
export -f buildRecord

dhall diff './diff.dhall' "$(buildRecord)"
