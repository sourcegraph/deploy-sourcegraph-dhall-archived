let Kubernetes = ../../deps/k8s/schemas.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let Cache/PersistentVolumeClaim/generate =
      λ(c : Configuration/global.Type) →
        let persistentVolumeClaim =
              Kubernetes.PersistentVolumeClaim::{
              , metadata = Kubernetes.ObjectMeta::{
                , labels = Some
                  [ { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "redis-cache"
                }
              , spec = Some Kubernetes.PersistentVolumeClaimSpec::{
                , accessModes = Some [ "ReadWriteOnce" ]
                , resources = Some Kubernetes.ResourceRequirements::{
                  , requests = Some
                    [ { mapKey = "storage", mapValue = "100Gi" } ]
                  }
                , storageClassName = Some "sourcegraph"
                }
              }

        in  persistentVolumeClaim

let Cache/Service/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes.Service::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "prometheus.io/port", mapValue = "9121" }
                  , { mapKey = "sourcegraph.prometheus/scrape"
                    , mapValue = "true"
                    }
                  ]
                , labels = Some
                  [ { mapKey = "app", mapValue = "redis-cache" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "redis-cache"
                }
              , spec = Some Kubernetes.ServiceSpec::{
                , ports = Some
                  [ Kubernetes.ServicePort::{
                    , name = Some "redis"
                    , port = 6379
                    , targetPort = Some
                        (< Int : Natural | String : Text >.String "redis")
                    }
                  ]
                , selector = Some
                  [ { mapKey = "app", mapValue = "redis-cache" } ]
                , type = Some "ClusterIP"
                }
              }

        in  service

let Cache/Deployment/generate =
      λ(c : Configuration/global.Type) →
        let deployment =
              Kubernetes.Deployment::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "description"
                    , mapValue = "Redis for storing short-lived caches."
                    }
                  ]
                , labels = Some
                  [ { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "redis-cache"
                }
              , spec = Some Kubernetes.DeploymentSpec::{
                , minReadySeconds = Some 10
                , replicas = Some 1
                , revisionHistoryLimit = Some 10
                , selector = Kubernetes.LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "redis-cache" } ]
                  }
                , strategy = Some Kubernetes.DeploymentStrategy::{
                  , type = Some "Recreate"
                  }
                , template = Kubernetes.PodTemplateSpec::{
                  , metadata = Kubernetes.ObjectMeta::{
                    , labels = Some
                      [ { mapKey = "app", mapValue = "redis-cache" }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      ]
                    }
                  , spec = Some Kubernetes.PodSpec::{
                    , containers =
                      [ Kubernetes.Container::{
                        , image = Some
                            "index.docker.io/sourcegraph/redis-cache:3.17.2@sha256:7820219195ab3e8fdae5875cd690fed1b2a01fd1063bd94210c0e9d529c38e56"
                        , livenessProbe = Some Kubernetes.Probe::{
                          , initialDelaySeconds = Some 30
                          , tcpSocket = Some Kubernetes.TCPSocketAction::{
                            , port =
                                < Int : Natural | String : Text >.String "redis"
                            }
                          }
                        , name = "redis-cache"
                        , ports = Some
                          [ Kubernetes.ContainerPort::{
                            , containerPort = 6379
                            , name = Some "redis"
                            }
                          ]
                        , readinessProbe = Some Kubernetes.Probe::{
                          , initialDelaySeconds = Some 5
                          , tcpSocket = Some Kubernetes.TCPSocketAction::{
                            , port =
                                < Int : Natural | String : Text >.String "redis"
                            }
                          }
                        , resources = Some Kubernetes.ResourceRequirements::{
                          , limits = Some
                            [ { mapKey = "cpu", mapValue = "1" }
                            , { mapKey = "memory", mapValue = "6Gi" }
                            ]
                          , requests = Some
                            [ { mapKey = "cpu", mapValue = "1" }
                            , { mapKey = "memory", mapValue = "6Gi" }
                            ]
                          }
                        , terminationMessagePolicy = Some
                            "FallbackToLogsOnError"
                        , volumeMounts = Some
                          [ Kubernetes.VolumeMount::{
                            , mountPath = "/redis-data"
                            , name = "redis-data"
                            }
                          ]
                        }
                      , Kubernetes.Container::{
                        , image = Some
                            "index.docker.io/sourcegraph/redis_exporter:18-02-07_bb60087_v0.15.0@sha256:282d59b2692cca68da128a4e28d368ced3d17945cd1d273d3ee7ba719d77b753"
                        , name = "redis-exporter"
                        , ports = Some
                          [ Kubernetes.ContainerPort::{
                            , containerPort = 9121
                            , name = Some "redisexp"
                            }
                          ]
                        , resources = Some Kubernetes.ResourceRequirements::{
                          , limits = Some
                            [ { mapKey = "cpu", mapValue = "10m" }
                            , { mapKey = "memory", mapValue = "100Mi" }
                            ]
                          , requests = Some
                            [ { mapKey = "cpu", mapValue = "10m" }
                            , { mapKey = "memory", mapValue = "100Mi" }
                            ]
                          }
                        , terminationMessagePolicy = Some
                            "FallbackToLogsOnError"
                        }
                      ]
                    , securityContext = Some Kubernetes.PodSecurityContext::{
                      , runAsUser = Some 0
                      }
                    , volumes = Some
                      [ Kubernetes.Volume::{
                        , name = "redis-data"
                        , persistentVolumeClaim = Some Kubernetes.PersistentVolumeClaimVolumeSource::{
                          , claimName = "redis-cache"
                          }
                        }
                      ]
                    }
                  }
                }
              }

        in  deployment

let Store/PersistentVolumeClaim/generate =
      λ(c : Configuration/global.Type) →
        let persistentVolumeClaim =
              Kubernetes.PersistentVolumeClaim::{
              , metadata = Kubernetes.ObjectMeta::{
                , labels = Some
                  [ { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "redis-store"
                }
              , spec = Some Kubernetes.PersistentVolumeClaimSpec::{
                , accessModes = Some [ "ReadWriteOnce" ]
                , resources = Some Kubernetes.ResourceRequirements::{
                  , requests = Some
                    [ { mapKey = "storage", mapValue = "100Gi" } ]
                  }
                , storageClassName = Some "sourcegraph"
                }
              }

        in  persistentVolumeClaim

let Store/Service/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes.Service::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "prometheus.io/port", mapValue = "9121" }
                  , { mapKey = "sourcegraph.prometheus/scrape"
                    , mapValue = "true"
                    }
                  ]
                , labels = Some
                  [ { mapKey = "app", mapValue = "redis-store" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "redis-store"
                }
              , spec = Some Kubernetes.ServiceSpec::{
                , ports = Some
                  [ Kubernetes.ServicePort::{
                    , name = Some "redis"
                    , port = 6379
                    , targetPort = Some
                        (< Int : Natural | String : Text >.String "redis")
                    }
                  ]
                , selector = Some
                  [ { mapKey = "app", mapValue = "redis-store" } ]
                , type = Some "ClusterIP"
                }
              }

        in  service

let Store/Deployment/generate =
      λ(c : Configuration/global.Type) →
        let deployment =
              Kubernetes.Deployment::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "description"
                    , mapValue =
                        "Redis for storing semi-persistent data like user sessions."
                    }
                  ]
                , labels = Some
                  [ { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "redis-store"
                }
              , spec = Some Kubernetes.DeploymentSpec::{
                , minReadySeconds = Some 10
                , replicas = Some 1
                , revisionHistoryLimit = Some 10
                , selector = Kubernetes.LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "redis-store" } ]
                  }
                , strategy = Some Kubernetes.DeploymentStrategy::{
                  , type = Some "Recreate"
                  }
                , template = Kubernetes.PodTemplateSpec::{
                  , metadata = Kubernetes.ObjectMeta::{
                    , labels = Some
                      [ { mapKey = "app", mapValue = "redis-store" }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      ]
                    }
                  , spec = Some Kubernetes.PodSpec::{
                    , containers =
                      [ Kubernetes.Container::{
                        , image = Some
                            "index.docker.io/sourcegraph/redis-store:3.17.2@sha256:e8467a8279832207559bdfbc4a89b68916ecd5b44ab5cf7620c995461c005168"
                        , livenessProbe = Some Kubernetes.Probe::{
                          , initialDelaySeconds = Some 30
                          , tcpSocket = Some Kubernetes.TCPSocketAction::{
                            , port =
                                < Int : Natural | String : Text >.String "redis"
                            }
                          }
                        , name = "redis-store"
                        , ports = Some
                          [ Kubernetes.ContainerPort::{
                            , containerPort = 6379
                            , name = Some "redis"
                            }
                          ]
                        , readinessProbe = Some Kubernetes.Probe::{
                          , initialDelaySeconds = Some 5
                          , tcpSocket = Some Kubernetes.TCPSocketAction::{
                            , port =
                                < Int : Natural | String : Text >.String "redis"
                            }
                          }
                        , resources = Some Kubernetes.ResourceRequirements::{
                          , limits = Some
                            [ { mapKey = "cpu", mapValue = "1" }
                            , { mapKey = "memory", mapValue = "6Gi" }
                            ]
                          , requests = Some
                            [ { mapKey = "cpu", mapValue = "1" }
                            , { mapKey = "memory", mapValue = "6Gi" }
                            ]
                          }
                        , terminationMessagePolicy = Some
                            "FallbackToLogsOnError"
                        , volumeMounts = Some
                          [ Kubernetes.VolumeMount::{
                            , mountPath = "/redis-data"
                            , name = "redis-data"
                            }
                          ]
                        }
                      , Kubernetes.Container::{
                        , image = Some
                            "index.docker.io/sourcegraph/redis_exporter:18-02-07_bb60087_v0.15.0@sha256:282d59b2692cca68da128a4e28d368ced3d17945cd1d273d3ee7ba719d77b753"
                        , name = "redis-exporter"
                        , ports = Some
                          [ Kubernetes.ContainerPort::{
                            , containerPort = 9121
                            , name = Some "redisexp"
                            }
                          ]
                        , resources = Some Kubernetes.ResourceRequirements::{
                          , limits = Some
                            [ { mapKey = "cpu", mapValue = "10m" }
                            , { mapKey = "memory", mapValue = "100Mi" }
                            ]
                          , requests = Some
                            [ { mapKey = "cpu", mapValue = "10m" }
                            , { mapKey = "memory", mapValue = "100Mi" }
                            ]
                          }
                        , terminationMessagePolicy = Some
                            "FallbackToLogsOnError"
                        }
                      ]
                    , securityContext = Some Kubernetes.PodSecurityContext::{
                      , runAsUser = Some 0
                      }
                    , volumes = Some
                      [ Kubernetes.Volume::{
                        , name = "redis-data"
                        , persistentVolumeClaim = Some Kubernetes.PersistentVolumeClaimVolumeSource::{
                          , claimName = "redis-store"
                          }
                        }
                      ]
                    }
                  }
                }
              }

        in  deployment

let Generate =
        ( λ(c : Configuration/global.Type) →
            { Cache =
              { Deployment = Cache/Deployment/generate c
              , PersistentVolumeClaim = Cache/PersistentVolumeClaim/generate c
              , Service = Cache/Service/generate c
              }
            , Store =
              { Deployment = Store/Deployment/generate c
              , PersistentVolumeClaim = Store/PersistentVolumeClaim/generate c
              , Service = Store/Service/generate c
              }
            }
        )
      : ∀(c : Configuration/global.Type) → component

in  Generate
