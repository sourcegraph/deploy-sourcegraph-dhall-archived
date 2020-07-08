let schemas = ../../deps/k8s/schemas.dhall

in  { Service = schemas.Service::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "description"
            , mapValue =
                "Headless service that provides a stable network identity for the gitserver stateful set."
            }
          , { mapKey = "prometheus.io/port", mapValue = "6060" }
          , { mapKey = "sourcegraph.prometheus/scrape", mapValue = "true" }
          ]
        , labels = Some
          [ { mapKey = "app", mapValue = "gitserver" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          , { mapKey = "type", mapValue = "gitserver" }
          ]
        , name = Some "gitserver"
        }
      , spec = Some schemas.ServiceSpec::{
        , clusterIP = Some "None"
        , ports = Some
          [ schemas.ServicePort::{
            , name = Some "unused"
            , port = 10811
            , targetPort = Some (< Int : Natural | String : Text >.Int 10811)
            }
          ]
        , selector = Some
          [ { mapKey = "app", mapValue = "gitserver" }
          , { mapKey = "type", mapValue = "gitserver" }
          ]
        , type = Some "ClusterIP"
        }
      }
    , StatefulSet = schemas.StatefulSet::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "description"
            , mapValue =
                "Stores clones of repositories to perform Git operations."
            }
          ]
        , labels = Some
          [ { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "gitserver"
        }
      , spec = Some schemas.StatefulSetSpec::{
        , replicas = Some 1
        , revisionHistoryLimit = Some 10
        , selector = schemas.LabelSelector::{
          , matchLabels = Some [ { mapKey = "app", mapValue = "gitserver" } ]
          }
        , serviceName = "gitserver"
        , template = schemas.PodTemplateSpec::{
          , metadata = schemas.ObjectMeta::{
            , labels = Some
              [ { mapKey = "app", mapValue = "gitserver" }
              , { mapKey = "deploy", mapValue = "sourcegraph" }
              , { mapKey = "group", mapValue = "backend" }
              , { mapKey = "type", mapValue = "gitserver" }
              ]
            }
          , spec = Some schemas.PodSpec::{
            , containers =
              [ schemas.Container::{
                , args = Some [ "run" ]
                , image = Some
                    "index.docker.io/sourcegraph/gitserver:3.17.2@sha256:a2dac3ed8c9bbd7f930ae8d2bb446878f43f326002774fd85647945a90535733"
                , livenessProbe = Some schemas.Probe::{
                  , initialDelaySeconds = Some 5
                  , tcpSocket = Some schemas.TCPSocketAction::{
                    , port = < Int : Natural | String : Text >.String "rpc"
                    }
                  , timeoutSeconds = Some 5
                  }
                , name = "gitserver"
                , ports = Some
                  [ schemas.ContainerPort::{
                    , containerPort = 3178
                    , name = Some "rpc"
                    }
                  ]
                , resources = Some schemas.ResourceRequirements::{
                  , limits = Some
                    [ { mapKey = "cpu", mapValue = "4" }
                    , { mapKey = "memory", mapValue = "8G" }
                    ]
                  , requests = Some
                    [ { mapKey = "cpu", mapValue = "4" }
                    , { mapKey = "memory", mapValue = "8G" }
                    ]
                  }
                , terminationMessagePolicy = Some "FallbackToLogsOnError"
                , volumeMounts = Some
                  [ schemas.VolumeMount::{
                    , mountPath = "/data/repos"
                    , name = "repos"
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
            , volumes = Some [ schemas.Volume::{ name = "repos" } ]
            }
          }
        , updateStrategy = Some schemas.StatefulSetUpdateStrategy::{
          , type = Some "RollingUpdate"
          }
        , volumeClaimTemplates = Some
          [ schemas.PersistentVolumeClaim::{
            , metadata = schemas.ObjectMeta::{ name = Some "repos" }
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
