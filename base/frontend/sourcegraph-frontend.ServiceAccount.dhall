let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Kubernetes/ObjectMeta =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall

let Kubernetes/ServiceAccount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceAccount.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let Configuration/global = ../../configuration/global.dhall

let render =
      λ(c : Configuration/global.Type) →
        let overrides = c.Frontend.ServiceAccount

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalLabels

        let serviceAccount =
              Kubernetes/ServiceAccount::{
              , imagePullSecrets = Some [ { name = Some "docker-registry" } ]
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = overrides.additionalAnnotations
                , labels = Some
                    (   [ { mapKey = "category", mapValue = "rbac" }
                        , { mapKey = "deploy", mapValue = "sourcegraph" }
                        , { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "no-cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "sourcegraph-frontend"
                }
              }

        in  serviceAccount

in  render
