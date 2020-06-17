let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Kubernetes/ObjectMeta =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall

let Kubernetes/RoleBinding =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.RoleBinding.dhall

let Kubernetes/RoleRef = ../../deps/k8s/schemas/io.k8s.api.rbac.v1.RoleRef.dhall

let Kubernetes/Subject = ../../deps/k8s/schemas/io.k8s.api.rbac.v1.Subject.dhall

let Configuration/global = ../../configuration/global.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let render =
      λ(c : Configuration/global.Type) →
        let overrides = c.Frontend.RoleBinding

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalLabels

        let roleBinding =
              Kubernetes/RoleBinding::{
              , metadata = Kubernetes/ObjectMeta::{
                , labels = Some
                    (   [ { mapKey = "category", mapValue = "rbac" }
                        , { mapKey = "deploy", mapValue = "sourcegraph" }
                        , { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "sourcegraph-frontend"
                }
              , roleRef = Kubernetes/RoleRef::{
                , apiGroup = ""
                , kind = "Role"
                , name = "sourcegraph-frontend"
                }
              , subjects = Some
                [ Kubernetes/Subject::{
                  , kind = "ServiceAccount"
                  , name = "sourcegraph-frontend"
                  }
                ]
              }

        in  roleBinding

in  render
