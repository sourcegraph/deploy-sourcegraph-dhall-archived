let schemas = ../../deps/k8s/schemas.dhall

in  { Cache =
      { Deployment = schemas.Deployment::{
        , metadata = schemas.ObjectMeta::{
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
        , spec = Some schemas.DeploymentSpec::{
          , minReadySeconds = Some 10
          , replicas = Some 1
          , revisionHistoryLimit = Some 10
          , selector = schemas.LabelSelector::{
            , matchLabels = Some
              [ { mapKey = "app", mapValue = "redis-cache" } ]
            }
          , strategy = Some schemas.DeploymentStrategy::{
            , type = Some "Recreate"
            }
          , template = schemas.PodTemplateSpec::{
            , metadata = schemas.ObjectMeta::{
              , labels = Some
                [ { mapKey = "app", mapValue = "redis-cache" }
                , { mapKey = "deploy", mapValue = "sourcegraph" }
                ]
              }
            , spec = Some schemas.PodSpec::{
              , containers =
                [ schemas.Container::{
                  , image = Some
                      "index.docker.io/sourcegraph/redis-cache:3.17.2@sha256:7820219195ab3e8fdae5875cd690fed1b2a01fd1063bd94210c0e9d529c38e56"
                  , livenessProbe = Some schemas.Probe::{
                    , initialDelaySeconds = Some 30
                    , tcpSocket = Some schemas.TCPSocketAction::{
                      , port = < Int : Natural | String : Text >.String "redis"
                      }
                    }
                  , name = "redis-cache"
                  , ports = Some
                    [ schemas.ContainerPort::{
                      , containerPort = 6379
                      , name = Some "redis"
                      }
                    ]
                  , readinessProbe = Some schemas.Probe::{
                    , initialDelaySeconds = Some 5
                    , tcpSocket = Some schemas.TCPSocketAction::{
                      , port = < Int : Natural | String : Text >.String "redis"
                      }
                    }
                  , resources = Some schemas.ResourceRequirements::{
                    , limits = Some
                      [ { mapKey = "cpu", mapValue = "1" }
                      , { mapKey = "memory", mapValue = "6Gi" }
                      ]
                    , requests = Some
                      [ { mapKey = "cpu", mapValue = "1" }
                      , { mapKey = "memory", mapValue = "6Gi" }
                      ]
                    }
                  , terminationMessagePolicy = Some "FallbackToLogsOnError"
                  , volumeMounts = Some
                    [ schemas.VolumeMount::{
                      , mountPath = "/redis-data"
                      , name = "redis-data"
                      }
                    ]
                  }
                , schemas.Container::{
                  , image = Some
                      "index.docker.io/sourcegraph/redis_exporter:18-02-07_bb60087_v0.15.0@sha256:282d59b2692cca68da128a4e28d368ced3d17945cd1d273d3ee7ba719d77b753"
                  , name = "redis-exporter"
                  , ports = Some
                    [ schemas.ContainerPort::{
                      , containerPort = 9121
                      , name = Some "redisexp"
                      }
                    ]
                  , resources = Some schemas.ResourceRequirements::{
                    , limits = Some
                      [ { mapKey = "cpu", mapValue = "10m" }
                      , { mapKey = "memory", mapValue = "100Mi" }
                      ]
                    , requests = Some
                      [ { mapKey = "cpu", mapValue = "10m" }
                      , { mapKey = "memory", mapValue = "100Mi" }
                      ]
                    }
                  , terminationMessagePolicy = Some "FallbackToLogsOnError"
                  }
                ]
              , securityContext = Some schemas.PodSecurityContext::{
                , runAsUser = Some 0
                }
              , volumes = Some
                [ schemas.Volume::{
                  , name = "redis-data"
                  , persistentVolumeClaim = Some schemas.PersistentVolumeClaimVolumeSource::{
                    , claimName = "redis-cache"
                    }
                  }
                ]
              }
            }
          }
        }
      , PersistentVolumeClaim = schemas.PersistentVolumeClaim::{
        , metadata = schemas.ObjectMeta::{
          , labels = Some
            [ { mapKey = "deploy", mapValue = "sourcegraph" }
            , { mapKey = "sourcegraph-resource-requires"
              , mapValue = "no-cluster-admin"
              }
            ]
          , name = Some "redis-cache"
          }
        , spec = Some schemas.PersistentVolumeClaimSpec::{
          , accessModes = Some [ "ReadWriteOnce" ]
          , resources = Some schemas.ResourceRequirements::{
            , requests = Some [ { mapKey = "storage", mapValue = "100Gi" } ]
            }
          , storageClassName = Some "sourcegraph"
          }
        }
      , Service = schemas.Service::{
        , metadata = schemas.ObjectMeta::{
          , annotations = Some
            [ { mapKey = "prometheus.io/port", mapValue = "9121" }
            , { mapKey = "sourcegraph.prometheus/scrape", mapValue = "true" }
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
        , spec = Some schemas.ServiceSpec::{
          , ports = Some
            [ schemas.ServicePort::{
              , name = Some "redis"
              , port = 6379
              , targetPort = Some
                  (< Int : Natural | String : Text >.String "redis")
              }
            ]
          , selector = Some [ { mapKey = "app", mapValue = "redis-cache" } ]
          , type = Some "ClusterIP"
          }
        }
      }
    , Store =
      { Deployment = schemas.Deployment::{
        , metadata = schemas.ObjectMeta::{
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
        , spec = Some schemas.DeploymentSpec::{
          , minReadySeconds = Some 10
          , replicas = Some 1
          , revisionHistoryLimit = Some 10
          , selector = schemas.LabelSelector::{
            , matchLabels = Some
              [ { mapKey = "app", mapValue = "redis-store" } ]
            }
          , strategy = Some schemas.DeploymentStrategy::{
            , type = Some "Recreate"
            }
          , template = schemas.PodTemplateSpec::{
            , metadata = schemas.ObjectMeta::{
              , labels = Some
                [ { mapKey = "app", mapValue = "redis-store" }
                , { mapKey = "deploy", mapValue = "sourcegraph" }
                ]
              }
            , spec = Some schemas.PodSpec::{
              , containers =
                [ schemas.Container::{
                  , image = Some
                      "index.docker.io/sourcegraph/redis-store:3.17.2@sha256:e8467a8279832207559bdfbc4a89b68916ecd5b44ab5cf7620c995461c005168"
                  , livenessProbe = Some schemas.Probe::{
                    , initialDelaySeconds = Some 30
                    , tcpSocket = Some schemas.TCPSocketAction::{
                      , port = < Int : Natural | String : Text >.String "redis"
                      }
                    }
                  , name = "redis-store"
                  , ports = Some
                    [ schemas.ContainerPort::{
                      , containerPort = 6379
                      , name = Some "redis"
                      }
                    ]
                  , readinessProbe = Some schemas.Probe::{
                    , initialDelaySeconds = Some 5
                    , tcpSocket = Some schemas.TCPSocketAction::{
                      , port = < Int : Natural | String : Text >.String "redis"
                      }
                    }
                  , resources = Some schemas.ResourceRequirements::{
                    , limits = Some
                      [ { mapKey = "cpu", mapValue = "1" }
                      , { mapKey = "memory", mapValue = "6Gi" }
                      ]
                    , requests = Some
                      [ { mapKey = "cpu", mapValue = "1" }
                      , { mapKey = "memory", mapValue = "6Gi" }
                      ]
                    }
                  , terminationMessagePolicy = Some "FallbackToLogsOnError"
                  , volumeMounts = Some
                    [ schemas.VolumeMount::{
                      , mountPath = "/redis-data"
                      , name = "redis-data"
                      }
                    ]
                  }
                , schemas.Container::{
                  , image = Some
                      "index.docker.io/sourcegraph/redis_exporter:18-02-07_bb60087_v0.15.0@sha256:282d59b2692cca68da128a4e28d368ced3d17945cd1d273d3ee7ba719d77b753"
                  , name = "redis-exporter"
                  , ports = Some
                    [ schemas.ContainerPort::{
                      , containerPort = 9121
                      , name = Some "redisexp"
                      }
                    ]
                  , resources = Some schemas.ResourceRequirements::{
                    , limits = Some
                      [ { mapKey = "cpu", mapValue = "10m" }
                      , { mapKey = "memory", mapValue = "100Mi" }
                      ]
                    , requests = Some
                      [ { mapKey = "cpu", mapValue = "10m" }
                      , { mapKey = "memory", mapValue = "100Mi" }
                      ]
                    }
                  , terminationMessagePolicy = Some "FallbackToLogsOnError"
                  }
                ]
              , securityContext = Some schemas.PodSecurityContext::{
                , runAsUser = Some 0
                }
              , volumes = Some
                [ schemas.Volume::{
                  , name = "redis-data"
                  , persistentVolumeClaim = Some schemas.PersistentVolumeClaimVolumeSource::{
                    , claimName = "redis-store"
                    }
                  }
                ]
              }
            }
          }
        }
      , PersistentVolumeClaim = schemas.PersistentVolumeClaim::{
        , metadata = schemas.ObjectMeta::{
          , labels = Some
            [ { mapKey = "deploy", mapValue = "sourcegraph" }
            , { mapKey = "sourcegraph-resource-requires"
              , mapValue = "no-cluster-admin"
              }
            ]
          , name = Some "redis-store"
          }
        , spec = Some schemas.PersistentVolumeClaimSpec::{
          , accessModes = Some [ "ReadWriteOnce" ]
          , resources = Some schemas.ResourceRequirements::{
            , requests = Some [ { mapKey = "storage", mapValue = "100Gi" } ]
            }
          , storageClassName = Some "sourcegraph"
          }
        }
      , Service = schemas.Service::{
        , metadata = schemas.ObjectMeta::{
          , annotations = Some
            [ { mapKey = "prometheus.io/port", mapValue = "9121" }
            , { mapKey = "sourcegraph.prometheus/scrape", mapValue = "true" }
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
        , spec = Some schemas.ServiceSpec::{
          , ports = Some
            [ schemas.ServicePort::{
              , name = Some "redis"
              , port = 6379
              , targetPort = Some
                  (< Int : Natural | String : Text >.String "redis")
              }
            ]
          , selector = Some [ { mapKey = "app", mapValue = "redis-store" } ]
          , type = Some "ClusterIP"
          }
        }
      }
    }
