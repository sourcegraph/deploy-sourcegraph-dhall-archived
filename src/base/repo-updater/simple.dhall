let schemas = ../../deps/k8s/schemas.dhall

in  { Deployment = schemas.Deployment::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "description"
            , mapValue =
                "Handles repository metadata (not Git data) lookups and updates from external code hosts and other similar services."
            }
          ]
        , labels = Some
          [ { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "repo-updater"
        }
      , spec = Some schemas.DeploymentSpec::{
        , minReadySeconds = Some 10
        , replicas = Some 1
        , revisionHistoryLimit = Some 10
        , selector = schemas.LabelSelector::{
          , matchLabels = Some [ { mapKey = "app", mapValue = "repo-updater" } ]
          }
        , strategy = Some schemas.DeploymentStrategy::{
          , rollingUpdate = Some schemas.RollingUpdateDeployment::{
            , maxSurge = Some (< Int : Natural | String : Text >.Int 1)
            , maxUnavailable = Some (< Int : Natural | String : Text >.Int 0)
            }
          , type = Some "RollingUpdate"
          }
        , template = schemas.PodTemplateSpec::{
          , metadata = schemas.ObjectMeta::{
            , labels = Some
              [ { mapKey = "app", mapValue = "repo-updater" }
              , { mapKey = "deploy", mapValue = "sourcegraph" }
              ]
            }
          , spec = Some schemas.PodSpec::{
            , containers =
              [ schemas.Container::{
                , image = Some
                    "index.docker.io/sourcegraph/repo-updater:3.17.2@sha256:1db6e1343e65a4bf8f6d0b524dcd722b1fbbe417227e6642b1de824de966ffc8"
                , name = "repo-updater"
                , ports = Some
                  [ schemas.ContainerPort::{
                    , containerPort = 3182
                    , name = Some "http"
                    }
                  , schemas.ContainerPort::{
                    , containerPort = 6060
                    , name = Some "debug"
                    }
                  ]
                , resources = Some schemas.ResourceRequirements::{
                  , limits = Some
                    [ { mapKey = "cpu", mapValue = "100m" }
                    , { mapKey = "memory", mapValue = "500Mi" }
                    ]
                  , requests = Some
                    [ { mapKey = "cpu", mapValue = "100m" }
                    , { mapKey = "memory", mapValue = "500Mi" }
                    ]
                  }
                , terminationMessagePolicy = Some "FallbackToLogsOnError"
                }
              , schemas.Container::{
                , args = Some
                  [ "--reporter.grpc.host-port=jaeger-collector:14250"
                  , "--reporter.type=grpc"
                  ]
                , env = Some
                  [ schemas.EnvVar::{
                    , name = "POD_NAME"
                    , valueFrom = Some schemas.EnvVarSource::{
                      , fieldRef = Some schemas.ObjectFieldSelector::{
                        , apiVersion = Some "v1"
                        , fieldPath = "metadata.name"
                        }
                      }
                    }
                  ]
                , image = Some
                    "index.docker.io/sourcegraph/jaeger-agent:3.17.2@sha256:a29258e098c7d23392411abd359563afdd89529e9852ce1ba73f80188a72fd5c"
                , name = "jaeger-agent"
                , ports = Some
                  [ schemas.ContainerPort::{
                    , containerPort = 5775
                    , protocol = Some "UDP"
                    }
                  , schemas.ContainerPort::{
                    , containerPort = 5778
                    , protocol = Some "TCP"
                    }
                  , schemas.ContainerPort::{
                    , containerPort = 6831
                    , protocol = Some "UDP"
                    }
                  , schemas.ContainerPort::{
                    , containerPort = 6832
                    , protocol = Some "UDP"
                    }
                  ]
                , resources = Some schemas.ResourceRequirements::{
                  , limits = Some
                    [ { mapKey = "cpu", mapValue = "1" }
                    , { mapKey = "memory", mapValue = "500M" }
                    ]
                  , requests = Some
                    [ { mapKey = "cpu", mapValue = "100m" }
                    , { mapKey = "memory", mapValue = "100M" }
                    ]
                  }
                }
              ]
            , securityContext = Some schemas.PodSecurityContext::{
              , runAsUser = Some 0
              }
            }
          }
        }
      }
    , Service = schemas.Service::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "prometheus.io/port", mapValue = "6060" }
          , { mapKey = "sourcegraph.prometheus/scrape", mapValue = "true" }
          ]
        , labels = Some
          [ { mapKey = "app", mapValue = "repo-updater" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "repo-updater"
        }
      , spec = Some schemas.ServiceSpec::{
        , ports = Some
          [ schemas.ServicePort::{
            , name = Some "http"
            , port = 3182
            , targetPort = Some
                (< Int : Natural | String : Text >.String "http")
            }
          ]
        , selector = Some [ { mapKey = "app", mapValue = "repo-updater" } ]
        , type = Some "ClusterIP"
        }
      }
    }
