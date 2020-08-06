let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Kubernetes/RollingUpdateDeployment =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.RollingUpdateDeployment.dhall

let Kubernetes/ObjectFieldSelector =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ObjectFieldSelector.dhall

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

let Kubernetes/EnvVar = ../../deps/k8s/schemas/io.k8s.api.core.v1.EnvVar.dhall

let Kubernetes/EnvVarSource =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.EnvVarSource.dhall

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

let Kubernetes/ResourceRequirements =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ResourceRequirements.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let Kubernetes/ServicePort =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServicePort.dhall

let Kubernetes/ServiceSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceSpec.dhall

let Kubernetes/VolumeMount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.VolumeMount.dhall

let Kubernetes/EmptyDirVolumeSource =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.EmptyDirVolumeSource.dhall

let Kubernetes/Volume = ../../deps/k8s/schemas/io.k8s.api.core.v1.Volume.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let containerResources = ../../configuration/container-resources.dhall

let containerResources/tok8s = ../../util/container-resources-to-k8s.dhall

let Service/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes/Service::{
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "prometheus.io/port", mapValue = "6060" }
                  , { mapKey = "sourcegraph.prometheus/scrape"
                    , mapValue = "true"
                    }
                  ]
                , labels = Some
                  [ { mapKey = "app", mapValue = "replacer" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "replacer"
                }
              , spec = Some Kubernetes/ServiceSpec::{
                , ports = Some
                  [ Kubernetes/ServicePort::{
                    , name = Some "http"
                    , port = 3185
                    , targetPort = Some
                        (< Int : Natural | String : Text >.String "http")
                    }
                  , Kubernetes/ServicePort::{
                    , name = Some "debug"
                    , port = 6060
                    , targetPort = Some
                        (< Int : Natural | String : Text >.String "debug")
                    }
                  ]
                , selector = Some [ { mapKey = "app", mapValue = "replacer" } ]
                , type = Some "ClusterIP"
                }
              }

        in  service

let Deployment/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Replacer.Deployment.Containers.Replacer

        let image =
              Optional/default
                Text
                "index.docker.io/sourcegraph/replacer:3.17.2@sha256:ad4748e62fdc7ee493274706aae516bb51b3bfda81d1af421f2f94543d71a424"
                overrides.image

        let resources =
              containerResources/tok8s
                { limits =
                    containerResources.overlay
                      containerResources.Configuration::{
                      , cpu = Some "4"
                      , memory = Some "500M"
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
                , annotations = Some
                  [ { mapKey = "description"
                    , mapValue = "Backend for replace operations."
                    }
                  ]
                , labels = Some
                  [ { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "replacer"
                }
              , spec = Some Kubernetes/DeploymentSpec::{
                , minReadySeconds = Some 10
                , replicas = Some 1
                , revisionHistoryLimit = Some 10
                , selector = Kubernetes/LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "replacer" } ]
                  }
                , strategy = Some Kubernetes/DeploymentStrategy::{
                  , rollingUpdate = Some Kubernetes/RollingUpdateDeployment::{
                    , maxSurge = Some (< Int : Natural | String : Text >.Int 1)
                    , maxUnavailable = Some
                        (< Int : Natural | String : Text >.Int 1)
                    }
                  , type = Some "RollingUpdate"
                  }
                , template = Kubernetes/PodTemplateSpec::{
                  , metadata = Kubernetes/ObjectMeta::{
                    , labels = Some
                      [ { mapKey = "app", mapValue = "replacer" }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      ]
                    }
                  , spec = Some Kubernetes/PodSpec::{
                    , containers =
                      [ Kubernetes/Container::{
                        , env = Some
                          [ Kubernetes/EnvVar::{
                            , name = "REPLACER_CACHE_SIZE_MB"
                            , value = Some "100000"
                            }
                          , Kubernetes/EnvVar::{
                            , name = "POD_NAME"
                            , valueFrom = Some Kubernetes/EnvVarSource::{
                              , fieldRef = Some Kubernetes/ObjectFieldSelector::{
                                , fieldPath = "metadata.name"
                                }
                              }
                            }
                          , Kubernetes/EnvVar::{
                            , name = "CACHE_DIR"
                            , value = Some "/mnt/cache/\$(POD_NAME)"
                            }
                          ]
                        , image = Some image
                        , name = "replacer"
                        , ports = Some
                          [ Kubernetes/ContainerPort::{
                            , containerPort = 3185
                            , name = Some "http"
                            }
                          , Kubernetes/ContainerPort::{
                            , containerPort = 6060
                            , name = Some "debug"
                            }
                          ]
                        , readinessProbe = Some Kubernetes/Probe::{
                          , failureThreshold = Some 1
                          , httpGet = Some Kubernetes/HTTPGetAction::{
                            , path = Some "/healthz"
                            , port =
                                < Int : Natural | String : Text >.String "http"
                            , scheme = Some "HTTP"
                            }
                          , periodSeconds = Some 1
                          }
                        , resources = Some resources
                        , terminationMessagePolicy = Some
                            "FallbackToLogsOnError"
                        , volumeMounts = Some
                          [ Kubernetes/VolumeMount::{
                            , mountPath = "/mnt/cache"
                            , name = "cache-ssd"
                            }
                          ]
                        }
                      , Kubernetes/Container::{
                        , args = Some
                          [ "--reporter.grpc.host-port=jaeger-collector:14250"
                          , "--reporter.type=grpc"
                          ]
                        , env = Some
                          [ Kubernetes/EnvVar::{
                            , name = "POD_NAME"
                            , valueFrom = Some Kubernetes/EnvVarSource::{
                              , fieldRef = Some Kubernetes/ObjectFieldSelector::{
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
                          [ Kubernetes/ContainerPort::{
                            , containerPort = 5775
                            , protocol = Some "UDP"
                            }
                          , Kubernetes/ContainerPort::{
                            , containerPort = 5778
                            , protocol = Some "TCP"
                            }
                          , Kubernetes/ContainerPort::{
                            , containerPort = 6831
                            , protocol = Some "UDP"
                            }
                          , Kubernetes/ContainerPort::{
                            , containerPort = 6832
                            , protocol = Some "UDP"
                            }
                          ]
                        , resources = Some Kubernetes/ResourceRequirements::{
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
                    , securityContext = Some Kubernetes/PodSecurityContext::{
                      , runAsUser = Some 0
                      }
                    , volumes = Some
                      [ Kubernetes/Volume::{
                        , emptyDir = Some Kubernetes/EmptyDirVolumeSource::{=}
                        , name = "cache-ssd"
                        }
                      ]
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
