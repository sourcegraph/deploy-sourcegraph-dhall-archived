#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"
set -euxo pipefail

GIT_COMMIT="fd9cdd46470d4cd0ae2db6191fd214f954096af1"

ARCHIVE="dhall-kubernetes.gz"

cleanup() {
	rm -rf "$ARCHIVE"
}
trap cleanup EXIT

wget -O "$ARCHIVE" "https://github.com/dhall-lang/dhall-kubernetes/tarball/${GIT_COMMIT}"

DESTINATION="k8s"
rm -rf "${DESTINATION:?}"/*

KUBERNETES_VERSION="1.17"
tar -xvf "$ARCHIVE" --strip-components=2 -C "$DESTINATION" "dhall-lang-dhall-kubernetes-${GIT_COMMIT:0:7}/$KUBERNETES_VERSION"
