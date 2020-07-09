let Kubernetes = ../../deps/k8s/schemas.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let Service/Query/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes.Service::{
              , metadata = Kubernetes.ObjectMeta::{
                , labels = Some
                  [ { mapKey = "app", mapValue = "jaeger" }
                  , { mapKey = "app.kubernetes.io/component"
                    , mapValue = "query"
                    }
                  , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "jaeger-query"
                }
              , spec = Some Kubernetes.ServiceSpec::{
                , ports = Some
                  [ Kubernetes.ServicePort::{
                    , name = Some "query-http"
                    , port = 16686
                    , protocol = Some "TCP"
                    , targetPort = Some
                        (< Int : Natural | String : Text >.Int 16686)
                    }
                  ]
                , selector = Some
                  [ { mapKey = "app.kubernetes.io/component"
                    , mapValue = "all-in-one"
                    }
                  , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
                  ]
                , type = Some "ClusterIP"
                }
              }

        in  service

let Service/Collector/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes.Service::{
              , metadata = Kubernetes.ObjectMeta::{
                , labels = Some
                  [ { mapKey = "app", mapValue = "jaeger" }
                  , { mapKey = "app.kubernetes.io/component"
                    , mapValue = "collector"
                    }
                  , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "jaeger-collector"
                }
              , spec = Some Kubernetes.ServiceSpec::{
                , ports = Some
                  [ Kubernetes.ServicePort::{
                    , name = Some "jaeger-collector-tchannel"
                    , port = 14267
                    , protocol = Some "TCP"
                    , targetPort = Some
                        (< Int : Natural | String : Text >.Int 14267)
                    }
                  , Kubernetes.ServicePort::{
                    , name = Some "jaeger-collector-http"
                    , port = 14268
                    , protocol = Some "TCP"
                    , targetPort = Some
                        (< Int : Natural | String : Text >.Int 14268)
                    }
                  , Kubernetes.ServicePort::{
                    , name = Some "jaeger-collector-grpc"
                    , port = 14250
                    , protocol = Some "TCP"
                    , targetPort = Some
                        (< Int : Natural | String : Text >.Int 14250)
                    }
                  ]
                , selector = Some
                  [ { mapKey = "app.kubernetes.io/component"
                    , mapValue = "all-in-one"
                    }
                  , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
                  ]
                , type = Some "ClusterIP"
                }
              }

        in  service

let Deployment/generate =
      λ(c : Configuration/global.Type) →
        let deployment =
              Kubernetes.Deployment::{
              , metadata = Kubernetes.ObjectMeta::{
                , labels = Some
                  [ { mapKey = "app", mapValue = "jaeger" }
                  , { mapKey = "app.kubernetes.io/component"
                    , mapValue = "all-in-one"
                    }
                  , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "jaeger"
                }
              , spec = Some Kubernetes.DeploymentSpec::{
                , replicas = Some 1
                , selector = Kubernetes.LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "jaeger" }
                    , { mapKey = "app.kubernetes.io/component"
                      , mapValue = "all-in-one"
                      }
                    , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
                    ]
                  }
                , strategy = Some Kubernetes.DeploymentStrategy::{
                  , type = Some "Recreate"
                  }
                , template = Kubernetes.PodTemplateSpec::{
                  , metadata = Kubernetes.ObjectMeta::{
                    , annotations = Some
                      [ { mapKey = "prometheus.io/port", mapValue = "16686" }
                      , { mapKey = "prometheus.io/scrape", mapValue = "true" }
                      ]
                    , labels = Some
                      [ { mapKey = "app", mapValue = "jaeger" }
                      , { mapKey = "app.kubernetes.io/component"
                        , mapValue = "all-in-one"
                        }
                      , { mapKey = "app.kubernetes.io/name"
                        , mapValue = "jaeger"
                        }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      ]
                    }
                  , spec = Some Kubernetes.PodSpec::{
                    , containers =
                      [ Kubernetes.Container::{
                        , args = Some [ "--memory.max-traces=20000" ]
                        , image = Some
                            "index.docker.io/sourcegraph/jaeger-all-in-one:3.17.2@sha256:3d885a0dd4dd7b3abd5aebe4baa2a854230178dacf00de5664b57c895f2015fa"
                        , name = "jaeger"
                        , ports = Some
                          [ Kubernetes.ContainerPort::{
                            , containerPort = 5775
                            , protocol = Some "UDP"
                            }
                          , Kubernetes.ContainerPort::{
                            , containerPort = 6831
                            , protocol = Some "UDP"
                            }
                          , Kubernetes.ContainerPort::{
                            , containerPort = 6832
                            , protocol = Some "UDP"
                            }
                          , Kubernetes.ContainerPort::{
                            , containerPort = 5778
                            , protocol = Some "TCP"
                            }
                          , Kubernetes.ContainerPort::{
                            , containerPort = 16686
                            , protocol = Some "TCP"
                            }
                          , Kubernetes.ContainerPort::{
                            , containerPort = 14250
                            , protocol = Some "TCP"
                            }
                          ]
                        , readinessProbe = Some Kubernetes.Probe::{
                          , httpGet = Some Kubernetes.HTTPGetAction::{
                            , path = Some "/"
                            , port = < Int : Natural | String : Text >.Int 14269
                            }
                          , initialDelaySeconds = Some 5
                          }
                        , resources = Some Kubernetes.ResourceRequirements::{
                          , limits = Some
                            [ { mapKey = "cpu", mapValue = "1" }
                            , { mapKey = "memory", mapValue = "1G" }
                            ]
                          , requests = Some
                            [ { mapKey = "cpu", mapValue = "500m" }
                            , { mapKey = "memory", mapValue = "500M" }
                            ]
                          }
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
            { Deployment = Deployment/generate c
            , Collector = Service/Collector/generate c
            , Query = Service/Query/generate c
            }
        )
      : ∀(c : Configuration/global.Type) → component

in  Generate
