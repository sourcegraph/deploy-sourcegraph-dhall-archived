let schemas = ../../deps/k8s/schemas.dhall

in  { Deployment = schemas.Deployment::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "description"
            , mapValue = "Saved search query runner / notification service."
            }
          ]
        , labels = Some
          [ { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "query-runner"
        }
      , spec = Some schemas.DeploymentSpec::{
        , minReadySeconds = Some 10
        , replicas = Some 1
        , revisionHistoryLimit = Some 10
        , selector = schemas.LabelSelector::{
          , matchLabels = Some [ { mapKey = "app", mapValue = "query-runner" } ]
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
              [ { mapKey = "app", mapValue = "query-runner" }
              , { mapKey = "deploy", mapValue = "sourcegraph" }
              ]
            }
          , spec = Some schemas.PodSpec::{
            , containers =
              [ schemas.Container::{
                , image = Some
                    "index.docker.io/sourcegraph/query-runner:3.17.2@sha256:73f1a1116fe12c8384c57f081bb4af50e7000e3589bcc04224c5bfb20f404afd"
                , name = "query-runner"
                , ports = Some
                  [ schemas.ContainerPort::{
                    , containerPort = 3183
                    , name = Some "http"
                    }
                  ]
                , resources = Some schemas.ResourceRequirements::{
                  , limits = Some
                    [ { mapKey = "cpu", mapValue = "1" }
                    , { mapKey = "memory", mapValue = "1G" }
                    ]
                  , requests = Some
                    [ { mapKey = "cpu", mapValue = "500m" }
                    , { mapKey = "memory", mapValue = "1G" }
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
          [ { mapKey = "app", mapValue = "query-runner" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "query-runner"
        }
      , spec = Some schemas.ServiceSpec::{
        , ports = Some
          [ schemas.ServicePort::{
            , name = Some "http"
            , port = 80
            , targetPort = Some
                (< Int : Natural | String : Text >.String "http")
            }
          ]
        , selector = Some [ { mapKey = "app", mapValue = "query-runner" } ]
        , type = Some "ClusterIP"
        }
      }
    }
