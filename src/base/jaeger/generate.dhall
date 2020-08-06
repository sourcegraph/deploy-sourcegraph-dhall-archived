let Kubernetes/Container =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.Container.dhall

let Kubernetes/ContainerPort =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ContainerPort.dhall

let Kubernetes/Deployment =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.Deployment.dhall

let Kubernetes/DeploymentSpec =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.DeploymentSpec.dhall

let Kubernetes/DeploymentStrategy =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.DeploymentStrategy.dhall

let Kubernetes/HTTPGetAction =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.HTTPGetAction.dhall

let Kubernetes/LabelSelector =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall

let Kubernetes/ObjectMeta =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall

let Kubernetes/PodSecurityContext =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PodSecurityContext.dhall

let Kubernetes/PodSpec = ../../deps/k8s/schemas/io.k8s.api.core.v1.PodSpec.dhall

let Kubernetes/PodTemplateSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PodTemplateSpec.dhall

let Kubernetes/Probe = ../../deps/k8s/schemas/io.k8s.api.core.v1.Probe.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let Kubernetes/ServicePort =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServicePort.dhall

let Kubernetes/ServiceSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceSpec.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let containerResources = ../../configuration/container-resources.dhall

let containerResources/tok8s = ../../util/container-resources-to-k8s.dhall

let Service/Query/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes/Service::{
              , metadata = Kubernetes/ObjectMeta::{
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
              , spec = Some Kubernetes/ServiceSpec::{
                , ports = Some
                  [ Kubernetes/ServicePort::{
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
              Kubernetes/Service::{
              , metadata = Kubernetes/ObjectMeta::{
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
              , spec = Some Kubernetes/ServiceSpec::{
                , ports = Some
                  [ Kubernetes/ServicePort::{
                    , name = Some "jaeger-collector-tchannel"
                    , port = 14267
                    , protocol = Some "TCP"
                    , targetPort = Some
                        (< Int : Natural | String : Text >.Int 14267)
                    }
                  , Kubernetes/ServicePort::{
                    , name = Some "jaeger-collector-http"
                    , port = 14268
                    , protocol = Some "TCP"
                    , targetPort = Some
                        (< Int : Natural | String : Text >.Int 14268)
                    }
                  , Kubernetes/ServicePort::{
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
        let overrides = c.Jaeger.Deployment.Containers.JaegerAllInOne

        let resources =
              containerResources/tok8s
                { limits =
                    containerResources.overlay
                      containerResources.Configuration::{
                      , cpu = Some "1"
                      , memory = Some "1G"
                      }
                      overrides.resources.limits
                , requests =
                    containerResources.overlay
                      containerResources.Configuration::{
                      , cpu = Some "500m"
                      , memory = Some "500M"
                      }
                      overrides.resources.requests
                }

        let deployment =
              Kubernetes/Deployment::{
              , metadata = Kubernetes/ObjectMeta::{
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
              , spec = Some Kubernetes/DeploymentSpec::{
                , replicas = Some 1
                , selector = Kubernetes/LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "jaeger" }
                    , { mapKey = "app.kubernetes.io/component"
                      , mapValue = "all-in-one"
                      }
                    , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
                    ]
                  }
                , strategy = Some Kubernetes/DeploymentStrategy::{
                  , type = Some "Recreate"
                  }
                , template = Kubernetes/PodTemplateSpec::{
                  , metadata = Kubernetes/ObjectMeta::{
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
                  , spec = Some Kubernetes/PodSpec::{
                    , containers =
                      [ Kubernetes/Container::{
                        , args = Some [ "--memory.max-traces=20000" ]
                        , image = Some
                            "index.docker.io/sourcegraph/jaeger-all-in-one:3.17.2@sha256:3d885a0dd4dd7b3abd5aebe4baa2a854230178dacf00de5664b57c895f2015fa"
                        , name = "jaeger"
                        , ports = Some
                          [ Kubernetes/ContainerPort::{
                            , containerPort = 5775
                            , protocol = Some "UDP"
                            }
                          , Kubernetes/ContainerPort::{
                            , containerPort = 6831
                            , protocol = Some "UDP"
                            }
                          , Kubernetes/ContainerPort::{
                            , containerPort = 6832
                            , protocol = Some "UDP"
                            }
                          , Kubernetes/ContainerPort::{
                            , containerPort = 5778
                            , protocol = Some "TCP"
                            }
                          , Kubernetes/ContainerPort::{
                            , containerPort = 16686
                            , protocol = Some "TCP"
                            }
                          , Kubernetes/ContainerPort::{
                            , containerPort = 14250
                            , protocol = Some "TCP"
                            }
                          ]
                        , readinessProbe = Some Kubernetes/Probe::{
                          , httpGet = Some Kubernetes/HTTPGetAction::{
                            , path = Some "/"
                            , port = < Int : Natural | String : Text >.Int 14269
                            }
                          , initialDelaySeconds = Some 5
                          }
                        , resources = Some resources
                        }
                      ]
                    , securityContext = Some Kubernetes/PodSecurityContext::{
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
