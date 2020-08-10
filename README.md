# deploy-sourcegraph-dhall

(work in progress - implementation of https://github.com/sourcegraph/sourcegraph/issues/10936)

Translation of [sourcegraph/deploy-sourcegraph](https://github.com/sourcegraph/deploy-sourcegraph) into dhall.

The configuration style is similar to Helm: pipeline.dhall (values.yaml) contains a giant union of all the possible configuration options. These options are passed into the `render` functions for the individual components in "base/".

## Instructions

Generate all the yaml manifests by running the following command:

```bash
dhall-to-yaml --file ./pipeline.dhall
```

## Benchmarks

Commit: https://github.com/sourcegraph/deploy-sourcegraph-dhall/commit/285b1515ade18682d1fac33f8e70bb32100dd67c

### Render time

```shell
❯ bench  'dhall-to-yaml --file pipeline.dhall'
benchmarking dhall-to-yaml --file pipeline.dhall
time                 31.84 s    (30.49 s .. 33.53 s)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 32.37 s    (32.10 s .. 32.73 s)
std dev              395.0 ms   (24.38 ms .. 495.0 ms)
variance introduced by outliers: 19% (moderately inflated)
```

(after freezing with https://github.com/sourcegraph/deploy-sourcegraph-dhall/blob/master/scripts/post-order-freeze.sh)

```shell
❯ ./scripts/post-order-freeze.sh
...
❯ bench  'dhall-to-yaml --file pipeline.dhall'
benchmarking dhall-to-yaml --file pipeline.dhall
time                 25.49 s    (23.77 s .. 26.68 s)
                     0.999 R²   (0.999 R² .. 1.000 R²)
mean                 26.60 s    (26.00 s .. 27.74 s)
std dev              1.110 s    (19.74 ms .. 1.320 s)
variance introduced by outliers: 19% (moderately inflated)
```

### Normal form size

```shell
❯ dhall --file pipeline.dhall | dhall encode | wc -c
 51887040
```
