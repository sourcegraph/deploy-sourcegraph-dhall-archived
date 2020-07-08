let schemas = ../../deps/k8s/schemas.dhall

in  { Deployment = schemas.Deployment::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "description"
            , mapValue = "Serves the frontend of Sourcegraph via HTTP(S)."
            }
          ]
        , labels = Some
          [ { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "sourcegraph-frontend"
        }
      , spec = Some schemas.DeploymentSpec::{
        , minReadySeconds = Some 10
        , replicas = Some 1
        , revisionHistoryLimit = Some 10
        , selector = schemas.LabelSelector::{
          , matchLabels = Some
            [ { mapKey = "app", mapValue = "sourcegraph-frontend" } ]
          }
        , strategy = Some schemas.DeploymentStrategy::{
          , rollingUpdate = Some schemas.RollingUpdateDeployment::{
            , maxSurge = Some (< Int : Natural | String : Text >.Int 2)
            , maxUnavailable = Some (< Int : Natural | String : Text >.Int 0)
            }
          , type = Some "RollingUpdate"
          }
        , template = schemas.PodTemplateSpec::{
          , metadata = schemas.ObjectMeta::{
            , labels = Some
              [ { mapKey = "app", mapValue = "sourcegraph-frontend" }
              , { mapKey = "deploy", mapValue = "sourcegraph" }
              ]
            }
          , spec = Some schemas.PodSpec::{
            , containers =
              [ schemas.Container::{
                , args = Some [ "serve" ]
                , env = Some
                  [ schemas.EnvVar::{ name = "PGDATABASE", value = Some "sg" }
                  , schemas.EnvVar::{ name = "PGHOST", value = Some "pgsql" }
                  , schemas.EnvVar::{ name = "PGPORT", value = Some "5432" }
                  , schemas.EnvVar::{
                    , name = "PGSSLMODE"
                    , value = Some "disable"
                    }
                  , schemas.EnvVar::{ name = "PGUSER", value = Some "sg" }
                  , schemas.EnvVar::{
                    , name = "SRC_GIT_SERVERS"
                    , value = Some "gitserver-0.gitserver:3178"
                    }
                  , schemas.EnvVar::{
                    , name = "POD_NAME"
                    , valueFrom = Some schemas.EnvVarSource::{
                      , fieldRef = Some schemas.ObjectFieldSelector::{
                        , fieldPath = "metadata.name"
                        }
                      }
                    }
                  , schemas.EnvVar::{
                    , name = "CACHE_DIR"
                    , value = Some "/mnt/cache/\$(POD_NAME)"
                    }
                  , schemas.EnvVar::{
                    , name = "GRAFANA_SERVER_URL"
                    , value = Some "http://grafana:30070"
                    }
                  , schemas.EnvVar::{
                    , name = "JAEGER_SERVER_URL"
                    , value = Some "http://jaeger-query:16686"
                    }
                  , schemas.EnvVar::{
                    , name = "PRECISE_CODE_INTEL_BUNDLE_MANAGER_URL"
                    , value = Some
                        "http://precise-code-intel-bundle-manager:3187"
                    }
                  , schemas.EnvVar::{
                    , name = "PROMETHEUS_URL"
                    , value = Some "http://prometheus:30090"
                    }
                  ]
                , image = Some
                    "index.docker.io/sourcegraph/frontend:3.17.2@sha256:2378899365619635ce7acd983582407688d4def72a3fd62ae6fa0c23a0554fde"
                , livenessProbe = Some schemas.Probe::{
                  , httpGet = Some schemas.HTTPGetAction::{
                    , path = Some "/healthz"
                    , port = < Int : Natural | String : Text >.String "http"
                    , scheme = Some "HTTP"
                    }
                  , initialDelaySeconds = Some 300
                  , timeoutSeconds = Some 5
                  }
                , name = "frontend"
                , ports = Some
                  [ schemas.ContainerPort::{
                    , containerPort = 3080
                    , name = Some "http"
                    }
                  , schemas.ContainerPort::{
                    , containerPort = 3090
                    , name = Some "http-internal"
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
                    [ { mapKey = "cpu", mapValue = "2" }
                    , { mapKey = "memory", mapValue = "2G" }
                    ]
                  }
                , terminationMessagePolicy = Some "FallbackToLogsOnError"
                , volumeMounts = Some
                  [ schemas.VolumeMount::{
                    , mountPath = "/mnt/cache"
                    , name = "cache-ssd"
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
            , serviceAccountName = Some "sourcegraph-frontend"
            , volumes = Some
              [ schemas.Volume::{
                , emptyDir = Some schemas.EmptyDirVolumeSource::{=}
                , name = "cache-ssd"
                }
              ]
            }
          }
        }
      }
    , Ingress = schemas.Ingress::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "kubernetes.io/ingress.class", mapValue = "nginx" }
          , { mapKey = "nginx.ingress.kubernetes.io/proxy-body-size"
            , mapValue = "150m"
            }
          ]
        , labels = Some
          [ { mapKey = "app", mapValue = "sourcegraph-frontend" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "sourcegraph-frontend"
        }
      , spec = Some schemas.IngressSpec::{
        , rules = Some
          [ schemas.IngressRule::{
            , http = Some schemas.HTTPIngressRuleValue::{
              , paths =
                [ schemas.HTTPIngressPath::{
                  , backend = schemas.IngressBackend::{
                    , serviceName = "sourcegraph-frontend"
                    , servicePort = < Int : Natural | String : Text >.Int 30080
                    }
                  , path = Some "/"
                  }
                ]
              }
            }
          ]
        }
      }
    , Role = schemas.Role::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "category", mapValue = "rbac" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "cluster-admin"
            }
          ]
        , name = Some "sourcegraph-frontend"
        }
      , rules = Some
        [ schemas.PolicyRule::{
          , apiGroups = Some [ "" ]
          , resources = Some [ "endpoints", "services" ]
          , verbs = [ "get", "list", "watch" ]
          }
        ]
      }
    , RoleBinding = schemas.ClusterRoleBinding::{
      , kind = "RoleBinding"
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "category", mapValue = "rbac" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "cluster-admin"
            }
          ]
        , name = Some "sourcegraph-frontend"
        }
      , roleRef = schemas.RoleRef::{
        , apiGroup = ""
        , kind = "Role"
        , name = "sourcegraph-frontend"
        }
      , subjects = Some
        [ schemas.Subject::{
          , kind = "ServiceAccount"
          , name = "sourcegraph-frontend"
          }
        ]
      }
    , Service = schemas.Service::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "prometheus.io/port", mapValue = "6060" }
          , { mapKey = "sourcegraph.prometheus/scrape", mapValue = "true" }
          ]
        , labels = Some
          [ { mapKey = "app", mapValue = "sourcegraph-frontend" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "sourcegraph-frontend"
        }
      , spec = Some schemas.ServiceSpec::{
        , ports = Some
          [ schemas.ServicePort::{
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
    , ServiceAccount = schemas.ServiceAccount::{
      , imagePullSecrets = Some
        [ schemas.LocalObjectReference::{ name = Some "docker-registry" } ]
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "category", mapValue = "rbac" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "sourcegraph-frontend"
        }
      }
    , ServiceInternal = schemas.Service::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "app", mapValue = "sourcegraph-frontend" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "sourcegraph-frontend-internal"
        }
      , spec = Some schemas.ServiceSpec::{
        , ports = Some
          [ schemas.ServicePort::{
            , name = Some "http-internal"
            , port = 80
            , targetPort = Some
                (< Int : Natural | String : Text >.String "http-internal")
            }
          ]
        , selector = Some
          [ { mapKey = "app", mapValue = "sourcegraph-frontend" } ]
        , type = Some "ClusterIP"
        }
      }
    }
