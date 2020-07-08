let schemas = ../../deps/k8s/schemas.dhall

in  { BundleManager =
      { Deployment = schemas.Deployment::{
        , metadata = schemas.ObjectMeta::{
          , annotations = Some
            [ { mapKey = "description"
              , mapValue =
                  "Stores and manages precise code intelligence bundles."
              }
            ]
          , labels = Some
            [ { mapKey = "deploy", mapValue = "sourcegraph" }
            , { mapKey = "sourcegraph-resource-requires"
              , mapValue = "no-cluster-admin"
              }
            ]
          , name = Some "precise-code-intel-bundle-manager"
          }
        , spec = Some schemas.DeploymentSpec::{
          , minReadySeconds = Some 10
          , replicas = Some 1
          , revisionHistoryLimit = Some 10
          , selector = schemas.LabelSelector::{
            , matchLabels = Some
              [ { mapKey = "app"
                , mapValue = "precise-code-intel-bundle-manager"
                }
              ]
            }
          , strategy = Some schemas.DeploymentStrategy::{
            , type = Some "Recreate"
            }
          , template = schemas.PodTemplateSpec::{
            , metadata = schemas.ObjectMeta::{
              , labels = Some
                [ { mapKey = "app"
                  , mapValue = "precise-code-intel-bundle-manager"
                  }
                , { mapKey = "deploy", mapValue = "sourcegraph" }
                ]
              }
            , spec = Some schemas.PodSpec::{
              , containers =
                [ schemas.Container::{
                  , env = Some
                    [ schemas.EnvVar::{
                      , name = "PRECISE_CODE_INTEL_BUNDLE_DIR"
                      , value = Some "/lsif-storage"
                      }
                    , schemas.EnvVar::{
                      , name = "POD_NAME"
                      , valueFrom = Some schemas.EnvVarSource::{
                        , fieldRef = Some schemas.ObjectFieldSelector::{
                          , fieldPath = "metadata.name"
                          }
                        }
                      }
                    ]
                  , image = Some
                      "index.docker.io/sourcegraph/precise-code-intel-bundle-manager:3.17.2@sha256:7dff0e7e8c7a3451ce12cf5eb5e4073bb9502752926acf33f13eb370dc570cc8"
                  , livenessProbe = Some schemas.Probe::{
                    , httpGet = Some schemas.HTTPGetAction::{
                      , path = Some "/healthz"
                      , port = < Int : Natural | String : Text >.String "http"
                      , scheme = Some "HTTP"
                      }
                    , initialDelaySeconds = Some 60
                    , timeoutSeconds = Some 5
                    }
                  , name = "precise-code-intel-bundle-manager"
                  , ports = Some
                    [ schemas.ContainerPort::{
                      , containerPort = 3187
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
                      , mountPath = "/lsif-storage"
                      , name = "bundle-manager"
                      }
                    ]
                  }
                ]
              , securityContext = Some schemas.PodSecurityContext::{
                , runAsUser = Some 0
                }
              , volumes = Some
                [ schemas.Volume::{
                  , name = "bundle-manager"
                  , persistentVolumeClaim = Some schemas.PersistentVolumeClaimVolumeSource::{
                    , claimName = "bundle-manager"
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
          , name = Some "bundle-manager"
          }
        , spec = Some schemas.PersistentVolumeClaimSpec::{
          , accessModes = Some [ "ReadWriteOnce" ]
          , resources = Some schemas.ResourceRequirements::{
            , requests = Some [ { mapKey = "storage", mapValue = "200Gi" } ]
            }
          , storageClassName = Some "sourcegraph"
          }
        }
      , Service = schemas.Service::{
        , metadata = schemas.ObjectMeta::{
          , annotations = Some
            [ { mapKey = "prometheus.io/port", mapValue = "6060" }
            , { mapKey = "sourcegraph.prometheus/scrape", mapValue = "true" }
            ]
          , labels = Some
            [ { mapKey = "app", mapValue = "precise-code-intel-bundle-manager" }
            , { mapKey = "deploy", mapValue = "sourcegraph" }
            , { mapKey = "sourcegraph-resource-requires"
              , mapValue = "no-cluster-admin"
              }
            ]
          , name = Some "precise-code-intel-bundle-manager"
          }
        , spec = Some schemas.ServiceSpec::{
          , ports = Some
            [ schemas.ServicePort::{
              , name = Some "http"
              , port = 3187
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
          , selector = Some
            [ { mapKey = "app", mapValue = "precise-code-intel-bundle-manager" }
            ]
          , type = Some "ClusterIP"
          }
        }
      }
    , Worker =
      { Deployment = schemas.Deployment::{
        , metadata = schemas.ObjectMeta::{
          , annotations = Some
            [ { mapKey = "description"
              , mapValue =
                  "Handles conversion of uploaded precise code intelligence bundles."
              }
            ]
          , labels = Some
            [ { mapKey = "deploy", mapValue = "sourcegraph" }
            , { mapKey = "sourcegraph-resource-requires"
              , mapValue = "no-cluster-admin"
              }
            ]
          , name = Some "precise-code-intel-worker"
          }
        , spec = Some schemas.DeploymentSpec::{
          , minReadySeconds = Some 10
          , replicas = Some 1
          , revisionHistoryLimit = Some 10
          , selector = schemas.LabelSelector::{
            , matchLabels = Some
              [ { mapKey = "app", mapValue = "precise-code-intel-worker" } ]
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
                [ { mapKey = "app", mapValue = "precise-code-intel-worker" }
                , { mapKey = "deploy", mapValue = "sourcegraph" }
                ]
              }
            , spec = Some schemas.PodSpec::{
              , containers =
                [ schemas.Container::{
                  , env = Some
                    [ schemas.EnvVar::{ name = "NUM_WORKERS", value = Some "4" }
                    , schemas.EnvVar::{
                      , name = "PRECISE_CODE_INTEL_BUNDLE_MANAGER_URL"
                      , value = Some
                          "http://precise-code-intel-bundle-manager:3187"
                      }
                    , schemas.EnvVar::{
                      , name = "POD_NAME"
                      , valueFrom = Some schemas.EnvVarSource::{
                        , fieldRef = Some schemas.ObjectFieldSelector::{
                          , fieldPath = "metadata.name"
                          }
                        }
                      }
                    ]
                  , image = Some
                      "index.docker.io/sourcegraph/precise-code-intel-worker:3.17.2@sha256:123ddcab97c273599b569a76bcd2c7dd7c423c1de816fda1c35b781e004b4dde"
                  , livenessProbe = Some schemas.Probe::{
                    , httpGet = Some schemas.HTTPGetAction::{
                      , path = Some "/healthz"
                      , port = < Int : Natural | String : Text >.String "http"
                      , scheme = Some "HTTP"
                      }
                    , initialDelaySeconds = Some 60
                    , timeoutSeconds = Some 5
                    }
                  , name = "precise-code-intel-worker"
                  , ports = Some
                    [ schemas.ContainerPort::{
                      , containerPort = 3188
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
                      , { mapKey = "memory", mapValue = "4G" }
                      ]
                    , requests = Some
                      [ { mapKey = "cpu", mapValue = "500m" }
                      , { mapKey = "memory", mapValue = "2G" }
                      ]
                    }
                  , terminationMessagePolicy = Some "FallbackToLogsOnError"
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
            [ { mapKey = "app", mapValue = "precise-code-intel-worker" }
            , { mapKey = "deploy", mapValue = "sourcegraph" }
            , { mapKey = "sourcegraph-resource-requires"
              , mapValue = "no-cluster-admin"
              }
            ]
          , name = Some "precise-code-intel-worker"
          }
        , spec = Some schemas.ServiceSpec::{
          , ports = Some
            [ schemas.ServicePort::{
              , name = Some "http"
              , port = 3188
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
          , selector = Some
            [ { mapKey = "app", mapValue = "precise-code-intel-worker" } ]
          , type = Some "ClusterIP"
          }
        }
      }
    }
