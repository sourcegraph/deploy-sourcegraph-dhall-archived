let schemas = ../../deps/k8s/schemas.dhall

in  { Collector = schemas.Service::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "app", mapValue = "jaeger" }
          , { mapKey = "app.kubernetes.io/component", mapValue = "collector" }
          , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "jaeger-collector"
        }
      , spec = Some schemas.ServiceSpec::{
        , ports = Some
          [ schemas.ServicePort::{
            , name = Some "jaeger-collector-tchannel"
            , port = 14267
            , protocol = Some "TCP"
            , targetPort = Some (< Int : Natural | String : Text >.Int 14267)
            }
          , schemas.ServicePort::{
            , name = Some "jaeger-collector-http"
            , port = 14268
            , protocol = Some "TCP"
            , targetPort = Some (< Int : Natural | String : Text >.Int 14268)
            }
          , schemas.ServicePort::{
            , name = Some "jaeger-collector-grpc"
            , port = 14250
            , protocol = Some "TCP"
            , targetPort = Some (< Int : Natural | String : Text >.Int 14250)
            }
          ]
        , selector = Some
          [ { mapKey = "app.kubernetes.io/component", mapValue = "all-in-one" }
          , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
          ]
        , type = Some "ClusterIP"
        }
      }
    , Deployment = schemas.Deployment::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "app", mapValue = "jaeger" }
          , { mapKey = "app.kubernetes.io/component", mapValue = "all-in-one" }
          , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "jaeger"
        }
      , spec = Some schemas.DeploymentSpec::{
        , replicas = Some 1
        , selector = schemas.LabelSelector::{
          , matchLabels = Some
            [ { mapKey = "app", mapValue = "jaeger" }
            , { mapKey = "app.kubernetes.io/component"
              , mapValue = "all-in-one"
              }
            , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
            ]
          }
        , strategy = Some schemas.DeploymentStrategy::{ type = Some "Recreate" }
        , template = schemas.PodTemplateSpec::{
          , metadata = schemas.ObjectMeta::{
            , annotations = Some
              [ { mapKey = "prometheus.io/port", mapValue = "16686" }
              , { mapKey = "prometheus.io/scrape", mapValue = "true" }
              ]
            , labels = Some
              [ { mapKey = "app", mapValue = "jaeger" }
              , { mapKey = "app.kubernetes.io/component"
                , mapValue = "all-in-one"
                }
              , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
              , { mapKey = "deploy", mapValue = "sourcegraph" }
              ]
            }
          , spec = Some schemas.PodSpec::{
            , containers =
              [ schemas.Container::{
                , args = Some [ "--memory.max-traces=20000" ]
                , image = Some
                    "index.docker.io/sourcegraph/jaeger-all-in-one:3.17.2@sha256:3d885a0dd4dd7b3abd5aebe4baa2a854230178dacf00de5664b57c895f2015fa"
                , name = "jaeger"
                , ports = Some
                  [ schemas.ContainerPort::{
                    , containerPort = 5775
                    , protocol = Some "UDP"
                    }
                  , schemas.ContainerPort::{
                    , containerPort = 6831
                    , protocol = Some "UDP"
                    }
                  , schemas.ContainerPort::{
                    , containerPort = 6832
                    , protocol = Some "UDP"
                    }
                  , schemas.ContainerPort::{
                    , containerPort = 5778
                    , protocol = Some "TCP"
                    }
                  , schemas.ContainerPort::{
                    , containerPort = 16686
                    , protocol = Some "TCP"
                    }
                  , schemas.ContainerPort::{
                    , containerPort = 14250
                    , protocol = Some "TCP"
                    }
                  ]
                , readinessProbe = Some schemas.Probe::{
                  , httpGet = Some schemas.HTTPGetAction::{
                    , path = Some "/"
                    , port = < Int : Natural | String : Text >.Int 14269
                    }
                  , initialDelaySeconds = Some 5
                  }
                , resources = Some schemas.ResourceRequirements::{
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
            , securityContext = Some schemas.PodSecurityContext::{
              , runAsUser = Some 0
              }
            }
          }
        }
      }
    , Query = schemas.Service::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "app", mapValue = "jaeger" }
          , { mapKey = "app.kubernetes.io/component", mapValue = "query" }
          , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "jaeger-query"
        }
      , spec = Some schemas.ServiceSpec::{
        , ports = Some
          [ schemas.ServicePort::{
            , name = Some "query-http"
            , port = 16686
            , protocol = Some "TCP"
            , targetPort = Some (< Int : Natural | String : Text >.Int 16686)
            }
          ]
        , selector = Some
          [ { mapKey = "app.kubernetes.io/component", mapValue = "all-in-one" }
          , { mapKey = "app.kubernetes.io/name", mapValue = "jaeger" }
          ]
        , type = Some "ClusterIP"
        }
      }
    }
