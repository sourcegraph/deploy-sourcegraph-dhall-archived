let Kubernetes = ../../deps/k8s/schemas.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let Service/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes.Service::{
              , metadata = Kubernetes.ObjectMeta::{
                , labels = Some
                  [ { mapKey = "app", mapValue = "syntect-server" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "syntect-server"
                }
              , spec = Some Kubernetes.ServiceSpec::{
                , ports = Some
                  [ Kubernetes.ServicePort::{
                    , name = Some "http"
                    , port = 9238
                    , targetPort = Some
                        (< Int : Natural | String : Text >.String "http")
                    }
                  ]
                , selector = Some
                  [ { mapKey = "app", mapValue = "syntect-server" } ]
                , type = Some "ClusterIP"
                }
              }

        in  service

let Deployment/generate =
      λ(c : Configuration/global.Type) →
        let deployment =
              Kubernetes.Deployment::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "description"
                    , mapValue = "Backend for syntax highlighting operations."
                    }
                  ]
                , labels = Some
                  [ { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "syntect-server"
                }
              , spec = Some Kubernetes.DeploymentSpec::{
                , minReadySeconds = Some 10
                , replicas = Some 1
                , revisionHistoryLimit = Some 10
                , selector = Kubernetes.LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "syntect-server" } ]
                  }
                , strategy = Some Kubernetes.DeploymentStrategy::{
                  , rollingUpdate = Some Kubernetes.RollingUpdateDeployment::{
                    , maxSurge = Some (< Int : Natural | String : Text >.Int 1)
                    , maxUnavailable = Some
                        (< Int : Natural | String : Text >.Int 0)
                    }
                  , type = Some "RollingUpdate"
                  }
                , template = Kubernetes.PodTemplateSpec::{
                  , metadata = Kubernetes.ObjectMeta::{
                    , labels = Some
                      [ { mapKey = "app", mapValue = "syntect-server" }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      ]
                    }
                  , spec = Some Kubernetes.PodSpec::{
                    , containers =
                      [ Kubernetes.Container::{
                        , image = Some
                            "index.docker.io/sourcegraph/syntax-highlighter:3.17.2@sha256:aa93514b7bc3aaf7a4e9c92e5ff52ee5052db6fb101255a69f054e5b8cdb46ff"
                        , livenessProbe = Some Kubernetes.Probe::{
                          , httpGet = Some Kubernetes.HTTPGetAction::{
                            , path = Some "/health"
                            , port =
                                < Int : Natural | String : Text >.String "http"
                            , scheme = Some "HTTP"
                            }
                          , initialDelaySeconds = Some 5
                          , timeoutSeconds = Some 5
                          }
                        , name = "syntect-server"
                        , ports = Some
                          [ Kubernetes.ContainerPort::{
                            , containerPort = 9238
                            , name = Some "http"
                            }
                          ]
                        , readinessProbe = Some Kubernetes.Probe::{
                          , tcpSocket = Some Kubernetes.TCPSocketAction::{
                            , port =
                                < Int : Natural | String : Text >.String "http"
                            }
                          }
                        , resources = Some Kubernetes.ResourceRequirements::{
                          , limits = Some
                            [ { mapKey = "cpu", mapValue = "4" }
                            , { mapKey = "memory", mapValue = "6G" }
                            ]
                          , requests = Some
                            [ { mapKey = "cpu", mapValue = "250m" }
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
            { Deployment = Deployment/generate c, Service = Service/generate c }
        )
      : ∀(c : Configuration/global.Type) → component

in  Generate
