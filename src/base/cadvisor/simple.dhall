let schemas = ../../deps/k8s/schemas.dhall

in  { ClusterRole = schemas.ClusterRole::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "app", mapValue = "cadvisor" }
          , { mapKey = "category", mapValue = "rbac" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "cluster-admin"
            }
          ]
        , name = Some "cadvisor"
        }
      , rules = Some
        [ schemas.PolicyRule::{
          , apiGroups = Some [ "policy" ]
          , resourceNames = Some [ "cadvisor" ]
          , resources = Some [ "podsecuritypolicies" ]
          , verbs = [ "use" ]
          }
        ]
      }
    , ClusterRoleBinding = schemas.ClusterRoleBinding::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "app", mapValue = "cadvisor" }
          , { mapKey = "category", mapValue = "rbac" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "cluster-admin"
            }
          ]
        , name = Some "cadvisor"
        }
      , roleRef = schemas.RoleRef::{
        , apiGroup = "rbac.authorization.k8s.io"
        , kind = "ClusterRole"
        , name = "cadvisor"
        }
      , subjects = Some
        [ schemas.Subject::{
          , kind = "ServiceAccount"
          , name = "cadvisor"
          , namespace = Some "default"
          }
        ]
      }
    , DaemonSet = schemas.DaemonSet::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "description"
            , mapValue = "DaemonSet to ensure all nodes run a cAdvisor pod."
            }
          , { mapKey = "seccomp.security.alpha.kubernetes.io/pod"
            , mapValue = "docker/default"
            }
          ]
        , labels = Some
          [ { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "cluster-admin"
            }
          ]
        , name = Some "cadvisor"
        }
      , spec = Some schemas.DaemonSetSpec::{
        , selector = schemas.LabelSelector::{
          , matchLabels = Some [ { mapKey = "app", mapValue = "cadvisor" } ]
          }
        , template = schemas.PodTemplateSpec::{
          , metadata = schemas.ObjectMeta::{
            , annotations = Some
              [ { mapKey = "description"
                , mapValue = "Collects and exports container metrics."
                }
              , { mapKey = "prometheus.io/port", mapValue = "48080" }
              , { mapKey = "sourcegraph.prometheus/scrape", mapValue = "true" }
              ]
            , labels = Some
              [ { mapKey = "app", mapValue = "cadvisor" }
              , { mapKey = "deploy", mapValue = "sourcegraph" }
              ]
            }
          , spec = Some schemas.PodSpec::{
            , automountServiceAccountToken = Some False
            , containers =
              [ schemas.Container::{
                , args = Some
                  [ "--store_container_labels=false"
                  , "--whitelisted_container_labels=io.kubernetes.container.name,io.kubernetes.pod.name,io.kubernetes.pod.namespace,io.kubernetes.pod.uid"
                  ]
                , image = Some
                    "index.docker.io/sourcegraph/cadvisor:3.17.2@sha256:9fb42b067d1f9cc84558f61b6ec42f8cfe7ad874625c7673efa9b1f047fa3ced"
                , name = "cadvisor"
                , ports = Some
                  [ schemas.ContainerPort::{
                    , containerPort = 48080
                    , name = Some "http"
                    , protocol = Some "TCP"
                    }
                  ]
                , resources = Some schemas.ResourceRequirements::{
                  , limits = Some
                    [ { mapKey = "cpu", mapValue = "300m" }
                    , { mapKey = "memory", mapValue = "2000Mi" }
                    ]
                  , requests = Some
                    [ { mapKey = "cpu", mapValue = "150m" }
                    , { mapKey = "memory", mapValue = "200Mi" }
                    ]
                  }
                , volumeMounts = Some
                  [ schemas.VolumeMount::{
                    , mountPath = "/rootfs"
                    , name = "rootfs"
                    , readOnly = Some True
                    }
                  , schemas.VolumeMount::{
                    , mountPath = "/var/run"
                    , name = "var-run"
                    , readOnly = Some True
                    }
                  , schemas.VolumeMount::{
                    , mountPath = "/sys"
                    , name = "sys"
                    , readOnly = Some True
                    }
                  , schemas.VolumeMount::{
                    , mountPath = "/var/lib/docker"
                    , name = "docker"
                    , readOnly = Some True
                    }
                  , schemas.VolumeMount::{
                    , mountPath = "/dev/disk"
                    , name = "disk"
                    , readOnly = Some True
                    }
                  ]
                }
              ]
            , serviceAccountName = Some "cadvisor"
            , terminationGracePeriodSeconds = Some 30
            , volumes = Some
              [ schemas.Volume::{
                , hostPath = Some schemas.HostPathVolumeSource::{ path = "/" }
                , name = "rootfs"
                }
              , schemas.Volume::{
                , hostPath = Some schemas.HostPathVolumeSource::{
                  , path = "/var/run"
                  }
                , name = "var-run"
                }
              , schemas.Volume::{
                , hostPath = Some schemas.HostPathVolumeSource::{
                  , path = "/sys"
                  }
                , name = "sys"
                }
              , schemas.Volume::{
                , hostPath = Some schemas.HostPathVolumeSource::{
                  , path = "/var/lib/docker"
                  }
                , name = "docker"
                }
              , schemas.Volume::{
                , hostPath = Some schemas.HostPathVolumeSource::{
                  , path = "/dev/disk"
                  }
                , name = "disk"
                }
              ]
            }
          }
        }
      }
    , PodSecurityPolicy = schemas.PodSecurityPolicy::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "app", mapValue = "cadvisor" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "cluster-admin"
            }
          ]
        , name = Some "cadvisor"
        }
      , spec = Some schemas.PodSecurityPolicySpec::{
        , allowedHostPaths = Some
          [ schemas.AllowedHostPath::{ pathPrefix = Some "/" }
          , schemas.AllowedHostPath::{ pathPrefix = Some "/var/run" }
          , schemas.AllowedHostPath::{ pathPrefix = Some "/sys" }
          , schemas.AllowedHostPath::{ pathPrefix = Some "/var/lib/docker" }
          , schemas.AllowedHostPath::{ pathPrefix = Some "/dev/disk" }
          ]
        , fsGroup = schemas.FSGroupStrategyOptions::{ rule = Some "RunAsAny" }
        , runAsUser = schemas.RunAsGroupStrategyOptions::{ rule = "RunAsAny" }
        , seLinux = schemas.SELinuxStrategyOptions::{ rule = "RunAsAny" }
        , supplementalGroups = schemas.FSGroupStrategyOptions::{
          , rule = Some "RunAsAny"
          }
        , volumes = Some [ "*" ]
        }
      }
    , ServiceAccount = schemas.ServiceAccount::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "app", mapValue = "cadvisor" }
          , { mapKey = "category", mapValue = "rbac" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "cluster-admin"
            }
          ]
        , name = Some "cadvisor"
        }
      }
    }
