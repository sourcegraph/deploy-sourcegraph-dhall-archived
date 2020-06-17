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
        let overrides = c.Postgres.Service

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

        let annotations =
                toMap
                  { `sourcegraph.prometheus/scrape` = "true"
                  , `prometheus.io/port` = "9187"
                  }
              # additionalAnnotations

        let labels =
                toMap
                  { sourcegraph-resource-requires = "no-cluster-admin"
                  , deploy = "sourcegraph"
                  }
              # additionalLabels

        let service =
              Kubernetes/Service::{
              , apiVersion = "v1"
              , kind = "Service"
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some annotations
                , labels = Some labels
                , namespace = overrides.namespace
                , name = Some "pgsql"
                }
              , spec = Some Kubernetes/ServiceSpec::{
                , ports = Some
                  [ Kubernetes/ServicePort::{
                    , name = Some "pgsql"
                    , port = 5432
                    , targetPort = Some (Kubernetes/IntOrString.String "pgsql")
                    }
                  ]
                , selector = Some (toMap { app = "pgsql" })
                , type = Some "ClusterIP"
                }
              }

        in  service

in  render
