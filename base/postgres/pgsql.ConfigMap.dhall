let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Kubernetes/ConfigMap =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ConfigMap.dhall

let Kubernetes/ObjectMeta =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall

let Configuration/global = ../../configuration/global.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let Util/DeploySourcegraphLabel = ../../util/deploy-sourcegraph-label.dhall

let render =
      λ(c : Configuration/global.Type) →
        let overrides = c.Postgres.ConfigMap

        let additionalAnnotations =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalAnnotations

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalLabels

        let configMap =
              Kubernetes/ConfigMap::{
              , data = Some
                [ { mapKey = "postgresql.conf"
                  , mapValue = ./postgresql.conf as Text
                  }
                ]
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some
                    (   [ { mapKey = "description"
                          , mapValue = "Configuration for PostgreSQL"
                          }
                        ]
                      # additionalAnnotations
                    )
                , labels = Some
                    (   Util/DeploySourcegraphLabel
                      # [ { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "no-cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "pgsql-conf"
                }
              }

        in  configMap

in  render
