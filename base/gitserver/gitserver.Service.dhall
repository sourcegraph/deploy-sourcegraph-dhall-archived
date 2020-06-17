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

let Configuration/global = ../../configuration/global.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let render =
      λ(c : Configuration/global.Type) →
        let overrides = c.Gitserver.Service

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

        let service =
              Kubernetes/Service::{
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some
                    (   toMap
                          { `sourcegraph.prometheus/scrape` = "true"
                          , `prometheus.io/port` = "6060"
                          , description =
                              "Headless service that provides a stable network identity for the gitserver stateful set."
                          }
                      # additionalAnnotations
                    )
                , labels = Some
                    (   toMap
                          { sourcegraph-resource-requires = "no-cluster-admin"
                          , app = "gitserver"
                          , type = "gitserver"
                          , deploy = "sourcegraph"
                          }
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "gitserver"
                }
              , spec = Some Kubernetes/ServiceSpec::{
                , clusterIP = Some "None"
                , ports = Some
                  [ Kubernetes/ServicePort::{
                    , name = Some "unused"
                    , port = 10811
                    , targetPort = Some (Kubernetes/IntOrString.Int 10811)
                    }
                  ]
                , selector = Some
                  [ { mapKey = "app", mapValue = "gitserver" }
                  , { mapKey = "type", mapValue = "gitserver" }
                  ]
                , type = Some "ClusterIP"
                }
              }

        in  service

in  render
