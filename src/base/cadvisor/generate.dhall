let Kubernetes = ../../deps/k8s/schemas.dhall

let Configuration/global = ../../configuration/global.dhall

let Component = ./component.dhall

let DaemonSet/generate =
      λ(c : Configuration/global.Type) →
        let daemonSet =
              Kubernetes.DaemonSet::{
              , metadata = Kubernetes.ObjectMeta::{
                , annotations = Some
                  [ { mapKey = "description"
                    , mapValue =
                        "DaemonSet to ensure all nodes run a cAdvisor pod."
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
              , spec = Some Kubernetes.DaemonSetSpec::{
                , selector = Kubernetes.LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "cadvisor" } ]
                  }
                , template = Kubernetes.PodTemplateSpec::{
                  , metadata = Kubernetes.ObjectMeta::{
                    , annotations = Some
                      [ { mapKey = "description"
                        , mapValue = "Collects and exports container metrics."
                        }
                      , { mapKey = "prometheus.io/port", mapValue = "48080" }
                      , { mapKey = "sourcegraph.prometheus/scrape"
                        , mapValue = "true"
                        }
                      ]
                    , labels = Some
                      [ { mapKey = "app", mapValue = "cadvisor" }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      ]
                    }
                  , spec = Some Kubernetes.PodSpec::{
                    , automountServiceAccountToken = Some False
                    , containers =
                      [ Kubernetes.Container::{
                        , args = Some
                          [ "--store_container_labels=false"
                          , "--whitelisted_container_labels=io.kubernetes.container.name,io.kubernetes.pod.name,io.kubernetes.pod.namespace,io.kubernetes.pod.uid"
                          ]
                        , image = Some
                            "index.docker.io/sourcegraph/cadvisor:3.17.2@sha256:9fb42b067d1f9cc84558f61b6ec42f8cfe7ad874625c7673efa9b1f047fa3ced"
                        , name = "cadvisor"
                        , ports = Some
                          [ Kubernetes.ContainerPort::{
                            , containerPort = 48080
                            , name = Some "http"
                            , protocol = Some "TCP"
                            }
                          ]
                        , resources = Some Kubernetes.ResourceRequirements::{
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
                          [ Kubernetes.VolumeMount::{
                            , mountPath = "/rootfs"
                            , name = "rootfs"
                            , readOnly = Some True
                            }
                          , Kubernetes.VolumeMount::{
                            , mountPath = "/var/run"
                            , name = "var-run"
                            , readOnly = Some True
                            }
                          , Kubernetes.VolumeMount::{
                            , mountPath = "/sys"
                            , name = "sys"
                            , readOnly = Some True
                            }
                          , Kubernetes.VolumeMount::{
                            , mountPath = "/var/lib/docker"
                            , name = "docker"
                            , readOnly = Some True
                            }
                          , Kubernetes.VolumeMount::{
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
                      [ Kubernetes.Volume::{
                        , hostPath = Some Kubernetes.HostPathVolumeSource::{
                          , path = "/"
                          }
                        , name = "rootfs"
                        }
                      , Kubernetes.Volume::{
                        , hostPath = Some Kubernetes.HostPathVolumeSource::{
                          , path = "/var/run"
                          }
                        , name = "var-run"
                        }
                      , Kubernetes.Volume::{
                        , hostPath = Some Kubernetes.HostPathVolumeSource::{
                          , path = "/sys"
                          }
                        , name = "sys"
                        }
                      , Kubernetes.Volume::{
                        , hostPath = Some Kubernetes.HostPathVolumeSource::{
                          , path = "/var/lib/docker"
                          }
                        , name = "docker"
                        }
                      , Kubernetes.Volume::{
                        , hostPath = Some Kubernetes.HostPathVolumeSource::{
                          , path = "/dev/disk"
                          }
                        , name = "disk"
                        }
                      ]
                    }
                  }
                }
              }

        in  daemonSet

let ClusterRole/generate =
      λ(c : Configuration/global.Type) →
        let clusterRole =
              Kubernetes.ClusterRole::{
              , metadata = Kubernetes.ObjectMeta::{
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
                [ Kubernetes.PolicyRule::{
                  , apiGroups = Some [ "policy" ]
                  , resourceNames = Some [ "cadvisor" ]
                  , resources = Some [ "podsecuritypolicies" ]
                  , verbs = [ "use" ]
                  }
                ]
              }

        in  clusterRole

let ClusterRoleBinding/generate =
      λ(c : Configuration/global.Type) →
        let clusterRoleBinding =
              Kubernetes.ClusterRoleBinding::{
              , metadata = Kubernetes.ObjectMeta::{
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
              , roleRef = Kubernetes.RoleRef::{
                , apiGroup = "rbac.authorization.k8s.io"
                , kind = "ClusterRole"
                , name = "cadvisor"
                }
              , subjects = Some
                [ Kubernetes.Subject::{
                  , kind = "ServiceAccount"
                  , name = "cadvisor"
                  , namespace = Some "default"
                  }
                ]
              }

        in  clusterRoleBinding

let ServiceAccount/generate =
      λ(c : Configuration/global.Type) →
        let serviceAccount =
              Kubernetes.ServiceAccount::{
              , metadata = Kubernetes.ObjectMeta::{
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

        in  serviceAccount

let PodSecurityPolicy/generate =
      λ(c : Configuration/global.Type) →
        let podSecurityPolicy =
              Kubernetes.PodSecurityPolicy::{
              , metadata = Kubernetes.ObjectMeta::{
                , labels = Some
                  [ { mapKey = "app", mapValue = "cadvisor" }
                  , { mapKey = "deploy", mapValue = "sourcegraph" }
                  , { mapKey = "sourcegraph-resource-requires"
                    , mapValue = "cluster-admin"
                    }
                  ]
                , name = Some "cadvisor"
                }
              , spec = Some Kubernetes.PodSecurityPolicySpec::{
                , allowedHostPaths = Some
                  [ Kubernetes.AllowedHostPath::{ pathPrefix = Some "/" }
                  , Kubernetes.AllowedHostPath::{ pathPrefix = Some "/var/run" }
                  , Kubernetes.AllowedHostPath::{ pathPrefix = Some "/sys" }
                  , Kubernetes.AllowedHostPath::{
                    , pathPrefix = Some "/var/lib/docker"
                    }
                  , Kubernetes.AllowedHostPath::{
                    , pathPrefix = Some "/dev/disk"
                    }
                  ]
                , fsGroup = Kubernetes.FSGroupStrategyOptions::{
                  , rule = Some "RunAsAny"
                  }
                , runAsUser = Kubernetes.RunAsGroupStrategyOptions::{
                  , rule = "RunAsAny"
                  }
                , seLinux = Kubernetes.SELinuxStrategyOptions::{
                  , rule = "RunAsAny"
                  }
                , supplementalGroups = Kubernetes.FSGroupStrategyOptions::{
                  , rule = Some "RunAsAny"
                  }
                , volumes = Some [ "*" ]
                }
              }

        in  podSecurityPolicy

let Generate =
        ( λ(c : Configuration/global.Type) →
            { DaemonSet = DaemonSet/generate c
            , ClusterRole = ClusterRole/generate c
            , ClusterRoleBinding = ClusterRoleBinding/generate c
            , ServiceAccount = ServiceAccount/generate c
            , PodSecurityPolicy = PodSecurityPolicy/generate c
            }
        )
      : ∀(c : Configuration/global.Type) → Component

in  Generate
