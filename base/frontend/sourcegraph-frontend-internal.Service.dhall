let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Kubernetes/IntOrString =
      ../../deps/k8s/types/io.k8s.apimachinery.pkg.util.intstr.IntOrString.dhall

let Kubernetes/ObjectMeta =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let Kubernetes/ServicePort =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServicePort.dhall

let Kubernetes/ServiceSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceSpec.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let Configuration/global = ../../configuration/global.dhall

let render =
      λ(c : Configuration/global.Type) →
        let overrides = c.Frontend.ServiceInternal

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                c.Frontend.ServiceInternal.additionalLabels

        let serviceInternal =
              Kubernetes/Service::{
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = overrides.additionalAnnotations
                , labels = Some
                    (   [ { mapKey = "app", mapValue = "sourcegraph-frontend" }
                        , { mapKey = "deploy", mapValue = "sourcegraph" }
                        , { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "no-cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "sourcegraph-frontend-internal"
                }
              , spec = Some Kubernetes/ServiceSpec::{
                , ports = Some
                  [ Kubernetes/ServicePort::{
                    , name = Some "http-internal"
                    , port = 80
                    , targetPort = Some
                        (Kubernetes/IntOrString.String "http-internal")
                    }
                  ]
                , selector = Some
                  [ { mapKey = "app", mapValue = "sourcegraph-frontend" } ]
                , type = Some "ClusterIP"
                }
              }

        in  serviceInternal

in  render
