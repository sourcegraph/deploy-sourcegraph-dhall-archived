let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let Kubernetes/StatefulSet =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.StatefulSet.dhall

let component =
      { StatefulSet : Kubernetes/StatefulSet.Type
      , Service : Kubernetes/Service.Type
      , IndexerService : Kubernetes/Service.Type
      }

in  component
