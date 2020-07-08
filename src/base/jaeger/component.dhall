let Kubernetes/Deployment =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.Deployment.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let component =
      { Deployment : Kubernetes/Deployment.Type
      , Collector : Kubernetes/Service.Type
      , Query : Kubernetes/Service.Type
      }

in  component
