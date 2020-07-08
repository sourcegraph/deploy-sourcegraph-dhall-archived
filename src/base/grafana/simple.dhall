let schemas = ./src/deps/k8s/schemas.dhall

in  { ConfigMap = schemas.ConfigMap::{
      , data = Some
        [ { mapKey = "datasources.yml"
          , mapValue =
              ''
              apiVersion: 1

              datasources:
                  - name: Prometheus
                    type: prometheus
                    access: proxy
                    url: http://prometheus:30090
                    isDefault: true
                    editable: false
                  - name: Jaeger
                    type: Jaeger
                    access: proxy
                    url: http://jaeger-query:16686/-/debug/jaeger
              ''
          }
        ]
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "grafana"
        }
      }
    , Service = schemas.Service::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "app", mapValue = "grafana" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "grafana"
        }
      , spec = Some schemas.ServiceSpec::{
        , ports = Some
          [ schemas.ServicePort::{
            , name = Some "http"
            , port = 30070
            , targetPort = Some
                (< Int : Natural | String : Text >.String "http")
            }
          ]
        , selector = Some [ { mapKey = "app", mapValue = "grafana" } ]
        , type = Some "ClusterIP"
        }
      }
    , ServiceAccount = schemas.ServiceAccount::{
      , imagePullSecrets = Some
        [ schemas.LocalObjectReference::{ name = Some "docker-registry" } ]
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "category", mapValue = "rbac" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "grafana"
        }
      }
    , StatefulSet = schemas.StatefulSet::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "description"
            , mapValue = "Metrics/monitoring dashboards and alerts."
            }
          ]
        , labels = Some
          [ { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "grafana"
        }
      , spec = Some schemas.StatefulSetSpec::{
        , replicas = Some 1
        , revisionHistoryLimit = Some 10
        , selector = schemas.LabelSelector::{
          , matchLabels = Some [ { mapKey = "app", mapValue = "grafana" } ]
          }
        , serviceName = "grafana"
        , template = schemas.PodTemplateSpec::{
          , metadata = schemas.ObjectMeta::{
            , labels = Some
              [ { mapKey = "app", mapValue = "grafana" }
              , { mapKey = "deploy", mapValue = "sourcegraph" }
              ]
            }
          , spec = Some schemas.PodSpec::{
            , containers =
              [ schemas.Container::{
                , image = Some
                    "index.docker.io/sourcegraph/grafana:3.17.2@sha256:f390384e2f57f3aba4eae41e51340a541a5b7a82ee16bdcea3cd9520423f193a"
                , name = "grafana"
                , ports = Some
                  [ schemas.ContainerPort::{
                    , containerPort = 3370
                    , name = Some "http"
                    }
                  ]
                , resources = Some schemas.ResourceRequirements::{
                  , limits = Some
                    [ { mapKey = "cpu", mapValue = "1" }
                    , { mapKey = "memory", mapValue = "512Mi" }
                    ]
                  , requests = Some
                    [ { mapKey = "cpu", mapValue = "100m" }
                    , { mapKey = "memory", mapValue = "512Mi" }
                    ]
                  }
                , terminationMessagePolicy = Some "FallbackToLogsOnError"
                , volumeMounts = Some
                  [ schemas.VolumeMount::{
                    , mountPath = "/var/lib/grafana"
                    , name = "grafana-data"
                    }
                  , schemas.VolumeMount::{
                    , mountPath = "/sg_config_grafana/provisioning/datasources"
                    , name = "config"
                    }
                  ]
                }
              ]
            , securityContext = Some schemas.PodSecurityContext::{
              , runAsUser = Some 0
              }
            , serviceAccountName = Some "grafana"
            , volumes = Some
              [ schemas.Volume::{
                , configMap = Some schemas.ConfigMapVolumeSource::{
                  , defaultMode = Some 777
                  , name = Some "grafana"
                  }
                , name = "config"
                }
              ]
            }
          }
        , updateStrategy = Some schemas.StatefulSetUpdateStrategy::{
          , type = Some "RollingUpdate"
          }
        , volumeClaimTemplates = Some
          [ schemas.PersistentVolumeClaim::{
            , metadata = schemas.ObjectMeta::{ name = Some "grafana-data" }
            , spec = Some schemas.PersistentVolumeClaimSpec::{
              , accessModes = Some [ "ReadWriteOnce" ]
              , resources = Some schemas.ResourceRequirements::{
                , requests = Some [ { mapKey = "storage", mapValue = "2Gi" } ]
                }
              , storageClassName = Some "sourcegraph"
              }
            }
          ]
        }
      }
    }
