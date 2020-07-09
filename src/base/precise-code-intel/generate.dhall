let Kubernetes = ../../deps/k8s/schemas.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let BundleManager/PersistentVolumeClaim/generate =
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
                , name = Some "bundle-manager"
                }
              , spec = Some Kubernetes.PersistentVolumeClaimSpec::{
                , accessModes = Some [ "ReadWriteOnce" ]
                , resources = Some Kubernetes.ResourceRequirements::{
                  , requests = Some
                    [ { mapKey = "storage", mapValue = "200Gi" } ]
                  }
                , storageClassName = Some "sourcegraph"
                }
              }

        in  persistentVolumeClaim

let BundleManager/Service/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes.Service::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "prometheus.io/port", mapValue = "6060" }
                  , { mapKey = "sourcegraph.prometheus/scrape"
                    , mapValue = "true"
                    }
                  ]
                , labels = Some
                  [ { mapKey = "app"
                    , mapValue = "precise-code-intel-bundle-manager"
                    }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "precise-code-intel-bundle-manager"
                }
              , spec = Some Kubernetes.ServiceSpec::{
                , ports = Some
                  [ Kubernetes.ServicePort::{
                    , name = Some "http"
                    , port = 3187
                    , targetPort = Some
                        (< Int : Natural | String : Text >.String "http")
                    }
                  , Kubernetes.ServicePort::{
                    , name = Some "debug"
                    , port = 6060
                    , targetPort = Some
                        (< Int : Natural | String : Text >.String "debug")
                    }
                  ]
                , selector = Some
                  [ { mapKey = "app"
                    , mapValue = "precise-code-intel-bundle-manager"
                    }
                  ]
                , type = Some "ClusterIP"
                }
              }

        in  service

let BundleManager/Deployment/generate =
      λ(c : Configuration/global.Type) →
        let deployment =
              Kubernetes.Deployment::{
              , metadata = Kubernetes.ObjectMeta::{
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
              , spec = Some Kubernetes.DeploymentSpec::{
                , minReadySeconds = Some 10
                , replicas = Some 1
                , revisionHistoryLimit = Some 10
                , selector = Kubernetes.LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app"
                      , mapValue = "precise-code-intel-bundle-manager"
                      }
                    ]
                  }
                , strategy = Some Kubernetes.DeploymentStrategy::{
                  , type = Some "Recreate"
                  }
                , template = Kubernetes.PodTemplateSpec::{
                  , metadata = Kubernetes.ObjectMeta::{
                    , labels = Some
                      [ { mapKey = "app"
                        , mapValue = "precise-code-intel-bundle-manager"
                        }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      ]
                    }
                  , spec = Some Kubernetes.PodSpec::{
                    , containers =
                      [ Kubernetes.Container::{
                        , env = Some
                          [ Kubernetes.EnvVar::{
                            , name = "PRECISE_CODE_INTEL_BUNDLE_DIR"
                            , value = Some "/lsif-storage"
                            }
                          , Kubernetes.EnvVar::{
                            , name = "POD_NAME"
                            , valueFrom = Some Kubernetes.EnvVarSource::{
                              , fieldRef = Some Kubernetes.ObjectFieldSelector::{
                                , fieldPath = "metadata.name"
                                }
                              }
                            }
                          ]
                        , image = Some
                            "index.docker.io/sourcegraph/precise-code-intel-bundle-manager:3.17.2@sha256:7dff0e7e8c7a3451ce12cf5eb5e4073bb9502752926acf33f13eb370dc570cc8"
                        , livenessProbe = Some Kubernetes.Probe::{
                          , httpGet = Some Kubernetes.HTTPGetAction::{
                            , path = Some "/healthz"
                            , port =
                                < Int : Natural | String : Text >.String "http"
                            , scheme = Some "HTTP"
                            }
                          , initialDelaySeconds = Some 60
                          , timeoutSeconds = Some 5
                          }
                        , name = "precise-code-intel-bundle-manager"
                        , ports = Some
                          [ Kubernetes.ContainerPort::{
                            , containerPort = 3187
                            , name = Some "http"
                            }
                          , Kubernetes.ContainerPort::{
                            , containerPort = 6060
                            , name = Some "debug"
                            }
                          ]
                        , readinessProbe = Some Kubernetes.Probe::{
                          , httpGet = Some Kubernetes.HTTPGetAction::{
                            , path = Some "/healthz"
                            , port =
                                < Int : Natural | String : Text >.String "http"
                            , scheme = Some "HTTP"
                            }
                          , periodSeconds = Some 5
                          , timeoutSeconds = Some 5
                          }
                        , resources = Some Kubernetes.ResourceRequirements::{
                          , limits = Some
                            [ { mapKey = "cpu", mapValue = "2" }
                            , { mapKey = "memory", mapValue = "2G" }
                            ]
                          , requests = Some
                            [ { mapKey = "cpu", mapValue = "500m" }
                            , { mapKey = "memory", mapValue = "500M" }
                            ]
                          }
                        , terminationMessagePolicy = Some
                            "FallbackToLogsOnError"
                        , volumeMounts = Some
                          [ Kubernetes.VolumeMount::{
                            , mountPath = "/lsif-storage"
                            , name = "bundle-manager"
                            }
                          ]
                        }
                      ]
                    , securityContext = Some Kubernetes.PodSecurityContext::{
                      , runAsUser = Some 0
                      }
                    , volumes = Some
                      [ Kubernetes.Volume::{
                        , name = "bundle-manager"
                        , persistentVolumeClaim = Some Kubernetes.PersistentVolumeClaimVolumeSource::{
                          , claimName = "bundle-manager"
                          }
                        }
                      ]
                    }
                  }
                }
              }

        in  deployment

let Worker/Service/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes.Service::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "prometheus.io/port", mapValue = "6060" }
                  , { mapKey = "sourcegraph.prometheus/scrape"
                    , mapValue = "true"
                    }
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
              , spec = Some Kubernetes.ServiceSpec::{
                , ports = Some
                  [ Kubernetes.ServicePort::{
                    , name = Some "http"
                    , port = 3188
                    , targetPort = Some
                        (< Int : Natural | String : Text >.String "http")
                    }
                  , Kubernetes.ServicePort::{
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

        in  service

let Worker/Deployment/generate =
      λ(c : Configuration/global.Type) →
        let deployment =
              Kubernetes.Deployment::{
              , metadata = Kubernetes.ObjectMeta::{
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
              , spec = Some Kubernetes.DeploymentSpec::{
                , minReadySeconds = Some 10
                , replicas = Some 1
                , revisionHistoryLimit = Some 10
                , selector = Kubernetes.LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "precise-code-intel-worker" }
                    ]
                  }
                , strategy = Some Kubernetes.DeploymentStrategy::{
                  , rollingUpdate = Some Kubernetes.RollingUpdateDeployment::{
                    , maxSurge = Some (< Int : Natural | String : Text >.Int 1)
                    , maxUnavailable = Some
                        (< Int : Natural | String : Text >.Int 1)
                    }
                  , type = Some "RollingUpdate"
                  }
                , template = Kubernetes.PodTemplateSpec::{
                  , metadata = Kubernetes.ObjectMeta::{
                    , labels = Some
                      [ { mapKey = "app"
                        , mapValue = "precise-code-intel-worker"
                        }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      ]
                    }
                  , spec = Some Kubernetes.PodSpec::{
                    , containers =
                      [ Kubernetes.Container::{
                        , env = Some
                          [ Kubernetes.EnvVar::{
                            , name = "NUM_WORKERS"
                            , value = Some "4"
                            }
                          , Kubernetes.EnvVar::{
                            , name = "PRECISE_CODE_INTEL_BUNDLE_MANAGER_URL"
                            , value = Some
                                "http://precise-code-intel-bundle-manager:3187"
                            }
                          , Kubernetes.EnvVar::{
                            , name = "POD_NAME"
                            , valueFrom = Some Kubernetes.EnvVarSource::{
                              , fieldRef = Some Kubernetes.ObjectFieldSelector::{
                                , fieldPath = "metadata.name"
                                }
                              }
                            }
                          ]
                        , image = Some
                            "index.docker.io/sourcegraph/precise-code-intel-worker:3.17.2@sha256:123ddcab97c273599b569a76bcd2c7dd7c423c1de816fda1c35b781e004b4dde"
                        , livenessProbe = Some Kubernetes.Probe::{
                          , httpGet = Some Kubernetes.HTTPGetAction::{
                            , path = Some "/healthz"
                            , port =
                                < Int : Natural | String : Text >.String "http"
                            , scheme = Some "HTTP"
                            }
                          , initialDelaySeconds = Some 60
                          , timeoutSeconds = Some 5
                          }
                        , name = "precise-code-intel-worker"
                        , ports = Some
                          [ Kubernetes.ContainerPort::{
                            , containerPort = 3188
                            , name = Some "http"
                            }
                          , Kubernetes.ContainerPort::{
                            , containerPort = 6060
                            , name = Some "debug"
                            }
                          ]
                        , readinessProbe = Some Kubernetes.Probe::{
                          , httpGet = Some Kubernetes.HTTPGetAction::{
                            , path = Some "/healthz"
                            , port =
                                < Int : Natural | String : Text >.String "http"
                            , scheme = Some "HTTP"
                            }
                          , periodSeconds = Some 5
                          , timeoutSeconds = Some 5
                          }
                        , resources = Some Kubernetes.ResourceRequirements::{
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
                        }
                      ]
                    , securityContext = Some Kubernetes.PodSecurityContext::{
                      , runAsUser = Some 0
                      }
                    }
                  }
                }
              }

        in  deployment

let Generate =
        ( λ(c : Configuration/global.Type) →
            { BundleManager =
              { Deployment = BundleManager/Deployment/generate c
              , PersistentVolumeClaim =
                  BundleManager/PersistentVolumeClaim/generate c
              , Service = BundleManager/Service/generate c
              }
            , Worker =
              { Deployment = Worker/Deployment/generate c
              , Service = Worker/Service/generate c
              }
            }
        )
      : ∀(c : Configuration/global.Type) → component

in  Generate
