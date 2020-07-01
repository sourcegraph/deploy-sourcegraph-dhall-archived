let Kubernetes/DaemonSet =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.DaemonSet.dhall

let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/PodSecurityPolicy =
      ../../deps/k8s/schemas/io.k8s.api.extensions.v1beta1.PodSecurityPolicy.dhall

let Kubernetes/ClusterRole =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.ClusterRole.dhall

let Kubernetes/ClusterRoleBinding =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.ClusterRoleBinding.dhall

let Kubernetes/RoleBinding =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.RoleBinding.dhall

let Kubernetes/ServiceAccount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceAccount.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let Configuration/global = ../../configuration/global.dhall

let component =
      { DaemonSet : Kubernetes/DaemonSet.Type
      , ClusterRole : Kubernetes/ClusterRole.Type
      , PodSecurityPolicy : Kubernetes/PodSecurityPolicy.Type
      , ClusterRoleBinding : Kubernetes/ClusterRoleBinding.Type
      , ServiceAccount : Kubernetes/ServiceAccount.Type
      }

in  component
