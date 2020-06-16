# deploy-sourcegraph-dhall

(work in progress - implementation of https://github.com/sourcegraph/sourcegraph/issues/10936)

Translation of [sourcegraph/deploy-sourcegraph](https://github.com/sourcegraph/deploy-sourcegraph) into dhall.

The configuration style is similar to Helm: pipeline.dhall (values.yaml) contains a giant union of all the possible configuration options. These options are passed into the `render` functions for the individual components in "base/".

## Instructions

Generate all the yaml manifests by running the following command:

```bash
dhall-to-yaml --file ./pipeline.dhall
```
