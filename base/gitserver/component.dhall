let Kubernetes/StatefulSet =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.StatefulSet.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

in  { StatefulSet : Kubernetes/StatefulSet.Type
    , Service : Kubernetes/Service.Type
    }
