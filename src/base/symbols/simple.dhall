let schemas = ../../deps/k8s/schemas.dhall

in  { Deployment = schemas.Deployment::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "description"
            , mapValue = "Backend for symbols operations."
            }
          ]
        , labels = Some
          [ { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "symbols"
        }
      , spec = Some schemas.DeploymentSpec::{
        , minReadySeconds = Some 10
        , replicas = Some 1
        , revisionHistoryLimit = Some 10
        , selector = schemas.LabelSelector::{
          , matchLabels = Some [ { mapKey = "app", mapValue = "symbols" } ]
          }
        , strategy = Some schemas.DeploymentStrategy::{
          , rollingUpdate = Some schemas.RollingUpdateDeployment::{
            , maxSurge = Some (< Int : Natural | String : Text >.Int 1)
            , maxUnavailable = Some (< Int : Natural | String : Text >.Int 1)
            }
          , type = Some "RollingUpdate"
          }
        , template = schemas.PodTemplateSpec::{
          , metadata = schemas.ObjectMeta::{
            , labels = Some
              [ { mapKey = "app", mapValue = "symbols" }
              , { mapKey = "deploy", mapValue = "sourcegraph" }
              ]
            }
          , spec = Some schemas.PodSpec::{
            , containers =
              [ schemas.Container::{
                , env = Some
                  [ schemas.EnvVar::{
                    , name = "SYMBOLS_CACHE_SIZE_MB"
                    , value = Some "100000"
                    }
                  , schemas.EnvVar::{
                    , name = "POD_NAME"
                    , valueFrom = Some schemas.EnvVarSource::{
                      , fieldRef = Some schemas.ObjectFieldSelector::{
                        , fieldPath = "metadata.name"
                        }
                      }
                    }
                  , schemas.EnvVar::{
                    , name = "CACHE_DIR"
                    , value = Some "/mnt/cache/\$(POD_NAME)"
                    }
                  ]
                , image = Some
                    "index.docker.io/sourcegraph/symbols:3.17.2@sha256:224e167586f927c60faf345027452aa035eeb2d65dd6821607833d2669030e4f"
                , livenessProbe = Some schemas.Probe::{
                  , httpGet = Some schemas.HTTPGetAction::{
                    , path = Some "/healthz"
                    , port = < Int : Natural | String : Text >.String "http"
                    , scheme = Some "HTTP"
                    }
                  , initialDelaySeconds = Some 60
                  , timeoutSeconds = Some 5
                  }
                , name = "symbols"
                , ports = Some
                  [ schemas.ContainerPort::{
                    , containerPort = 3184
                    , name = Some "http"
                    }
                  , schemas.ContainerPort::{
                    , containerPort = 6060
                    , name = Some "debug"
                    }
                  ]
                , readinessProbe = Some schemas.Probe::{
                  , httpGet = Some schemas.HTTPGetAction::{
                    , path = Some "/healthz"
                    , port = < Int : Natural | String : Text >.String "http"
                    , scheme = Some "HTTP"
                    }
                  , periodSeconds = Some 5
                  , timeoutSeconds = Some 5
                  }
                , resources = Some schemas.ResourceRequirements::{
                  , limits = Some
                    [ { mapKey = "cpu", mapValue = "2" }
                    , { mapKey = "memory", mapValue = "2G" }
                    ]
                  , requests = Some
                    [ { mapKey = "cpu", mapValue = "500m" }
                    , { mapKey = "memory", mapValue = "500M" }
                    ]
                  }
                , terminationMessagePolicy = Some "FallbackToLogsOnError"
                , volumeMounts = Some
                  [ schemas.VolumeMount::{
                    , mountPath = "/mnt/cache"
                    , name = "cache-ssd"
                    }
                  ]
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
            , volumes = Some
              [ schemas.Volume::{
                , emptyDir = Some schemas.EmptyDirVolumeSource::{=}
                , name = "cache-ssd"
                }
              ]
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
          [ { mapKey = "app", mapValue = "symbols" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "symbols"
        }
      , spec = Some schemas.ServiceSpec::{
        , ports = Some
          [ schemas.ServicePort::{
            , name = Some "http"
            , port = 3184
            , targetPort = Some
                (< Int : Natural | String : Text >.String "http")
            }
          , schemas.ServicePort::{
            , name = Some "debug"
            , port = 6060
            , targetPort = Some
                (< Int : Natural | String : Text >.String "debug")
            }
          ]
        , selector = Some [ { mapKey = "app", mapValue = "symbols" } ]
        , type = Some "ClusterIP"
        }
      }
    }
