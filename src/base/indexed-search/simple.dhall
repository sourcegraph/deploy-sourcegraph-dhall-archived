let schemas = ./src/deps/k8s/schemas.dhall

in  { IndexerService = schemas.Service::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "description"
            , mapValue =
                "Headless service that provides a stable network identity for the indexed-search stateful set."
            }
          , { mapKey = "prometheus.io/port", mapValue = "6072" }
          , { mapKey = "sourcegraph.prometheus/scrape", mapValue = "true" }
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
      , spec = Some schemas.ServiceSpec::{
        , clusterIP = Some "None"
        , ports = Some
          [ schemas.ServicePort::{
            , port = 6072
            , targetPort = Some (< Int : Natural | String : Text >.Int 6072)
            }
          ]
        , selector = Some [ { mapKey = "app", mapValue = "indexed-search" } ]
        , type = Some "ClusterIP"
        }
      }
    , Service = schemas.Service::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "description"
            , mapValue =
                "Headless service that provides a stable network identity for the indexed-search stateful set."
            }
          , { mapKey = "prometheus.io/port", mapValue = "6070" }
          , { mapKey = "sourcegraph.prometheus/scrape", mapValue = "true" }
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
      , spec = Some schemas.ServiceSpec::{
        , clusterIP = Some "None"
        , ports = Some [ schemas.ServicePort::{ port = 6070 } ]
        , selector = Some [ { mapKey = "app", mapValue = "indexed-search" } ]
        , type = Some "ClusterIP"
        }
      }
    , StatefulSet = schemas.StatefulSet::{
      , metadata = schemas.ObjectMeta::{
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
      , spec = Some schemas.StatefulSetSpec::{
        , replicas = Some 1
        , revisionHistoryLimit = Some 10
        , selector = schemas.LabelSelector::{
          , matchLabels = Some
            [ { mapKey = "app", mapValue = "indexed-search" } ]
          }
        , serviceName = "indexed-search"
        , template = schemas.PodTemplateSpec::{
          , metadata = schemas.ObjectMeta::{
            , labels = Some
              [ { mapKey = "app", mapValue = "indexed-search" }
              , { mapKey = "deploy", mapValue = "sourcegraph" }
              ]
            }
          , spec = Some schemas.PodSpec::{
            , containers =
              [ schemas.Container::{
                , image = Some
                    "index.docker.io/sourcegraph/indexed-searcher:3.17.2@sha256:8324943e1b52466dc2052cf82bfd22b18ad045346d2b0ea403b4674f48214602"
                , name = "zoekt-webserver"
                , ports = Some
                  [ schemas.ContainerPort::{
                    , containerPort = 6070
                    , name = Some "http"
                    }
                  ]
                , readinessProbe = Some schemas.Probe::{
                  , failureThreshold = Some 1
                  , httpGet = Some schemas.HTTPGetAction::{
                    , path = Some "/healthz"
                    , port = < Int : Natural | String : Text >.String "http"
                    , scheme = Some "HTTP"
                    }
                  , periodSeconds = Some 1
                  }
                , resources = Some schemas.ResourceRequirements::{
                  , limits = Some
                    [ { mapKey = "cpu", mapValue = "2" }
                    , { mapKey = "memory", mapValue = "4G" }
                    ]
                  , requests = Some
                    [ { mapKey = "cpu", mapValue = "500m" }
                    , { mapKey = "memory", mapValue = "2G" }
                    ]
                  }
                , terminationMessagePolicy = Some "FallbackToLogsOnError"
                , volumeMounts = Some
                  [ schemas.VolumeMount::{ mountPath = "/data", name = "data" }
                  ]
                }
              , schemas.Container::{
                , image = Some
                    "index.docker.io/sourcegraph/search-indexer:3.17.2@sha256:f31ec682b907bde2975acda88ee99ac268ef32a79309a6036ef5f26e8af0dcac"
                , name = "zoekt-indexserver"
                , ports = Some
                  [ schemas.ContainerPort::{
                    , containerPort = 6072
                    , name = Some "index-http"
                    }
                  ]
                , resources = Some schemas.ResourceRequirements::{
                  , limits = Some
                    [ { mapKey = "cpu", mapValue = "8" }
                    , { mapKey = "memory", mapValue = "8G" }
                    ]
                  , requests = Some
                    [ { mapKey = "cpu", mapValue = "4" }
                    , { mapKey = "memory", mapValue = "4G" }
                    ]
                  }
                , terminationMessagePolicy = Some "FallbackToLogsOnError"
                , volumeMounts = Some
                  [ schemas.VolumeMount::{ mountPath = "/data", name = "data" }
                  ]
                }
              ]
            , securityContext = Some schemas.PodSecurityContext::{
              , runAsUser = Some 0
              }
            , volumes = Some [ schemas.Volume::{ name = "data" } ]
            }
          }
        , updateStrategy = Some schemas.StatefulSetUpdateStrategy::{
          , type = Some "RollingUpdate"
          }
        , volumeClaimTemplates = Some
          [ schemas.PersistentVolumeClaim::{
            , metadata = schemas.ObjectMeta::{
              , labels = Some
                [ { mapKey = "deploy", mapValue = "sourcegraph" } ]
              , name = Some "data"
              }
            , spec = Some schemas.PersistentVolumeClaimSpec::{
              , accessModes = Some [ "ReadWriteOnce" ]
              , resources = Some schemas.ResourceRequirements::{
                , requests = Some [ { mapKey = "storage", mapValue = "200Gi" } ]
                }
              , storageClassName = Some "sourcegraph"
              }
            }
          ]
        }
      }
    }
