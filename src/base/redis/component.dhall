let Kubernetes/Deployment =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.Deployment.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let Kubernetes/PersistentVolumeClaim =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PersistentVolumeClaim.dhall

let component =
      { Cache :
          { Deployment : Kubernetes/Deployment.Type
          , Service : Kubernetes/Service.Type
          , PersistentVolumeClaim : Kubernetes/PersistentVolumeClaim.Type
          }
      , Store :
          { Deployment : Kubernetes/Deployment.Type
          , PersistentVolumeClaim : Kubernetes/PersistentVolumeClaim.Type
          , Service : Kubernetes/Service.Type
          }
      }

in  component
