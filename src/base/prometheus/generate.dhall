let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Kubernetes/HTTPGetAction =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.HTTPGetAction.dhall

let Kubernetes/PolicyRule =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.PolicyRule.dhall

let Kubernetes/RoleRef = ../../deps/k8s/schemas/io.k8s.api.rbac.v1.RoleRef.dhall

let Kubernetes/ServiceAccount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceAccount.dhall

let Kubernetes/Subject = ../../deps/k8s/schemas/io.k8s.api.rbac.v1.Subject.dhall

let Kubernetes/ClusterRole =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.ClusterRole.dhall

let Kubernetes/ClusterRoleBinding =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.ClusterRoleBinding.dhall

let Kubernetes/ConfigMap =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ConfigMap.dhall

let Kubernetes/ConfigMapVolumeSource =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ConfigMapVolumeSource.dhall

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

let Kubernetes/LabelSelector =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall

let Kubernetes/ObjectMeta =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall

let Kubernetes/PersistentVolumeClaim =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PersistentVolumeClaim.dhall

let Kubernetes/PersistentVolumeClaimSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PersistentVolumeClaimSpec.dhall

let Kubernetes/PodSecurityContext =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PodSecurityContext.dhall

let Kubernetes/PodSpec = ../../deps/k8s/schemas/io.k8s.api.core.v1.PodSpec.dhall

let Kubernetes/PodTemplateSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PodTemplateSpec.dhall

let Kubernetes/Probe = ../../deps/k8s/schemas/io.k8s.api.core.v1.Probe.dhall

let Kubernetes/ResourceRequirements =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ResourceRequirements.dhall

let Kubernetes/ServicePort =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServicePort.dhall

let Kubernetes/ServiceSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceSpec.dhall

let Kubernetes/Volume = ../../deps/k8s/schemas/io.k8s.api.core.v1.Volume.dhall

let Kubernetes/VolumeMount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.VolumeMount.dhall

let Kubernetes/PersistentVolumeClaimVolumeSource =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PersistentVolumeClaimVolumeSource.dhall

let Kubernetes/LocalObjectReference =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.LocalObjectReference.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let containerResources = ../../configuration/container-resources.dhall

let containerResources/tok8s = ../../util/container-resources-to-k8s.dhall

let Deployment/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Prometheus.Deployment.Containers.Prometheus

        let image =
              Optional/default
                Text
                "index.docker.io/sourcegraph/prometheus:3.17.2@sha256:a725419a532fb17f6955e80f8a2f35efe15287c0a556e4fe7168d5fc6ff730d8"
                overrides.image

        let resources =
              containerResources/tok8s
                { limits =
                    containerResources.overlay
                      containerResources.Configuration::{
                      , cpu = Some "2"
                      , memory = Some "3G"
                      }
                      overrides.resources.limits
                , requests =
                    containerResources.overlay
                      containerResources.Configuration::{
                      , cpu = Some "500m"
                      , memory = Some "3G"
                      }
                      overrides.resources.requests
                }

        let deployment =
              Kubernetes/Deployment::{
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "description"
                    , mapValue =
                        "Collects metrics and aggregates them into graphs."
                    }
                  ]
                , labels = Some
                  [ { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "prometheus"
                }
              , spec = Some Kubernetes/DeploymentSpec::{
                , minReadySeconds = Some 10
                , replicas = Some 1
                , revisionHistoryLimit = Some 10
                , selector = Kubernetes/LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "prometheus" } ]
                  }
                , strategy = Some Kubernetes/DeploymentStrategy::{
                  , type = Some "Recreate"
                  }
                , template = Kubernetes/PodTemplateSpec::{
                  , metadata = Kubernetes/ObjectMeta::{
                    , labels = Some
                      [ { mapKey = "app", mapValue = "prometheus" }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      ]
                    }
                  , spec = Some Kubernetes/PodSpec::{
                    , containers =
                      [ Kubernetes/Container::{
                        , image = Some image
                        , livenessProbe = Some Kubernetes/Probe::{
                          , httpGet = Some Kubernetes/HTTPGetAction::{
                            , path = Some "/-/healthy"
                            , port = < Int : Natural | String : Text >.Int 9090
                            }
                          , initialDelaySeconds = Some 30
                          , timeoutSeconds = Some 30
                          }
                        , name = "prometheus"
                        , ports = Some
                          [ Kubernetes/ContainerPort::{
                            , containerPort = 9090
                            , name = Some "http"
                            }
                          ]
                        , readinessProbe = Some Kubernetes/Probe::{
                          , httpGet = Some Kubernetes/HTTPGetAction::{
                            , path = Some "/-/ready"
                            , port = < Int : Natural | String : Text >.Int 9090
                            }
                          , initialDelaySeconds = Some 30
                          , timeoutSeconds = Some 30
                          }
                        , resources = Some resources
                        , terminationMessagePolicy = Some
                            "FallbackToLogsOnError"
                        , volumeMounts = Some
                          [ Kubernetes/VolumeMount::{
                            , mountPath = "/prometheus"
                            , name = "data"
                            }
                          , Kubernetes/VolumeMount::{
                            , mountPath = "/sg_prometheus_add_ons"
                            , name = "config"
                            }
                          ]
                        }
                      ]
                    , securityContext = Some Kubernetes/PodSecurityContext::{
                      , runAsUser = Some 0
                      }
                    , serviceAccountName = Some "prometheus"
                    , volumes = Some
                      [ Kubernetes/Volume::{
                        , name = "data"
                        , persistentVolumeClaim = Some Kubernetes/PersistentVolumeClaimVolumeSource::{
                          , claimName = "prometheus"
                          }
                        }
                      , Kubernetes/Volume::{
                        , configMap = Some Kubernetes/ConfigMapVolumeSource::{
                          , defaultMode = Some 777
                          , name = Some "prometheus"
                          }
                        , name = "config"
                        }
                      ]
                    }
                  }
                }
              }

        in  deployment

let Service/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes/Service::{
              , metadata = Kubernetes/ObjectMeta::{
                , labels = Some
                  [ { mapKey = "app", mapValue = "prometheus" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "prometheus"
                }
              , spec = Some Kubernetes/ServiceSpec::{
                , ports = Some
                  [ Kubernetes/ServicePort::{
                    , name = Some "http"
                    , port = 30090
                    , targetPort = Some
                        (< Int : Natural | String : Text >.String "http")
                    }
                  ]
                , selector = Some
                  [ { mapKey = "app", mapValue = "prometheus" } ]
                , type = Some "ClusterIP"
                }
              }

        in  service

let ServiceAccount/generate =
      λ(c : Configuration/global.Type) →
        let serviceAccount =
              Kubernetes/ServiceAccount::{
              , imagePullSecrets = Some
                [ Kubernetes/LocalObjectReference::{
                  , name = Some "docker-registry"
                  }
                ]
              , metadata = Kubernetes/ObjectMeta::{
                , labels = Some
                  [ { mapKey = "category", mapValue = "rbac" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "prometheus"
                }
              }

        in  serviceAccount

let PersistentVolumeClaim/generate =
      λ(c : Configuration/global.Type) →
        let persistentVolumeClaim =
              Kubernetes/PersistentVolumeClaim::{
              , metadata = Kubernetes/ObjectMeta::{
                , labels = Some
                  [ { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "prometheus"
                }
              , spec = Some Kubernetes/PersistentVolumeClaimSpec::{
                , accessModes = Some [ "ReadWriteOnce" ]
                , resources = Some Kubernetes/ResourceRequirements::{
                  , requests = Some
                    [ { mapKey = "storage", mapValue = "200Gi" } ]
                  }
                , storageClassName = Some "sourcegraph"
                }
              }

        in  persistentVolumeClaim

let ClusterRole/generate =
      λ(c : Configuration/global.Type) →
        let clusterRole =
              Kubernetes/ClusterRole::{
              , metadata = Kubernetes/ObjectMeta::{
                , labels = Some
                  [ { mapKey = "category", mapValue = "rbac" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "cluster-admin"
                    }
                  ]
                , name = Some "prometheus"
                }
              , rules = Some
                [ Kubernetes/PolicyRule::{
                  , apiGroups = Some [ "" ]
                  , resources = Some
                    [ "endpoints"
                    , "namespaces"
                    , "nodes"
                    , "nodes/metrics"
                    , "nodes/proxy"
                    , "pods"
                    , "services"
                    ]
                  , verbs = [ "get", "list", "watch" ]
                  }
                , Kubernetes/PolicyRule::{
                  , apiGroups = Some [ "" ]
                  , resources = Some [ "configmaps" ]
                  , verbs = [ "get" ]
                  }
                , Kubernetes/PolicyRule::{
                  , nonResourceURLs = Some [ "/metrics" ]
                  , verbs = [ "get" ]
                  }
                ]
              }

        in  clusterRole

let ClusterRoleBinding/generate =
      λ(c : Configuration/global.Type) →
        let clusterRoleBinding =
              Kubernetes/ClusterRoleBinding::{
              , metadata = Kubernetes/ObjectMeta::{
                , labels = Some
                  [ { mapKey = "category", mapValue = "rbac" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "cluster-admin"
                    }
                  ]
                , name = Some "prometheus"
                }
              , roleRef = Kubernetes/RoleRef::{
                , apiGroup = ""
                , kind = "ClusterRole"
                , name = "prometheus"
                }
              , subjects = Some
                [ Kubernetes/Subject::{
                  , kind = "ServiceAccount"
                  , name = "prometheus"
                  , namespace = Some "default"
                  }
                ]
              }

        in  clusterRoleBinding

let ConfigMap/generate =
      λ(c : Configuration/global.Type) →
        let configMap =
              Kubernetes/ConfigMap::{
              , data = Some
                [ { mapKey = "alert_rules.yml"
                  , mapValue = ./alert_rules.yml as Text
                  }
                , { mapKey = "extra_rules.yml", mapValue = "" }
                , { mapKey = "node_rules.yml"
                  , mapValue = ./node_rules.yml as Text
                  }
                , { mapKey = "prometheus.yml"
                  , mapValue = ./prometheus.yml as Text
                  }
                , { mapKey = "sourcegraph_rules.yml"
                  , mapValue = ./sourcegraph_rules.yml as Text
                  }
                ]
              , metadata = Kubernetes/ObjectMeta::{
                , labels = Some
                  [ { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "no-cluster-admin"
                    }
                  ]
                , name = Some "prometheus"
                }
              }

        in  configMap

let Generate =
        ( λ(c : Configuration/global.Type) →
            { Deployment = Deployment/generate c
            , ClusterRole = ClusterRole/generate c
            , ConfigMap = ConfigMap/generate c
            , PersistentVolumeClaim = PersistentVolumeClaim/generate c
            , ClusterRoleBinding = ClusterRoleBinding/generate c
            , ServiceAccount = ServiceAccount/generate c
            , Service = Service/generate c
            }
        )
      : ∀(c : Configuration/global.Type) → component

in  Generate
