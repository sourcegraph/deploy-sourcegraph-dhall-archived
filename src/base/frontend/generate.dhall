let Kubernetes = ../../deps/k8s/schemas.dhall

let Natural/enumerate =
      https://prelude.dhall-lang.org/v17.0.0/Natural/enumerate sha256:0cf083980a752b21ce0df9fc2222a4c139f50909e2353576e26a191002aa1ce3

let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Text/concatMapSep =
      https://prelude.dhall-lang.org/v17.0.0/Text/concatMapSep sha256:c272aca80a607bc5963d1fcb38819e7e0d3e72ac4d02b1183b1afb6a91340840

let Configuration/global = ../../configuration/global.dhall

let Util/EmptyCacheSSDVolume = ../../util/empty-cache-ssd-volume.dhall

let Util/JaegerAgent = ../../util/jaeger-agent.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let component = ./component.dhall

let makeGitserverEnvVar =
      λ(replicas : Natural) →
        let indicies = Natural/enumerate replicas

        let makeEndpoint =
              λ(i : Natural) → "gitserver-${Natural/show i}.gitserver:3178"

        in  Text/concatMapSep "," Natural makeEndpoint indicies

let frontendContainer/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Frontend.Deployment.Containers.SourcegraphFrontend

        let additionalEnvironmentVariables =
              Optional/default
                (List Kubernetes.EnvVar.Type)
                ([] : List Kubernetes.EnvVar.Type)
                overrides.additionalEnvironmentVariables

        let gitserverReplicas =
              Optional/default Natural 1 c.Gitserver.StatefulSet.replicas

        let environment =
                [ Kubernetes.EnvVar::{ name = "PGDATABASE", value = Some "sg" }
                , Kubernetes.EnvVar::{ name = "PGHOST", value = Some "pgsql" }
                , Kubernetes.EnvVar::{ name = "PGPORT", value = Some "5432" }
                , Kubernetes.EnvVar::{
                  , name = "PGSSLMODE"
                  , value = Some "disable"
                  }
                , Kubernetes.EnvVar::{ name = "PGUSER", value = Some "sg" }
                , Kubernetes.EnvVar::{
                  , name = "SRC_GIT_SERVERS"
                  , value = Some (makeGitserverEnvVar gitserverReplicas)
                  }
                , Kubernetes.EnvVar::{
                  , name = "POD_NAME"
                  , valueFrom = Some Kubernetes.EnvVarSource::{
                    , fieldRef = Some
                      { apiVersion = None Text, fieldPath = "metadata.name" }
                    }
                  }
                , Kubernetes.EnvVar::{
                  , name = "CACHE_DIR"
                  , value = Some "/mnt/cache/\$(POD_NAME)"
                  }
                , Kubernetes.EnvVar::{
                  , name = "GRAFANA_SERVER_URL"
                  , value = Some "http://grafana:30070"
                  }
                , Kubernetes.EnvVar::{
                  , name = "JAEGER_SERVER_URL"
                  , value = Some "http://jaeger-query:16686"
                  }
                , Kubernetes.EnvVar::{
                  , name = "PRECISE_CODE_INTEL_BUNDLE_MANAGER_URL"
                  , value = Some "http://precise-code-intel-bundle-manager:3187"
                  }
                , Kubernetes.EnvVar::{
                  , name = "PROMETHEUS_URL"
                  , value = Some "http://prometheus:30090"
                  }
                ]
              # additionalEnvironmentVariables

        let resources =
              Optional/default
                Kubernetes.ResourceRequirements.Type
                { limits = Some
                  [ { mapKey = "cpu", mapValue = "2" }
                  , { mapKey = "memory", mapValue = "4G" }
                  ]
                , requests = Some
                  [ { mapKey = "cpu", mapValue = "2" }
                  , { mapKey = "memory", mapValue = "2G" }
                  ]
                }
                overrides.resources

        let image =
              Optional/default
                Text
                "index.docker.io/sourcegraph/frontend:3.17.2@sha256:2378899365619635ce7acd983582407688d4def72a3fd62ae6fa0c23a0554fde"
                overrides.image

        let container =
              Kubernetes.Container::{
              , args = Some [ "serve" ]
              , env = Some environment
              , image = Some image
              , livenessProbe = Some Kubernetes.Probe::{
                , httpGet = Some Kubernetes.HTTPGetAction::{
                  , path = Some "/healthz"
                  , port = < Int : Natural | String : Text >.String "http"
                  , scheme = Some "HTTP"
                  }
                , initialDelaySeconds = Some 300
                , timeoutSeconds = Some 5
                }
              , name = "frontend"
              , ports = Some
                [ Kubernetes.ContainerPort::{
                  , containerPort = 3080
                  , name = Some "http"
                  }
                , Kubernetes.ContainerPort::{
                  , containerPort = 3090
                  , name = Some "http-internal"
                  }
                ]
              , readinessProbe = Some Kubernetes.Probe::{
                , httpGet = Some Kubernetes.HTTPGetAction::{
                  , path = Some "/healthz"
                  , port = < Int : Natural | String : Text >.String "http"
                  , scheme = Some "HTTP"
                  }
                , periodSeconds = Some 5
                , timeoutSeconds = Some 5
                }
              , resources = Some resources
              , terminationMessagePolicy = Some "FallbackToLogsOnError"
              , volumeMounts = Some
                [ Kubernetes.VolumeMount::{
                  , mountPath = "/mnt/cache"
                  , name = "cache-ssd"
                  }
                ]
              }

        in  container

let Deployment/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Frontend.Deployment

        let additionalAnnotations =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalAnnotations

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalLabels

        let replicas = Optional/default Natural 1 overrides.replicas

        let frontendContainer = frontendContainer/generate c

        let deployment =
              Kubernetes.Deployment::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = Some
                    (   [ { mapKey = "description"
                          , mapValue =
                              "Serves the frontend of Sourcegraph via HTTP(S)."
                          }
                        ]
                      # additionalAnnotations
                    )
                , labels = Some
                    (   [ { mapKey = "deploy", mapValue = "sourcegraph" }
                        , { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "no-cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "sourcegraph-frontend"
                }
              , spec = Some Kubernetes.DeploymentSpec::{
                , minReadySeconds = Some 10
                , replicas = Some replicas
                , revisionHistoryLimit = Some 10
                , selector = Kubernetes.LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "sourcegraph-frontend" } ]
                  }
                , strategy = Some Kubernetes.DeploymentStrategy::{
                  , rollingUpdate = Some
                    { maxSurge = Some (< Int : Natural | String : Text >.Int 2)
                    , maxUnavailable = Some
                        (< Int : Natural | String : Text >.Int 0)
                    }
                  , type = Some "RollingUpdate"
                  }
                , template = Kubernetes.PodTemplateSpec::{
                  , metadata = Kubernetes.ObjectMeta::{
                    , labels = Some
                      [ { mapKey = "app", mapValue = "sourcegraph-frontend" }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      ]
                    }
                  , spec = Some Kubernetes.PodSpec::{
                    , containers = [ frontendContainer, Util/JaegerAgent ]
                    , securityContext = Some Kubernetes.PodSecurityContext::{
                      , runAsUser = Some 0
                      }
                    , serviceAccountName = Some "sourcegraph-frontend"
                    , volumes = Some [ Util/EmptyCacheSSDVolume ]
                    }
                  }
                }
              }

        in  deployment

let Ingress/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Frontend.Ingress

        let additionalAnnotations =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalAnnotations

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalLabels

        let ingress =
              Kubernetes.Ingress::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = Some
                    (   [ { mapKey = "kubernetes.io/ingress.class"
                          , mapValue = "nginx"
                          }
                        , { mapKey =
                              "nginx.ingress.kubernetes.io/proxy-body-size"
                          , mapValue = "150m"
                          }
                        ]
                      # additionalAnnotations
                    )
                , labels = Some
                    (   [ { mapKey = "app", mapValue = "sourcegraph-frontend" }
                        , { mapKey = "deploy", mapValue = "sourcegraph" }
                        , { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "no-cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "sourcegraph-frontend"
                }
              , spec = Some Kubernetes.IngressSpec::{
                , rules = Some
                  [ Kubernetes.IngressRule::{
                    , http = Some Kubernetes.HTTPIngressRuleValue::{
                      , paths =
                        [ Kubernetes.HTTPIngressPath::{
                          , backend =
                            { serviceName = "sourcegraph-frontend"
                            , servicePort =
                                < Int : Natural | String : Text >.Int 30080
                            }
                          , path = Some "/"
                          }
                        ]
                      }
                    }
                  ]
                }
              }

        in  ingress

let Role/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Frontend.Role

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalLabels

        let role =
              Kubernetes.Role::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = overrides.additionalAnnotations
                , labels = Some
                    (   [ { mapKey = "category", mapValue = "rbac" }
                        , { mapKey = "deploy", mapValue = "sourcegraph" }
                        , { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "sourcegraph-frontend"
                }
              , rules = Some
                [ Kubernetes.PolicyRule::{
                  , apiGroups = Some [ "" ]
                  , resources = Some [ "endpoints", "services" ]
                  , verbs = [ "get", "list", "watch" ]
                  }
                ]
              }

        in  role

let RoleBinding/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Frontend.RoleBinding

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalLabels

        let roleBinding =
              Kubernetes.RoleBinding::{
              , metadata = Kubernetes.ObjectMeta::{
                , labels = Some
                    (   [ { mapKey = "category", mapValue = "rbac" }
                        , { mapKey = "deploy", mapValue = "sourcegraph" }
                        , { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "sourcegraph-frontend"
                }
              , roleRef = Kubernetes.RoleRef::{
                , apiGroup = ""
                , kind = "Role"
                , name = "sourcegraph-frontend"
                }
              , subjects = Some
                [ Kubernetes.Subject::{
                  , kind = "ServiceAccount"
                  , name = "sourcegraph-frontend"
                  }
                ]
              }

        in  roleBinding

let Service/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Frontend.Service

        let additionalAnnotations =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalAnnotations

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalLabels

        let service =
              Kubernetes.Service::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = Some
                    (   [ { mapKey = "prometheus.io/port", mapValue = "6060" }
                        , { mapKey = "sourcegraph.prometheus/scrape"
                          , mapValue = "true"
                          }
                        ]
                      # additionalAnnotations
                    )
                , labels = Some
                    (   [ { mapKey = "app", mapValue = "sourcegraph-frontend" }
                        , { mapKey = "deploy", mapValue = "sourcegraph" }
                        , { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "no-cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "sourcegraph-frontend"
                }
              , spec = Some Kubernetes.ServiceSpec::{
                , ports = Some
                  [ Kubernetes.ServicePort::{
                    , name = Some "http"
                    , port = 30080
                    , targetPort = Some
                        (< Int : Natural | String : Text >.String "http")
                    }
                  ]
                , selector = Some
                  [ { mapKey = "app", mapValue = "sourcegraph-frontend" } ]
                , type = Some "ClusterIP"
                }
              }

        in  service

let ServiceAccount/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Frontend.ServiceAccount

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalLabels

        let serviceAccount =
              Kubernetes.ServiceAccount::{
              , imagePullSecrets = Some [ { name = Some "docker-registry" } ]
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = overrides.additionalAnnotations
                , labels = Some
                    (   [ { mapKey = "category", mapValue = "rbac" }
                        , { mapKey = "deploy", mapValue = "sourcegraph" }
                        , { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "no-cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "sourcegraph-frontend"
                }
              }

        in  serviceAccount

let ServiceInternal/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Frontend.ServiceInternal

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                c.Frontend.ServiceInternal.additionalLabels

        let serviceInternal =
              Kubernetes.Service::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = overrides.additionalAnnotations
                , labels = Some
                    (   [ { mapKey = "app", mapValue = "sourcegraph-frontend" }
                        , { mapKey = "deploy", mapValue = "sourcegraph" }
                        , { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "no-cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "sourcegraph-frontend-internal"
                }
              , spec = Some Kubernetes.ServiceSpec::{
                , ports = Some
                  [ Kubernetes.ServicePort::{
                    , name = Some "http-internal"
                    , port = 80
                    , targetPort = Some
                        ( < Int : Natural | String : Text >.String
                            "http-internal"
                        )
                    }
                  ]
                , selector = Some
                  [ { mapKey = "app", mapValue = "sourcegraph-frontend" } ]
                , type = Some "ClusterIP"
                }
              }

        in  serviceInternal

let Generate =
        ( λ(c : Configuration/global.Type) →
            { Deployment = Deployment/generate c
            , Ingress = Ingress/generate c
            , Role = Role/generate c
            , RoleBinding = RoleBinding/generate c
            , Service = Service/generate c
            , ServiceAccount = ServiceAccount/generate c
            , ServiceInternal = ServiceInternal/generate c
            }
        )
      : ∀(c : Configuration/global.Type) → component

in  Generate
