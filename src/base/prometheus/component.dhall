let Kubernetes/ServiceAccount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceAccount.dhall

let Kubernetes/ConfigMap =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ConfigMap.dhall

let Kubernetes/Deployment =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.Deployment.dhall

let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/PersistentVolumeClaim =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PersistentVolumeClaim.dhall

let Kubernetes/ClusterRole =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.ClusterRole.dhall

let Kubernetes/ClusterRoleBinding =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.ClusterRoleBinding.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let Configuration/global = ../../configuration/global.dhall

let component =
      { Deployment : Kubernetes/Deployment.Type
      , ClusterRole : Kubernetes/ClusterRole.Type
      , ConfigMap : Kubernetes/ConfigMap.Type
      , PersistentVolumeClaim : Kubernetes/PersistentVolumeClaim.Type
      , ClusterRoleBinding : Kubernetes/ClusterRoleBinding.Type
      , Service : Kubernetes/Service.Type
      , ServiceAccount : Kubernetes/ServiceAccount.Type
      }

in  component
