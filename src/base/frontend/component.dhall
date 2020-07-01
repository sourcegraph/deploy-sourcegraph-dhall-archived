let Natural/enumerate =
      https://prelude.dhall-lang.org/v17.0.0/Natural/enumerate sha256:0cf083980a752b21ce0df9fc2222a4c139f50909e2353576e26a191002aa1ce3

let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Text/concatMapSep =
      https://prelude.dhall-lang.org/v17.0.0/Text/concatMapSep sha256:c272aca80a607bc5963d1fcb38819e7e0d3e72ac4d02b1183b1afb6a91340840

let Kubernetes/Container =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.Container.dhall

let Kubernetes/ContainerPort =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ContainerPort.dhall

let Kubernetes/Deployment =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.Deployment.dhall

let Kubernetes/DeploymentSpec =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.DeploymentSpec.dhall

let Kubernetes/DeploymentStrategy =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.DeploymentStrategy.dhall

let Kubernetes/EnvVar = ../../deps/k8s/schemas/io.k8s.api.core.v1.EnvVar.dhall

let Kubernetes/EnvVarSource =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.EnvVarSource.dhall

let Kubernetes/HTTPGetAction =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.HTTPGetAction.dhall

let Kubernetes/HTTPIngressPath =
      ../../deps/k8s/schemas/io.k8s.api.extensions.v1beta1.HTTPIngressPath.dhall

let Kubernetes/HTTPIngressRuleValue =
      ../../deps/k8s/schemas/io.k8s.api.extensions.v1beta1.HTTPIngressRuleValue.dhall

let Kubernetes/Ingress =
      ../../deps/k8s/schemas/io.k8s.api.networking.v1beta1.Ingress.dhall

let Kubernetes/IngressRule =
      ../../deps/k8s/schemas/io.k8s.api.networking.v1beta1.IngressRule.dhall

let Kubernetes/IngressSpec =
      ../../deps/k8s/schemas/io.k8s.api.networking.v1beta1.IngressSpec.dhall

let Kubernetes/IntOrString =
      ../../deps/k8s/types/io.k8s.apimachinery.pkg.util.intstr.IntOrString.dhall

let Kubernetes/LabelSelector =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall

let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/ObjectMeta =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall

let Kubernetes/PodSecurityContext =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PodSecurityContext.dhall

let Kubernetes/PodSpec = ../../deps/k8s/schemas/io.k8s.api.core.v1.PodSpec.dhall

let Kubernetes/PodTemplateSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PodTemplateSpec.dhall

let Kubernetes/PolicyRule =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.PolicyRule.dhall

let Kubernetes/Probe = ../../deps/k8s/schemas/io.k8s.api.core.v1.Probe.dhall

let Kubernetes/ResourceRequirements =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ResourceRequirements.dhall

let Kubernetes/Role = ../../deps/k8s/schemas/io.k8s.api.rbac.v1.Role.dhall

let Kubernetes/RoleBinding =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.RoleBinding.dhall

let Kubernetes/RoleRef = ../../deps/k8s/schemas/io.k8s.api.rbac.v1.RoleRef.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let Kubernetes/ServiceAccount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceAccount.dhall

let Kubernetes/ServicePort =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServicePort.dhall

let Kubernetes/ServiceSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceSpec.dhall

let Kubernetes/Subject = ../../deps/k8s/schemas/io.k8s.api.rbac.v1.Subject.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let Kubernetes/VolumeMount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.VolumeMount.dhall

let Configuration/global = ../../configuration/global.dhall

let Util/EmptyCacheSSDVolume = ../../util/empty-cache-ssd-volume.dhall

let Util/JaegerAgent = ../../util/jaeger-agent.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

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
