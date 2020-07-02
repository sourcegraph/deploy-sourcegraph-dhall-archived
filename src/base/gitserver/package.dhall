let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Kubernetes/Container =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.Container.dhall

let Kubernetes/ContainerPort =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ContainerPort.dhall

let Kubernetes/IntOrString =
      ../../deps/k8s/types/io.k8s.apimachinery.pkg.util.intstr.IntOrString.dhall

let Kubernetes/LabelSelector =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall

let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/ObjectMeta =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall

let Kubernetes/PersistentVolumeClaim =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PersistentVolumeClaim.dhall

let Kubernetes/PersistentVolumeClaimSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PersistentVolumeClaimSpec.dhall

let Kubernetes/PodSecurityContext =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PodSecurityContext.dhall

let Kubernetes/PodSpec = ../../deps/k8s/schemas/io.k8s.api.core.v1.PodSpec.dhall

let Kubernetes/PodTemplateSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PodTemplateSpec.dhall

let Kubernetes/Probe = ../../deps/k8s/schemas/io.k8s.api.core.v1.Probe.dhall

let Kubernetes/ResourceRequirements =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ResourceRequirements.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let Kubernetes/ServicePort =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServicePort.dhall

let Kubernetes/ServiceSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceSpec.dhall

let Kubernetes/StatefulSet =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.StatefulSet.dhall

let Kubernetes/StatefulSetSpec =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.StatefulSetSpec.dhall

let Kubernetes/TCPSocketAction =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.TCPSocketAction.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let Kubernetes/Volume = ../../deps/k8s/schemas/io.k8s.api.core.v1.Volume.dhall

let Kubernetes/VolumeMount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.VolumeMount.dhall

let Configuration/global = ../../configuration/global.dhall

let Util/JaegerAgent = ../../util/jaeger-agent.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let component = ./component.dhall

let Service/generate =
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

let gitserverContainer/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Gitserver.StatefulSet.Containers.Gitserver

        let environment = overrides.additionalEnvironmentVariables

        let image =
              Optional/default
                Text
                "index.docker.io/sourcegraph/gitserver:3.16.1@sha256:1e81230b978a60d91ba2e557fe2e2cb30518d9d043763312db08e52c814aeb2c"
                overrides.image

        let resources =
              Optional/default
                Kubernetes/ResourceRequirements.Type
                { limits = Some
                  [ { mapKey = "cpu", mapValue = "4" }
                  , { mapKey = "memory", mapValue = "8G" }
                  ]
                , requests = Some
                  [ { mapKey = "cpu", mapValue = "4" }
                  , { mapKey = "memory", mapValue = "8G" }
                  ]
                }
                overrides.resources

        let container =
              Kubernetes/Container::{
              , args = Some [ "run" ]
              , image = Some image
              , env = environment
              , livenessProbe = Some Kubernetes/Probe::{
                , initialDelaySeconds = Some 5
                , tcpSocket = Some Kubernetes/TCPSocketAction::{
                  , port = Kubernetes/IntOrString.String "rpc"
                  }
                , timeoutSeconds = Some 5
                }
              , name = "gitserver"
              , ports = Some
                [ Kubernetes/ContainerPort::{
                  , containerPort = 3178
                  , name = Some "rpc"
                  }
                ]
              , resources = Some resources
              , terminationMessagePolicy = Some "FallbackToLogsOnError"
              , volumeMounts = Some
                [ Kubernetes/VolumeMount::{
                  , mountPath = "/data/repos"
                  , name = "repos"
                  }
                ]
              }

        in  container

let StatefulSet/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Gitserver.StatefulSet

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

        let replicas = Optional/default Natural 1 overrides.replicas

        let gitserverContainer = gitserverContainer/generate c

        let statefulSet =
              Kubernetes/StatefulSet::{
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some
                    (   [ { mapKey = "description"
                          , mapValue =
                              "Stores clones of repositories to perform Git operations."
                          }
                        ]
                      # additionalAnnotations
                    )
                , labels = Some
                    (   [ { mapKey = "deploy", mapValue = "sourcegraph" }
                        , { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "no-cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "gitserver"
                }
              , spec = Some Kubernetes/StatefulSetSpec::{
                , replicas = Some replicas
                , revisionHistoryLimit = Some 10
                , selector = Kubernetes/LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "gitserver" } ]
                  }
                , serviceName = "gitserver"
                , template = Kubernetes/PodTemplateSpec::{
                  , metadata = Kubernetes/ObjectMeta::{
                    , labels = Some
                      [ { mapKey = "app", mapValue = "gitserver" }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      , { mapKey = "group", mapValue = "backend" }
                      , { mapKey = "type", mapValue = "gitserver" }
                      ]
                    }
                  , spec = Some Kubernetes/PodSpec::{
                    , containers = [ gitserverContainer, Util/JaegerAgent ]
                    , schedulerName = None Text
                    , securityContext = Some Kubernetes/PodSecurityContext::{
                      , runAsUser = Some 0
                      }
                    , volumes = Some [ Kubernetes/Volume::{ name = "repos" } ]
                    }
                  }
                , updateStrategy = Some
                  { rollingUpdate = None { partition : Optional Natural }
                  , type = Some "RollingUpdate"
                  }
                , volumeClaimTemplates = Some
                  [ Kubernetes/PersistentVolumeClaim::{
                    , metadata = Kubernetes/ObjectMeta::{ name = Some "repos" }
                    , spec = Some Kubernetes/PersistentVolumeClaimSpec::{
                      , accessModes = Some [ "ReadWriteOnce" ]
                      , resources = Some Kubernetes/ResourceRequirements::{
                        , requests = Some
                          [ { mapKey = "storage", mapValue = "200Gi" } ]
                        }
                      , storageClassName = Some "sourcegraph"
                      }
                    }
                  ]
                }
              }

        in  statefulSet

let Generate =
        ( λ(c : Configuration/global.Type) →
            { StatefulSet = StatefulSet/generate c
            , Service = Service/generate c
            }
        )
      : ∀(c : Configuration/global.Type) → component

let ToList =
        ( λ(c : component) →
            Kubernetes/List::{
            , items =
              [ Kubernetes/TypesUnion.StatefulSet c.StatefulSet
              , Kubernetes/TypesUnion.Service c.Service
              ]
            }
        )
      : ∀(c : component) → Kubernetes/List.Type

let Render =
        (λ(c : Configuration/global.Type) → ToList (Generate c))
      : ∀(c : Configuration/global.Type) → Kubernetes/List.Type

in  { Render, Generate }
