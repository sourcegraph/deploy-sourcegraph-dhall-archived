let Kubernetes/HTTPGetAction =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.HTTPGetAction.dhall

let Kubernetes/Container =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.Container.dhall

let Kubernetes/ContainerPort =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ContainerPort.dhall

let Kubernetes/LabelSelector =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall

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

let Kubernetes/StatefulSetUpdateStrategy =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.StatefulSetUpdateStrategy.dhall

let Kubernetes/Volume = ../../deps/k8s/schemas/io.k8s.api.core.v1.Volume.dhall

let Kubernetes/VolumeMount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.VolumeMount.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let IndexerService/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes/Service::{
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "description"
                    , mapValue =
                        "Headless service that provides a stable network identity for the indexed-search stateful set."
                    }
                  , { mapKey = "prometheus.io/port", mapValue = "6072" }
                  , { mapKey = "sourcegraph.prometheus/scrape"
                    , mapValue = "true"
                    }
                  ]
                , labels = Some
                  [ { mapKey = "app", mapValue = "indexed-search-indexer" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "indexed-search-indexer"
                }
              , spec = Some Kubernetes/ServiceSpec::{
                , clusterIP = Some "None"
                , ports = Some
                  [ Kubernetes/ServicePort::{
                    , port = 6072
                    , targetPort = Some
                        (< Int : Natural | String : Text >.Int 6072)
                    }
                  ]
                , selector = Some
                  [ { mapKey = "app", mapValue = "indexed-search" } ]
                , type = Some "ClusterIP"
                }
              }

        in  service

let Service/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes/Service::{
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "description"
                    , mapValue =
                        "Headless service that provides a stable network identity for the indexed-search stateful set."
                    }
                  , { mapKey = "prometheus.io/port", mapValue = "6070" }
                  , { mapKey = "sourcegraph.prometheus/scrape"
                    , mapValue = "true"
                    }
                  ]
                , labels = Some
                  [ { mapKey = "app", mapValue = "indexed-search" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "indexed-search"
                }
              , spec = Some Kubernetes/ServiceSpec::{
                , clusterIP = Some "None"
                , ports = Some [ Kubernetes/ServicePort::{ port = 6070 } ]
                , selector = Some
                  [ { mapKey = "app", mapValue = "indexed-search" } ]
                , type = Some "ClusterIP"
                }
              }

        in  service

let StatefulSet/generate =
      λ(c : Configuration/global.Type) →
        let statefulSet =
              Kubernetes/StatefulSet::{
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "description"
                    , mapValue = "Backend for indexed text search operations."
                    }
                  ]
                , labels = Some
                  [ { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "indexed-search"
                }
              , spec = Some Kubernetes/StatefulSetSpec::{
                , replicas = Some 1
                , revisionHistoryLimit = Some 10
                , selector = Kubernetes/LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "indexed-search" } ]
                  }
                , serviceName = "indexed-search"
                , template = Kubernetes/PodTemplateSpec::{
                  , metadata = Kubernetes/ObjectMeta::{
                    , labels = Some
                      [ { mapKey = "app", mapValue = "indexed-search" }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      ]
                    }
                  , spec = Some Kubernetes/PodSpec::{
                    , containers =
                      [ Kubernetes/Container::{
                        , image = Some
                            "index.docker.io/sourcegraph/indexed-searcher:3.17.2@sha256:8324943e1b52466dc2052cf82bfd22b18ad045346d2b0ea403b4674f48214602"
                        , name = "zoekt-webserver"
                        , ports = Some
                          [ Kubernetes/ContainerPort::{
                            , containerPort = 6070
                            , name = Some "http"
                            }
                          ]
                        , readinessProbe = Some Kubernetes/Probe::{
                          , failureThreshold = Some 1
                          , httpGet = Some Kubernetes/HTTPGetAction::{
                            , path = Some "/healthz"
                            , port =
                                < Int : Natural | String : Text >.String "http"
                            , scheme = Some "HTTP"
                            }
                          , periodSeconds = Some 1
                          }
                        , resources = Some Kubernetes/ResourceRequirements::{
                          , limits = Some
                            [ { mapKey = "cpu", mapValue = "2" }
                            , { mapKey = "memory", mapValue = "4G" }
                            ]
                          , requests = Some
                            [ { mapKey = "cpu", mapValue = "500m" }
                            , { mapKey = "memory", mapValue = "2G" }
                            ]
                          }
                        , terminationMessagePolicy = Some
                            "FallbackToLogsOnError"
                        , volumeMounts = Some
                          [ Kubernetes/VolumeMount::{
                            , mountPath = "/data"
                            , name = "data"
                            }
                          ]
                        }
                      , Kubernetes/Container::{
                        , image = Some
                            "index.docker.io/sourcegraph/search-indexer:3.17.2@sha256:f31ec682b907bde2975acda88ee99ac268ef32a79309a6036ef5f26e8af0dcac"
                        , name = "zoekt-indexserver"
                        , ports = Some
                          [ Kubernetes/ContainerPort::{
                            , containerPort = 6072
                            , name = Some "index-http"
                            }
                          ]
                        , resources = Some Kubernetes/ResourceRequirements::{
                          , limits = Some
                            [ { mapKey = "cpu", mapValue = "8" }
                            , { mapKey = "memory", mapValue = "8G" }
                            ]
                          , requests = Some
                            [ { mapKey = "cpu", mapValue = "4" }
                            , { mapKey = "memory", mapValue = "4G" }
                            ]
                          }
                        , terminationMessagePolicy = Some
                            "FallbackToLogsOnError"
                        , volumeMounts = Some
                          [ Kubernetes/VolumeMount::{
                            , mountPath = "/data"
                            , name = "data"
                            }
                          ]
                        }
                      ]
                    , securityContext = Some Kubernetes/PodSecurityContext::{
                      , runAsUser = Some 0
                      }
                    , volumes = Some [ Kubernetes/Volume::{ name = "data" } ]
                    }
                  }
                , updateStrategy = Some Kubernetes/StatefulSetUpdateStrategy::{
                  , type = Some "RollingUpdate"
                  }
                , volumeClaimTemplates = Some
                  [ Kubernetes/PersistentVolumeClaim::{
                    , metadata = Kubernetes/ObjectMeta::{
                      , labels = Some
                        [ { mapKey = "deploy", mapValue = "sourcegraph" } ]
                      , name = Some "data"
                      }
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
            , IndexerService = IndexerService/generate c
            }
        )
      : ∀(c : Configuration/global.Type) → component

in  Generate
