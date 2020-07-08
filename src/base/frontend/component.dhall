let Kubernetes/Deployment =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.Deployment.dhall

let Kubernetes/Ingress =
      ../../deps/k8s/schemas/io.k8s.api.networking.v1beta1.Ingress.dhall

let Kubernetes/Role = ../../deps/k8s/schemas/io.k8s.api.rbac.v1.Role.dhall

let Kubernetes/RoleBinding =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.RoleBinding.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let Kubernetes/ServiceAccount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceAccount.dhall

let component =
      { Deployment : Kubernetes/Deployment.Type
      , Ingress : Kubernetes/Ingress.Type
      , Role : Kubernetes/Role.Type
      , RoleBinding : Kubernetes/RoleBinding.Type
      , Service : Kubernetes/Service.Type
      , ServiceAccount : Kubernetes/ServiceAccount.Type
      , ServiceInternal : Kubernetes/Service.Type
      }

in  component
