let Kubernetes/DaemonSet =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.DaemonSet.dhall

let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/PodSecurityPolicy =
      ../../deps/k8s/schemas/io.k8s.api.extensions.v1beta1.PodSecurityPolicy.dhall

let Kubernetes/ClusterRole =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.ClusterRole.dhall

let Kubernetes/ClusterRoleBinding =
      ../../deps/k8s/schemas/io.k8s.api.rbac.v1.ClusterRoleBinding.dhall

let Kubernetes/ServiceAccount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceAccount.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let Configuration/global = ../../configuration/global.dhall

let Component = ./component.dhall

let DaemonSet/generate =
      λ(c : Configuration/global.Type) →
        let daemonSet =
              Kubernetes/DaemonSet::{
              , apiVersion = "apps/v1"
              , kind = "DaemonSet"
              , metadata =
                { annotations = Some
                    ( toMap
                        { `seccomp.security.alpha.kubernetes.io/pod` =
                            "docker/default"
                        , description =
                            "DaemonSet to ensure all nodes run a cAdvisor pod."
                        }
                    )
                , clusterName = None Text
                , creationTimestamp = None Text
                , deletionGracePeriodSeconds = None Natural
                , deletionTimestamp = None Text
                , finalizers = None (List Text)
                , generateName = None Text
                , generation = None Natural
                , labels = Some
                    ( toMap
                        { sourcegraph-resource-requires = "cluster-admin"
                        , deploy = "sourcegraph"
                        }
                    )
                , managedFields =
                    None
                      ( List
                          { apiVersion : Text
                          , fieldsType : Optional Text
                          , fieldsV1 :
                              Optional (List { mapKey : Text, mapValue : Text })
                          , manager : Optional Text
                          , operation : Optional Text
                          , time : Optional Text
                          }
                      )
                , name = Some "cadvisor"
                , namespace = None Text
                , ownerReferences =
                    None
                      ( List
                          { apiVersion : Text
                          , blockOwnerDeletion : Optional Bool
                          , controller : Optional Bool
                          , kind : Text
                          , name : Text
                          , uid : Text
                          }
                      )
                , resourceVersion = None Text
                , selfLink = None Text
                , uid = None Text
                }
              , spec = Some
                { minReadySeconds = None Natural
                , revisionHistoryLimit = None Natural
                , selector =
                  { matchExpressions =
                      None
                        ( List
                            { key : Text
                            , operator : Text
                            , values : Optional (List Text)
                            }
                        )
                  , matchLabels = Some (toMap { app = "cadvisor" })
                  }
                , template =
                  { metadata =
                    { annotations = Some
                        ( toMap
                            { `sourcegraph.prometheus/scrape` = "true"
                            , `prometheus.io/port` = "48080"
                            , description =
                                "Collects and exports container metrics."
                            }
                        )
                    , clusterName = None Text
                    , creationTimestamp = None Text
                    , deletionGracePeriodSeconds = None Natural
                    , deletionTimestamp = None Text
                    , finalizers = None (List Text)
                    , generateName = None Text
                    , generation = None Natural
                    , labels = Some
                        (toMap { app = "cadvisor", deploy = "sourcegraph" })
                    , managedFields =
                        None
                          ( List
                              { apiVersion : Text
                              , fieldsType : Optional Text
                              , fieldsV1 :
                                  Optional
                                    (List { mapKey : Text, mapValue : Text })
                              , manager : Optional Text
                              , operation : Optional Text
                              , time : Optional Text
                              }
                          )
                    , name = None Text
                    , namespace = None Text
                    , ownerReferences =
                        None
                          ( List
                              { apiVersion : Text
                              , blockOwnerDeletion : Optional Bool
                              , controller : Optional Bool
                              , kind : Text
                              , name : Text
                              , uid : Text
                              }
                          )
                    , resourceVersion = None Text
                    , selfLink = None Text
                    , uid = None Text
                    }
                  , spec = Some
                    { activeDeadlineSeconds = None Natural
                    , affinity =
                        None
                          { nodeAffinity :
                              Optional
                                { preferredDuringSchedulingIgnoredDuringExecution :
                                    Optional
                                      ( List
                                          { preference :
                                              { matchExpressions :
                                                  Optional
                                                    ( List
                                                        { key : Text
                                                        , operator : Text
                                                        , values :
                                                            Optional (List Text)
                                                        }
                                                    )
                                              , matchFields :
                                                  Optional
                                                    ( List
                                                        { key : Text
                                                        , operator : Text
                                                        , values :
                                                            Optional (List Text)
                                                        }
                                                    )
                                              }
                                          , weight : Natural
                                          }
                                      )
                                , requiredDuringSchedulingIgnoredDuringExecution :
                                    Optional
                                      { nodeSelectorTerms :
                                          List
                                            { matchExpressions :
                                                Optional
                                                  ( List
                                                      { key : Text
                                                      , operator : Text
                                                      , values :
                                                          Optional (List Text)
                                                      }
                                                  )
                                            , matchFields :
                                                Optional
                                                  ( List
                                                      { key : Text
                                                      , operator : Text
                                                      , values :
                                                          Optional (List Text)
                                                      }
                                                  )
                                            }
                                      }
                                }
                          , podAffinity :
                              Optional
                                { preferredDuringSchedulingIgnoredDuringExecution :
                                    Optional
                                      ( List
                                          { podAffinityTerm :
                                              { labelSelector :
                                                  Optional
                                                    { matchExpressions :
                                                        Optional
                                                          ( List
                                                              { key : Text
                                                              , operator : Text
                                                              , values :
                                                                  Optional
                                                                    (List Text)
                                                              }
                                                          )
                                                    , matchLabels :
                                                        Optional
                                                          ( List
                                                              { mapKey : Text
                                                              , mapValue : Text
                                                              }
                                                          )
                                                    }
                                              , namespaces :
                                                  Optional (List Text)
                                              , topologyKey : Text
                                              }
                                          , weight : Natural
                                          }
                                      )
                                , requiredDuringSchedulingIgnoredDuringExecution :
                                    Optional
                                      ( List
                                          { labelSelector :
                                              Optional
                                                { matchExpressions :
                                                    Optional
                                                      ( List
                                                          { key : Text
                                                          , operator : Text
                                                          , values :
                                                              Optional
                                                                (List Text)
                                                          }
                                                      )
                                                , matchLabels :
                                                    Optional
                                                      ( List
                                                          { mapKey : Text
                                                          , mapValue : Text
                                                          }
                                                      )
                                                }
                                          , namespaces : Optional (List Text)
                                          , topologyKey : Text
                                          }
                                      )
                                }
                          , podAntiAffinity :
                              Optional
                                { preferredDuringSchedulingIgnoredDuringExecution :
                                    Optional
                                      ( List
                                          { podAffinityTerm :
                                              { labelSelector :
                                                  Optional
                                                    { matchExpressions :
                                                        Optional
                                                          ( List
                                                              { key : Text
                                                              , operator : Text
                                                              , values :
                                                                  Optional
                                                                    (List Text)
                                                              }
                                                          )
                                                    , matchLabels :
                                                        Optional
                                                          ( List
                                                              { mapKey : Text
                                                              , mapValue : Text
                                                              }
                                                          )
                                                    }
                                              , namespaces :
                                                  Optional (List Text)
                                              , topologyKey : Text
                                              }
                                          , weight : Natural
                                          }
                                      )
                                , requiredDuringSchedulingIgnoredDuringExecution :
                                    Optional
                                      ( List
                                          { labelSelector :
                                              Optional
                                                { matchExpressions :
                                                    Optional
                                                      ( List
                                                          { key : Text
                                                          , operator : Text
                                                          , values :
                                                              Optional
                                                                (List Text)
                                                          }
                                                      )
                                                , matchLabels :
                                                    Optional
                                                      ( List
                                                          { mapKey : Text
                                                          , mapValue : Text
                                                          }
                                                      )
                                                }
                                          , namespaces : Optional (List Text)
                                          , topologyKey : Text
                                          }
                                      )
                                }
                          }
                    , automountServiceAccountToken = Some False
                    , containers =
                      [ { args = Some
                          [ "--store_container_labels=false"
                          , "--whitelisted_container_labels=io.kubernetes.container.name,io.kubernetes.pod.name,io.kubernetes.pod.namespace,io.kubernetes.pod.uid"
                          ]
                        , command = None (List Text)
                        , env =
                            None
                              ( List
                                  { name : Text
                                  , value : Optional Text
                                  , valueFrom :
                                      Optional
                                        { configMapKeyRef :
                                            Optional
                                              { key : Text
                                              , name : Optional Text
                                              , optional : Optional Bool
                                              }
                                        , fieldRef :
                                            Optional
                                              { apiVersion : Optional Text
                                              , fieldPath : Text
                                              }
                                        , resourceFieldRef :
                                            Optional
                                              { containerName : Optional Text
                                              , divisor : Optional Text
                                              , resource : Text
                                              }
                                        , secretKeyRef :
                                            Optional
                                              { key : Text
                                              , name : Optional Text
                                              , optional : Optional Bool
                                              }
                                        }
                                  }
                              )
                        , envFrom =
                            None
                              ( List
                                  { configMapRef :
                                      Optional
                                        { name : Optional Text
                                        , optional : Optional Bool
                                        }
                                  , prefix : Optional Text
                                  , secretRef :
                                      Optional
                                        { name : Optional Text
                                        , optional : Optional Bool
                                        }
                                  }
                              )
                        , image = Some
                            "index.docker.io/sourcegraph/cadvisor:3.17.2@sha256:9fb42b067d1f9cc84558f61b6ec42f8cfe7ad874625c7673efa9b1f047fa3ced"
                        , imagePullPolicy = None Text
                        , lifecycle =
                            None
                              { postStart :
                                  Optional
                                    { exec :
                                        Optional
                                          { command : Optional (List Text) }
                                    , httpGet :
                                        Optional
                                          { host : Optional Text
                                          , httpHeaders :
                                              Optional
                                                ( List
                                                    { name : Text
                                                    , value : Text
                                                    }
                                                )
                                          , path : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          , scheme : Optional Text
                                          }
                                    , tcpSocket :
                                        Optional
                                          { host : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          }
                                    }
                              , preStop :
                                  Optional
                                    { exec :
                                        Optional
                                          { command : Optional (List Text) }
                                    , httpGet :
                                        Optional
                                          { host : Optional Text
                                          , httpHeaders :
                                              Optional
                                                ( List
                                                    { name : Text
                                                    , value : Text
                                                    }
                                                )
                                          , path : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          , scheme : Optional Text
                                          }
                                    , tcpSocket :
                                        Optional
                                          { host : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          }
                                    }
                              }
                        , livenessProbe =
                            None
                              { exec :
                                  Optional { command : Optional (List Text) }
                              , failureThreshold : Optional Natural
                              , httpGet :
                                  Optional
                                    { host : Optional Text
                                    , httpHeaders :
                                        Optional
                                          (List { name : Text, value : Text })
                                    , path : Optional Text
                                    , port : < Int : Natural | String : Text >
                                    , scheme : Optional Text
                                    }
                              , initialDelaySeconds : Optional Natural
                              , periodSeconds : Optional Natural
                              , successThreshold : Optional Natural
                              , tcpSocket :
                                  Optional
                                    { host : Optional Text
                                    , port : < Int : Natural | String : Text >
                                    }
                              , timeoutSeconds : Optional Natural
                              }
                        , name = "cadvisor"
                        , ports = Some
                          [ { containerPort = 48080
                            , hostIP = None Text
                            , hostPort = None Natural
                            , name = Some "http"
                            , protocol = Some "TCP"
                            }
                          ]
                        , readinessProbe =
                            None
                              { exec :
                                  Optional { command : Optional (List Text) }
                              , failureThreshold : Optional Natural
                              , httpGet :
                                  Optional
                                    { host : Optional Text
                                    , httpHeaders :
                                        Optional
                                          (List { name : Text, value : Text })
                                    , path : Optional Text
                                    , port : < Int : Natural | String : Text >
                                    , scheme : Optional Text
                                    }
                              , initialDelaySeconds : Optional Natural
                              , periodSeconds : Optional Natural
                              , successThreshold : Optional Natural
                              , tcpSocket :
                                  Optional
                                    { host : Optional Text
                                    , port : < Int : Natural | String : Text >
                                    }
                              , timeoutSeconds : Optional Natural
                              }
                        , resources = Some
                          { limits = Some
                              (toMap { memory = "2000Mi", cpu = "300m" })
                          , requests = Some
                              (toMap { memory = "200Mi", cpu = "150m" })
                          }
                        , securityContext =
                            None
                              { allowPrivilegeEscalation : Optional Bool
                              , capabilities :
                                  Optional
                                    { add : Optional (List Text)
                                    , drop : Optional (List Text)
                                    }
                              , privileged : Optional Bool
                              , procMount : Optional Text
                              , readOnlyRootFilesystem : Optional Bool
                              , runAsGroup : Optional Natural
                              , runAsNonRoot : Optional Bool
                              , runAsUser : Optional Natural
                              , seLinuxOptions :
                                  Optional
                                    { level : Optional Text
                                    , role : Optional Text
                                    , type : Optional Text
                                    , user : Optional Text
                                    }
                              , windowsOptions :
                                  Optional
                                    { gmsaCredentialSpec : Optional Text
                                    , gmsaCredentialSpecName : Optional Text
                                    , runAsUserName : Optional Text
                                    }
                              }
                        , startupProbe =
                            None
                              { exec :
                                  Optional { command : Optional (List Text) }
                              , failureThreshold : Optional Natural
                              , httpGet :
                                  Optional
                                    { host : Optional Text
                                    , httpHeaders :
                                        Optional
                                          (List { name : Text, value : Text })
                                    , path : Optional Text
                                    , port : < Int : Natural | String : Text >
                                    , scheme : Optional Text
                                    }
                              , initialDelaySeconds : Optional Natural
                              , periodSeconds : Optional Natural
                              , successThreshold : Optional Natural
                              , tcpSocket :
                                  Optional
                                    { host : Optional Text
                                    , port : < Int : Natural | String : Text >
                                    }
                              , timeoutSeconds : Optional Natural
                              }
                        , stdin = None Bool
                        , stdinOnce = None Bool
                        , terminationMessagePath = None Text
                        , terminationMessagePolicy = None Text
                        , tty = None Bool
                        , volumeDevices =
                            None (List { devicePath : Text, name : Text })
                        , volumeMounts = Some
                          [ { mountPath = "/rootfs"
                            , mountPropagation = None Text
                            , name = "rootfs"
                            , readOnly = Some True
                            , subPath = None Text
                            , subPathExpr = None Text
                            }
                          , { mountPath = "/var/run"
                            , mountPropagation = None Text
                            , name = "var-run"
                            , readOnly = Some True
                            , subPath = None Text
                            , subPathExpr = None Text
                            }
                          , { mountPath = "/sys"
                            , mountPropagation = None Text
                            , name = "sys"
                            , readOnly = Some True
                            , subPath = None Text
                            , subPathExpr = None Text
                            }
                          , { mountPath = "/var/lib/docker"
                            , mountPropagation = None Text
                            , name = "docker"
                            , readOnly = Some True
                            , subPath = None Text
                            , subPathExpr = None Text
                            }
                          , { mountPath = "/dev/disk"
                            , mountPropagation = None Text
                            , name = "disk"
                            , readOnly = Some True
                            , subPath = None Text
                            , subPathExpr = None Text
                            }
                          ]
                        , workingDir = None Text
                        }
                      ]
                    , dnsConfig =
                        None
                          { nameservers : Optional (List Text)
                          , options :
                              Optional
                                ( List
                                    { name : Optional Text
                                    , value : Optional Text
                                    }
                                )
                          , searches : Optional (List Text)
                          }
                    , dnsPolicy = None Text
                    , enableServiceLinks = None Bool
                    , ephemeralContainers =
                        None
                          ( List
                              { args : Optional (List Text)
                              , command : Optional (List Text)
                              , env :
                                  Optional
                                    ( List
                                        { name : Text
                                        , value : Optional Text
                                        , valueFrom :
                                            Optional
                                              { configMapKeyRef :
                                                  Optional
                                                    { key : Text
                                                    , name : Optional Text
                                                    , optional : Optional Bool
                                                    }
                                              , fieldRef :
                                                  Optional
                                                    { apiVersion : Optional Text
                                                    , fieldPath : Text
                                                    }
                                              , resourceFieldRef :
                                                  Optional
                                                    { containerName :
                                                        Optional Text
                                                    , divisor : Optional Text
                                                    , resource : Text
                                                    }
                                              , secretKeyRef :
                                                  Optional
                                                    { key : Text
                                                    , name : Optional Text
                                                    , optional : Optional Bool
                                                    }
                                              }
                                        }
                                    )
                              , envFrom :
                                  Optional
                                    ( List
                                        { configMapRef :
                                            Optional
                                              { name : Optional Text
                                              , optional : Optional Bool
                                              }
                                        , prefix : Optional Text
                                        , secretRef :
                                            Optional
                                              { name : Optional Text
                                              , optional : Optional Bool
                                              }
                                        }
                                    )
                              , image : Optional Text
                              , imagePullPolicy : Optional Text
                              , lifecycle :
                                  Optional
                                    { postStart :
                                        Optional
                                          { exec :
                                              Optional
                                                { command : Optional (List Text)
                                                }
                                          , httpGet :
                                              Optional
                                                { host : Optional Text
                                                , httpHeaders :
                                                    Optional
                                                      ( List
                                                          { name : Text
                                                          , value : Text
                                                          }
                                                      )
                                                , path : Optional Text
                                                , port :
                                                    < Int : Natural
                                                    | String : Text
                                                    >
                                                , scheme : Optional Text
                                                }
                                          , tcpSocket :
                                              Optional
                                                { host : Optional Text
                                                , port :
                                                    < Int : Natural
                                                    | String : Text
                                                    >
                                                }
                                          }
                                    , preStop :
                                        Optional
                                          { exec :
                                              Optional
                                                { command : Optional (List Text)
                                                }
                                          , httpGet :
                                              Optional
                                                { host : Optional Text
                                                , httpHeaders :
                                                    Optional
                                                      ( List
                                                          { name : Text
                                                          , value : Text
                                                          }
                                                      )
                                                , path : Optional Text
                                                , port :
                                                    < Int : Natural
                                                    | String : Text
                                                    >
                                                , scheme : Optional Text
                                                }
                                          , tcpSocket :
                                              Optional
                                                { host : Optional Text
                                                , port :
                                                    < Int : Natural
                                                    | String : Text
                                                    >
                                                }
                                          }
                                    }
                              , livenessProbe :
                                  Optional
                                    { exec :
                                        Optional
                                          { command : Optional (List Text) }
                                    , failureThreshold : Optional Natural
                                    , httpGet :
                                        Optional
                                          { host : Optional Text
                                          , httpHeaders :
                                              Optional
                                                ( List
                                                    { name : Text
                                                    , value : Text
                                                    }
                                                )
                                          , path : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          , scheme : Optional Text
                                          }
                                    , initialDelaySeconds : Optional Natural
                                    , periodSeconds : Optional Natural
                                    , successThreshold : Optional Natural
                                    , tcpSocket :
                                        Optional
                                          { host : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          }
                                    , timeoutSeconds : Optional Natural
                                    }
                              , name : Text
                              , ports :
                                  Optional
                                    ( List
                                        { containerPort : Natural
                                        , hostIP : Optional Text
                                        , hostPort : Optional Natural
                                        , name : Optional Text
                                        , protocol : Optional Text
                                        }
                                    )
                              , readinessProbe :
                                  Optional
                                    { exec :
                                        Optional
                                          { command : Optional (List Text) }
                                    , failureThreshold : Optional Natural
                                    , httpGet :
                                        Optional
                                          { host : Optional Text
                                          , httpHeaders :
                                              Optional
                                                ( List
                                                    { name : Text
                                                    , value : Text
                                                    }
                                                )
                                          , path : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          , scheme : Optional Text
                                          }
                                    , initialDelaySeconds : Optional Natural
                                    , periodSeconds : Optional Natural
                                    , successThreshold : Optional Natural
                                    , tcpSocket :
                                        Optional
                                          { host : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          }
                                    , timeoutSeconds : Optional Natural
                                    }
                              , resources :
                                  Optional
                                    { limits :
                                        Optional
                                          ( List
                                              { mapKey : Text, mapValue : Text }
                                          )
                                    , requests :
                                        Optional
                                          ( List
                                              { mapKey : Text, mapValue : Text }
                                          )
                                    }
                              , securityContext :
                                  Optional
                                    { allowPrivilegeEscalation : Optional Bool
                                    , capabilities :
                                        Optional
                                          { add : Optional (List Text)
                                          , drop : Optional (List Text)
                                          }
                                    , privileged : Optional Bool
                                    , procMount : Optional Text
                                    , readOnlyRootFilesystem : Optional Bool
                                    , runAsGroup : Optional Natural
                                    , runAsNonRoot : Optional Bool
                                    , runAsUser : Optional Natural
                                    , seLinuxOptions :
                                        Optional
                                          { level : Optional Text
                                          , role : Optional Text
                                          , type : Optional Text
                                          , user : Optional Text
                                          }
                                    , windowsOptions :
                                        Optional
                                          { gmsaCredentialSpec : Optional Text
                                          , gmsaCredentialSpecName :
                                              Optional Text
                                          , runAsUserName : Optional Text
                                          }
                                    }
                              , startupProbe :
                                  Optional
                                    { exec :
                                        Optional
                                          { command : Optional (List Text) }
                                    , failureThreshold : Optional Natural
                                    , httpGet :
                                        Optional
                                          { host : Optional Text
                                          , httpHeaders :
                                              Optional
                                                ( List
                                                    { name : Text
                                                    , value : Text
                                                    }
                                                )
                                          , path : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          , scheme : Optional Text
                                          }
                                    , initialDelaySeconds : Optional Natural
                                    , periodSeconds : Optional Natural
                                    , successThreshold : Optional Natural
                                    , tcpSocket :
                                        Optional
                                          { host : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          }
                                    , timeoutSeconds : Optional Natural
                                    }
                              , stdin : Optional Bool
                              , stdinOnce : Optional Bool
                              , targetContainerName : Optional Text
                              , terminationMessagePath : Optional Text
                              , terminationMessagePolicy : Optional Text
                              , tty : Optional Bool
                              , volumeDevices :
                                  Optional
                                    (List { devicePath : Text, name : Text })
                              , volumeMounts :
                                  Optional
                                    ( List
                                        { mountPath : Text
                                        , mountPropagation : Optional Text
                                        , name : Text
                                        , readOnly : Optional Bool
                                        , subPath : Optional Text
                                        , subPathExpr : Optional Text
                                        }
                                    )
                              , workingDir : Optional Text
                              }
                          )
                    , hostAliases =
                        None
                          ( List
                              { hostnames : Optional (List Text)
                              , ip : Optional Text
                              }
                          )
                    , hostIPC = None Bool
                    , hostNetwork = None Bool
                    , hostPID = None Bool
                    , hostname = None Text
                    , imagePullSecrets = None (List { name : Optional Text })
                    , initContainers =
                        None
                          ( List
                              { args : Optional (List Text)
                              , command : Optional (List Text)
                              , env :
                                  Optional
                                    ( List
                                        { name : Text
                                        , value : Optional Text
                                        , valueFrom :
                                            Optional
                                              { configMapKeyRef :
                                                  Optional
                                                    { key : Text
                                                    , name : Optional Text
                                                    , optional : Optional Bool
                                                    }
                                              , fieldRef :
                                                  Optional
                                                    { apiVersion : Optional Text
                                                    , fieldPath : Text
                                                    }
                                              , resourceFieldRef :
                                                  Optional
                                                    { containerName :
                                                        Optional Text
                                                    , divisor : Optional Text
                                                    , resource : Text
                                                    }
                                              , secretKeyRef :
                                                  Optional
                                                    { key : Text
                                                    , name : Optional Text
                                                    , optional : Optional Bool
                                                    }
                                              }
                                        }
                                    )
                              , envFrom :
                                  Optional
                                    ( List
                                        { configMapRef :
                                            Optional
                                              { name : Optional Text
                                              , optional : Optional Bool
                                              }
                                        , prefix : Optional Text
                                        , secretRef :
                                            Optional
                                              { name : Optional Text
                                              , optional : Optional Bool
                                              }
                                        }
                                    )
                              , image : Optional Text
                              , imagePullPolicy : Optional Text
                              , lifecycle :
                                  Optional
                                    { postStart :
                                        Optional
                                          { exec :
                                              Optional
                                                { command : Optional (List Text)
                                                }
                                          , httpGet :
                                              Optional
                                                { host : Optional Text
                                                , httpHeaders :
                                                    Optional
                                                      ( List
                                                          { name : Text
                                                          , value : Text
                                                          }
                                                      )
                                                , path : Optional Text
                                                , port :
                                                    < Int : Natural
                                                    | String : Text
                                                    >
                                                , scheme : Optional Text
                                                }
                                          , tcpSocket :
                                              Optional
                                                { host : Optional Text
                                                , port :
                                                    < Int : Natural
                                                    | String : Text
                                                    >
                                                }
                                          }
                                    , preStop :
                                        Optional
                                          { exec :
                                              Optional
                                                { command : Optional (List Text)
                                                }
                                          , httpGet :
                                              Optional
                                                { host : Optional Text
                                                , httpHeaders :
                                                    Optional
                                                      ( List
                                                          { name : Text
                                                          , value : Text
                                                          }
                                                      )
                                                , path : Optional Text
                                                , port :
                                                    < Int : Natural
                                                    | String : Text
                                                    >
                                                , scheme : Optional Text
                                                }
                                          , tcpSocket :
                                              Optional
                                                { host : Optional Text
                                                , port :
                                                    < Int : Natural
                                                    | String : Text
                                                    >
                                                }
                                          }
                                    }
                              , livenessProbe :
                                  Optional
                                    { exec :
                                        Optional
                                          { command : Optional (List Text) }
                                    , failureThreshold : Optional Natural
                                    , httpGet :
                                        Optional
                                          { host : Optional Text
                                          , httpHeaders :
                                              Optional
                                                ( List
                                                    { name : Text
                                                    , value : Text
                                                    }
                                                )
                                          , path : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          , scheme : Optional Text
                                          }
                                    , initialDelaySeconds : Optional Natural
                                    , periodSeconds : Optional Natural
                                    , successThreshold : Optional Natural
                                    , tcpSocket :
                                        Optional
                                          { host : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          }
                                    , timeoutSeconds : Optional Natural
                                    }
                              , name : Text
                              , ports :
                                  Optional
                                    ( List
                                        { containerPort : Natural
                                        , hostIP : Optional Text
                                        , hostPort : Optional Natural
                                        , name : Optional Text
                                        , protocol : Optional Text
                                        }
                                    )
                              , readinessProbe :
                                  Optional
                                    { exec :
                                        Optional
                                          { command : Optional (List Text) }
                                    , failureThreshold : Optional Natural
                                    , httpGet :
                                        Optional
                                          { host : Optional Text
                                          , httpHeaders :
                                              Optional
                                                ( List
                                                    { name : Text
                                                    , value : Text
                                                    }
                                                )
                                          , path : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          , scheme : Optional Text
                                          }
                                    , initialDelaySeconds : Optional Natural
                                    , periodSeconds : Optional Natural
                                    , successThreshold : Optional Natural
                                    , tcpSocket :
                                        Optional
                                          { host : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          }
                                    , timeoutSeconds : Optional Natural
                                    }
                              , resources :
                                  Optional
                                    { limits :
                                        Optional
                                          ( List
                                              { mapKey : Text, mapValue : Text }
                                          )
                                    , requests :
                                        Optional
                                          ( List
                                              { mapKey : Text, mapValue : Text }
                                          )
                                    }
                              , securityContext :
                                  Optional
                                    { allowPrivilegeEscalation : Optional Bool
                                    , capabilities :
                                        Optional
                                          { add : Optional (List Text)
                                          , drop : Optional (List Text)
                                          }
                                    , privileged : Optional Bool
                                    , procMount : Optional Text
                                    , readOnlyRootFilesystem : Optional Bool
                                    , runAsGroup : Optional Natural
                                    , runAsNonRoot : Optional Bool
                                    , runAsUser : Optional Natural
                                    , seLinuxOptions :
                                        Optional
                                          { level : Optional Text
                                          , role : Optional Text
                                          , type : Optional Text
                                          , user : Optional Text
                                          }
                                    , windowsOptions :
                                        Optional
                                          { gmsaCredentialSpec : Optional Text
                                          , gmsaCredentialSpecName :
                                              Optional Text
                                          , runAsUserName : Optional Text
                                          }
                                    }
                              , startupProbe :
                                  Optional
                                    { exec :
                                        Optional
                                          { command : Optional (List Text) }
                                    , failureThreshold : Optional Natural
                                    , httpGet :
                                        Optional
                                          { host : Optional Text
                                          , httpHeaders :
                                              Optional
                                                ( List
                                                    { name : Text
                                                    , value : Text
                                                    }
                                                )
                                          , path : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          , scheme : Optional Text
                                          }
                                    , initialDelaySeconds : Optional Natural
                                    , periodSeconds : Optional Natural
                                    , successThreshold : Optional Natural
                                    , tcpSocket :
                                        Optional
                                          { host : Optional Text
                                          , port :
                                              < Int : Natural | String : Text >
                                          }
                                    , timeoutSeconds : Optional Natural
                                    }
                              , stdin : Optional Bool
                              , stdinOnce : Optional Bool
                              , terminationMessagePath : Optional Text
                              , terminationMessagePolicy : Optional Text
                              , tty : Optional Bool
                              , volumeDevices :
                                  Optional
                                    (List { devicePath : Text, name : Text })
                              , volumeMounts :
                                  Optional
                                    ( List
                                        { mountPath : Text
                                        , mountPropagation : Optional Text
                                        , name : Text
                                        , readOnly : Optional Bool
                                        , subPath : Optional Text
                                        , subPathExpr : Optional Text
                                        }
                                    )
                              , workingDir : Optional Text
                              }
                          )
                    , nodeName = None Text
                    , nodeSelector =
                        None (List { mapKey : Text, mapValue : Text })
                    , overhead = None (List { mapKey : Text, mapValue : Text })
                    , preemptionPolicy = None Text
                    , priority = None Natural
                    , priorityClassName = None Text
                    , readinessGates = None (List { conditionType : Text })
                    , restartPolicy = None Text
                    , runtimeClassName = None Text
                    , schedulerName = None Text
                    , securityContext =
                        None
                          { fsGroup : Optional Natural
                          , runAsGroup : Optional Natural
                          , runAsNonRoot : Optional Bool
                          , runAsUser : Optional Natural
                          , seLinuxOptions :
                              Optional
                                { level : Optional Text
                                , role : Optional Text
                                , type : Optional Text
                                , user : Optional Text
                                }
                          , supplementalGroups : Optional (List Natural)
                          , sysctls :
                              Optional (List { name : Text, value : Text })
                          , windowsOptions :
                              Optional
                                { gmsaCredentialSpec : Optional Text
                                , gmsaCredentialSpecName : Optional Text
                                , runAsUserName : Optional Text
                                }
                          }
                    , serviceAccount = None Text
                    , serviceAccountName = Some "cadvisor"
                    , shareProcessNamespace = None Bool
                    , subdomain = None Text
                    , terminationGracePeriodSeconds = Some 30
                    , tolerations =
                        None
                          ( List
                              { effect : Optional Text
                              , key : Optional Text
                              , operator : Optional Text
                              , tolerationSeconds : Optional Natural
                              , value : Optional Text
                              }
                          )
                    , topologySpreadConstraints =
                        None
                          ( List
                              { labelSelector :
                                  Optional
                                    { matchExpressions :
                                        Optional
                                          ( List
                                              { key : Text
                                              , operator : Text
                                              , values : Optional (List Text)
                                              }
                                          )
                                    , matchLabels :
                                        Optional
                                          ( List
                                              { mapKey : Text, mapValue : Text }
                                          )
                                    }
                              , maxSkew : Natural
                              , topologyKey : Text
                              , whenUnsatisfiable : Text
                              }
                          )
                    , volumes = Some
                      [ { awsElasticBlockStore =
                            None
                              { fsType : Optional Text
                              , partition : Optional Natural
                              , readOnly : Optional Bool
                              , volumeID : Text
                              }
                        , azureDisk =
                            None
                              { cachingMode : Optional Text
                              , diskName : Text
                              , diskURI : Text
                              , fsType : Optional Text
                              , kind : Text
                              , readOnly : Optional Bool
                              }
                        , azureFile =
                            None
                              { readOnly : Optional Bool
                              , secretName : Text
                              , shareName : Text
                              }
                        , cephfs =
                            None
                              { monitors : List Text
                              , path : Optional Text
                              , readOnly : Optional Bool
                              , secretFile : Optional Text
                              , secretRef : Optional { name : Optional Text }
                              , user : Optional Text
                              }
                        , cinder =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , volumeID : Text
                              }
                        , configMap =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { key : Text
                                        , mode : Optional Natural
                                        , path : Text
                                        }
                                    )
                              , name : Optional Text
                              , optional : Optional Bool
                              }
                        , csi =
                            None
                              { driver : Text
                              , fsType : Optional Text
                              , nodePublishSecretRef :
                                  Optional { name : Optional Text }
                              , readOnly : Optional Bool
                              , volumeAttributes :
                                  Optional
                                    (List { mapKey : Text, mapValue : Text })
                              }
                        , downwardAPI =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { fieldRef :
                                            Optional
                                              { apiVersion : Optional Text
                                              , fieldPath : Text
                                              }
                                        , mode : Optional Natural
                                        , path : Text
                                        , resourceFieldRef :
                                            Optional
                                              { containerName : Optional Text
                                              , divisor : Optional Text
                                              , resource : Text
                                              }
                                        }
                                    )
                              }
                        , emptyDir =
                            None
                              { medium : Optional Text
                              , sizeLimit : Optional Text
                              }
                        , fc =
                            None
                              { fsType : Optional Text
                              , lun : Optional Natural
                              , readOnly : Optional Bool
                              , targetWWNs : Optional (List Text)
                              , wwids : Optional (List Text)
                              }
                        , flexVolume =
                            None
                              { driver : Text
                              , fsType : Optional Text
                              , options :
                                  Optional
                                    (List { mapKey : Text, mapValue : Text })
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              }
                        , flocker =
                            None
                              { datasetName : Optional Text
                              , datasetUUID : Optional Text
                              }
                        , gcePersistentDisk =
                            None
                              { fsType : Optional Text
                              , partition : Optional Natural
                              , pdName : Text
                              , readOnly : Optional Bool
                              }
                        , gitRepo =
                            None
                              { directory : Optional Text
                              , repository : Text
                              , revision : Optional Text
                              }
                        , glusterfs =
                            None
                              { endpoints : Text
                              , path : Text
                              , readOnly : Optional Bool
                              }
                        , hostPath = Some { path = "/", type = None Text }
                        , iscsi =
                            None
                              { chapAuthDiscovery : Optional Bool
                              , chapAuthSession : Optional Bool
                              , fsType : Optional Text
                              , initiatorName : Optional Text
                              , iqn : Text
                              , iscsiInterface : Optional Text
                              , lun : Natural
                              , portals : Optional (List Text)
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , targetPortal : Text
                              }
                        , name = "rootfs"
                        , nfs =
                            None
                              { path : Text
                              , readOnly : Optional Bool
                              , server : Text
                              }
                        , persistentVolumeClaim =
                            None { claimName : Text, readOnly : Optional Bool }
                        , photonPersistentDisk =
                            None { fsType : Optional Text, pdID : Text }
                        , portworxVolume =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , volumeID : Text
                              }
                        , projected =
                            None
                              { defaultMode : Optional Natural
                              , sources :
                                  List
                                    { configMap :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { key : Text
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    }
                                                )
                                          , name : Optional Text
                                          , optional : Optional Bool
                                          }
                                    , downwardAPI :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { fieldRef :
                                                        Optional
                                                          { apiVersion :
                                                              Optional Text
                                                          , fieldPath : Text
                                                          }
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    , resourceFieldRef :
                                                        Optional
                                                          { containerName :
                                                              Optional Text
                                                          , divisor :
                                                              Optional Text
                                                          , resource : Text
                                                          }
                                                    }
                                                )
                                          }
                                    , secret :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { key : Text
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    }
                                                )
                                          , name : Optional Text
                                          , optional : Optional Bool
                                          }
                                    , serviceAccountToken :
                                        Optional
                                          { audience : Optional Text
                                          , expirationSeconds : Optional Natural
                                          , path : Text
                                          }
                                    }
                              }
                        , quobyte =
                            None
                              { group : Optional Text
                              , readOnly : Optional Bool
                              , registry : Text
                              , tenant : Optional Text
                              , user : Optional Text
                              , volume : Text
                              }
                        , rbd =
                            None
                              { fsType : Optional Text
                              , image : Text
                              , keyring : Optional Text
                              , monitors : List Text
                              , pool : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , user : Optional Text
                              }
                        , scaleIO =
                            None
                              { fsType : Optional Text
                              , gateway : Text
                              , protectionDomain : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : { name : Optional Text }
                              , sslEnabled : Optional Bool
                              , storageMode : Optional Text
                              , storagePool : Optional Text
                              , system : Text
                              , volumeName : Optional Text
                              }
                        , secret =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { key : Text
                                        , mode : Optional Natural
                                        , path : Text
                                        }
                                    )
                              , optional : Optional Bool
                              , secretName : Optional Text
                              }
                        , storageos =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , volumeName : Optional Text
                              , volumeNamespace : Optional Text
                              }
                        , vsphereVolume =
                            None
                              { fsType : Optional Text
                              , storagePolicyID : Optional Text
                              , storagePolicyName : Optional Text
                              , volumePath : Text
                              }
                        }
                      , { awsElasticBlockStore =
                            None
                              { fsType : Optional Text
                              , partition : Optional Natural
                              , readOnly : Optional Bool
                              , volumeID : Text
                              }
                        , azureDisk =
                            None
                              { cachingMode : Optional Text
                              , diskName : Text
                              , diskURI : Text
                              , fsType : Optional Text
                              , kind : Text
                              , readOnly : Optional Bool
                              }
                        , azureFile =
                            None
                              { readOnly : Optional Bool
                              , secretName : Text
                              , shareName : Text
                              }
                        , cephfs =
                            None
                              { monitors : List Text
                              , path : Optional Text
                              , readOnly : Optional Bool
                              , secretFile : Optional Text
                              , secretRef : Optional { name : Optional Text }
                              , user : Optional Text
                              }
                        , cinder =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , volumeID : Text
                              }
                        , configMap =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { key : Text
                                        , mode : Optional Natural
                                        , path : Text
                                        }
                                    )
                              , name : Optional Text
                              , optional : Optional Bool
                              }
                        , csi =
                            None
                              { driver : Text
                              , fsType : Optional Text
                              , nodePublishSecretRef :
                                  Optional { name : Optional Text }
                              , readOnly : Optional Bool
                              , volumeAttributes :
                                  Optional
                                    (List { mapKey : Text, mapValue : Text })
                              }
                        , downwardAPI =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { fieldRef :
                                            Optional
                                              { apiVersion : Optional Text
                                              , fieldPath : Text
                                              }
                                        , mode : Optional Natural
                                        , path : Text
                                        , resourceFieldRef :
                                            Optional
                                              { containerName : Optional Text
                                              , divisor : Optional Text
                                              , resource : Text
                                              }
                                        }
                                    )
                              }
                        , emptyDir =
                            None
                              { medium : Optional Text
                              , sizeLimit : Optional Text
                              }
                        , fc =
                            None
                              { fsType : Optional Text
                              , lun : Optional Natural
                              , readOnly : Optional Bool
                              , targetWWNs : Optional (List Text)
                              , wwids : Optional (List Text)
                              }
                        , flexVolume =
                            None
                              { driver : Text
                              , fsType : Optional Text
                              , options :
                                  Optional
                                    (List { mapKey : Text, mapValue : Text })
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              }
                        , flocker =
                            None
                              { datasetName : Optional Text
                              , datasetUUID : Optional Text
                              }
                        , gcePersistentDisk =
                            None
                              { fsType : Optional Text
                              , partition : Optional Natural
                              , pdName : Text
                              , readOnly : Optional Bool
                              }
                        , gitRepo =
                            None
                              { directory : Optional Text
                              , repository : Text
                              , revision : Optional Text
                              }
                        , glusterfs =
                            None
                              { endpoints : Text
                              , path : Text
                              , readOnly : Optional Bool
                              }
                        , hostPath = Some
                          { path = "/var/run", type = None Text }
                        , iscsi =
                            None
                              { chapAuthDiscovery : Optional Bool
                              , chapAuthSession : Optional Bool
                              , fsType : Optional Text
                              , initiatorName : Optional Text
                              , iqn : Text
                              , iscsiInterface : Optional Text
                              , lun : Natural
                              , portals : Optional (List Text)
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , targetPortal : Text
                              }
                        , name = "var-run"
                        , nfs =
                            None
                              { path : Text
                              , readOnly : Optional Bool
                              , server : Text
                              }
                        , persistentVolumeClaim =
                            None { claimName : Text, readOnly : Optional Bool }
                        , photonPersistentDisk =
                            None { fsType : Optional Text, pdID : Text }
                        , portworxVolume =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , volumeID : Text
                              }
                        , projected =
                            None
                              { defaultMode : Optional Natural
                              , sources :
                                  List
                                    { configMap :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { key : Text
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    }
                                                )
                                          , name : Optional Text
                                          , optional : Optional Bool
                                          }
                                    , downwardAPI :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { fieldRef :
                                                        Optional
                                                          { apiVersion :
                                                              Optional Text
                                                          , fieldPath : Text
                                                          }
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    , resourceFieldRef :
                                                        Optional
                                                          { containerName :
                                                              Optional Text
                                                          , divisor :
                                                              Optional Text
                                                          , resource : Text
                                                          }
                                                    }
                                                )
                                          }
                                    , secret :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { key : Text
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    }
                                                )
                                          , name : Optional Text
                                          , optional : Optional Bool
                                          }
                                    , serviceAccountToken :
                                        Optional
                                          { audience : Optional Text
                                          , expirationSeconds : Optional Natural
                                          , path : Text
                                          }
                                    }
                              }
                        , quobyte =
                            None
                              { group : Optional Text
                              , readOnly : Optional Bool
                              , registry : Text
                              , tenant : Optional Text
                              , user : Optional Text
                              , volume : Text
                              }
                        , rbd =
                            None
                              { fsType : Optional Text
                              , image : Text
                              , keyring : Optional Text
                              , monitors : List Text
                              , pool : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , user : Optional Text
                              }
                        , scaleIO =
                            None
                              { fsType : Optional Text
                              , gateway : Text
                              , protectionDomain : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : { name : Optional Text }
                              , sslEnabled : Optional Bool
                              , storageMode : Optional Text
                              , storagePool : Optional Text
                              , system : Text
                              , volumeName : Optional Text
                              }
                        , secret =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { key : Text
                                        , mode : Optional Natural
                                        , path : Text
                                        }
                                    )
                              , optional : Optional Bool
                              , secretName : Optional Text
                              }
                        , storageos =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , volumeName : Optional Text
                              , volumeNamespace : Optional Text
                              }
                        , vsphereVolume =
                            None
                              { fsType : Optional Text
                              , storagePolicyID : Optional Text
                              , storagePolicyName : Optional Text
                              , volumePath : Text
                              }
                        }
                      , { awsElasticBlockStore =
                            None
                              { fsType : Optional Text
                              , partition : Optional Natural
                              , readOnly : Optional Bool
                              , volumeID : Text
                              }
                        , azureDisk =
                            None
                              { cachingMode : Optional Text
                              , diskName : Text
                              , diskURI : Text
                              , fsType : Optional Text
                              , kind : Text
                              , readOnly : Optional Bool
                              }
                        , azureFile =
                            None
                              { readOnly : Optional Bool
                              , secretName : Text
                              , shareName : Text
                              }
                        , cephfs =
                            None
                              { monitors : List Text
                              , path : Optional Text
                              , readOnly : Optional Bool
                              , secretFile : Optional Text
                              , secretRef : Optional { name : Optional Text }
                              , user : Optional Text
                              }
                        , cinder =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , volumeID : Text
                              }
                        , configMap =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { key : Text
                                        , mode : Optional Natural
                                        , path : Text
                                        }
                                    )
                              , name : Optional Text
                              , optional : Optional Bool
                              }
                        , csi =
                            None
                              { driver : Text
                              , fsType : Optional Text
                              , nodePublishSecretRef :
                                  Optional { name : Optional Text }
                              , readOnly : Optional Bool
                              , volumeAttributes :
                                  Optional
                                    (List { mapKey : Text, mapValue : Text })
                              }
                        , downwardAPI =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { fieldRef :
                                            Optional
                                              { apiVersion : Optional Text
                                              , fieldPath : Text
                                              }
                                        , mode : Optional Natural
                                        , path : Text
                                        , resourceFieldRef :
                                            Optional
                                              { containerName : Optional Text
                                              , divisor : Optional Text
                                              , resource : Text
                                              }
                                        }
                                    )
                              }
                        , emptyDir =
                            None
                              { medium : Optional Text
                              , sizeLimit : Optional Text
                              }
                        , fc =
                            None
                              { fsType : Optional Text
                              , lun : Optional Natural
                              , readOnly : Optional Bool
                              , targetWWNs : Optional (List Text)
                              , wwids : Optional (List Text)
                              }
                        , flexVolume =
                            None
                              { driver : Text
                              , fsType : Optional Text
                              , options :
                                  Optional
                                    (List { mapKey : Text, mapValue : Text })
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              }
                        , flocker =
                            None
                              { datasetName : Optional Text
                              , datasetUUID : Optional Text
                              }
                        , gcePersistentDisk =
                            None
                              { fsType : Optional Text
                              , partition : Optional Natural
                              , pdName : Text
                              , readOnly : Optional Bool
                              }
                        , gitRepo =
                            None
                              { directory : Optional Text
                              , repository : Text
                              , revision : Optional Text
                              }
                        , glusterfs =
                            None
                              { endpoints : Text
                              , path : Text
                              , readOnly : Optional Bool
                              }
                        , hostPath = Some { path = "/sys", type = None Text }
                        , iscsi =
                            None
                              { chapAuthDiscovery : Optional Bool
                              , chapAuthSession : Optional Bool
                              , fsType : Optional Text
                              , initiatorName : Optional Text
                              , iqn : Text
                              , iscsiInterface : Optional Text
                              , lun : Natural
                              , portals : Optional (List Text)
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , targetPortal : Text
                              }
                        , name = "sys"
                        , nfs =
                            None
                              { path : Text
                              , readOnly : Optional Bool
                              , server : Text
                              }
                        , persistentVolumeClaim =
                            None { claimName : Text, readOnly : Optional Bool }
                        , photonPersistentDisk =
                            None { fsType : Optional Text, pdID : Text }
                        , portworxVolume =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , volumeID : Text
                              }
                        , projected =
                            None
                              { defaultMode : Optional Natural
                              , sources :
                                  List
                                    { configMap :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { key : Text
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    }
                                                )
                                          , name : Optional Text
                                          , optional : Optional Bool
                                          }
                                    , downwardAPI :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { fieldRef :
                                                        Optional
                                                          { apiVersion :
                                                              Optional Text
                                                          , fieldPath : Text
                                                          }
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    , resourceFieldRef :
                                                        Optional
                                                          { containerName :
                                                              Optional Text
                                                          , divisor :
                                                              Optional Text
                                                          , resource : Text
                                                          }
                                                    }
                                                )
                                          }
                                    , secret :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { key : Text
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    }
                                                )
                                          , name : Optional Text
                                          , optional : Optional Bool
                                          }
                                    , serviceAccountToken :
                                        Optional
                                          { audience : Optional Text
                                          , expirationSeconds : Optional Natural
                                          , path : Text
                                          }
                                    }
                              }
                        , quobyte =
                            None
                              { group : Optional Text
                              , readOnly : Optional Bool
                              , registry : Text
                              , tenant : Optional Text
                              , user : Optional Text
                              , volume : Text
                              }
                        , rbd =
                            None
                              { fsType : Optional Text
                              , image : Text
                              , keyring : Optional Text
                              , monitors : List Text
                              , pool : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , user : Optional Text
                              }
                        , scaleIO =
                            None
                              { fsType : Optional Text
                              , gateway : Text
                              , protectionDomain : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : { name : Optional Text }
                              , sslEnabled : Optional Bool
                              , storageMode : Optional Text
                              , storagePool : Optional Text
                              , system : Text
                              , volumeName : Optional Text
                              }
                        , secret =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { key : Text
                                        , mode : Optional Natural
                                        , path : Text
                                        }
                                    )
                              , optional : Optional Bool
                              , secretName : Optional Text
                              }
                        , storageos =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , volumeName : Optional Text
                              , volumeNamespace : Optional Text
                              }
                        , vsphereVolume =
                            None
                              { fsType : Optional Text
                              , storagePolicyID : Optional Text
                              , storagePolicyName : Optional Text
                              , volumePath : Text
                              }
                        }
                      , { awsElasticBlockStore =
                            None
                              { fsType : Optional Text
                              , partition : Optional Natural
                              , readOnly : Optional Bool
                              , volumeID : Text
                              }
                        , azureDisk =
                            None
                              { cachingMode : Optional Text
                              , diskName : Text
                              , diskURI : Text
                              , fsType : Optional Text
                              , kind : Text
                              , readOnly : Optional Bool
                              }
                        , azureFile =
                            None
                              { readOnly : Optional Bool
                              , secretName : Text
                              , shareName : Text
                              }
                        , cephfs =
                            None
                              { monitors : List Text
                              , path : Optional Text
                              , readOnly : Optional Bool
                              , secretFile : Optional Text
                              , secretRef : Optional { name : Optional Text }
                              , user : Optional Text
                              }
                        , cinder =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , volumeID : Text
                              }
                        , configMap =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { key : Text
                                        , mode : Optional Natural
                                        , path : Text
                                        }
                                    )
                              , name : Optional Text
                              , optional : Optional Bool
                              }
                        , csi =
                            None
                              { driver : Text
                              , fsType : Optional Text
                              , nodePublishSecretRef :
                                  Optional { name : Optional Text }
                              , readOnly : Optional Bool
                              , volumeAttributes :
                                  Optional
                                    (List { mapKey : Text, mapValue : Text })
                              }
                        , downwardAPI =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { fieldRef :
                                            Optional
                                              { apiVersion : Optional Text
                                              , fieldPath : Text
                                              }
                                        , mode : Optional Natural
                                        , path : Text
                                        , resourceFieldRef :
                                            Optional
                                              { containerName : Optional Text
                                              , divisor : Optional Text
                                              , resource : Text
                                              }
                                        }
                                    )
                              }
                        , emptyDir =
                            None
                              { medium : Optional Text
                              , sizeLimit : Optional Text
                              }
                        , fc =
                            None
                              { fsType : Optional Text
                              , lun : Optional Natural
                              , readOnly : Optional Bool
                              , targetWWNs : Optional (List Text)
                              , wwids : Optional (List Text)
                              }
                        , flexVolume =
                            None
                              { driver : Text
                              , fsType : Optional Text
                              , options :
                                  Optional
                                    (List { mapKey : Text, mapValue : Text })
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              }
                        , flocker =
                            None
                              { datasetName : Optional Text
                              , datasetUUID : Optional Text
                              }
                        , gcePersistentDisk =
                            None
                              { fsType : Optional Text
                              , partition : Optional Natural
                              , pdName : Text
                              , readOnly : Optional Bool
                              }
                        , gitRepo =
                            None
                              { directory : Optional Text
                              , repository : Text
                              , revision : Optional Text
                              }
                        , glusterfs =
                            None
                              { endpoints : Text
                              , path : Text
                              , readOnly : Optional Bool
                              }
                        , hostPath = Some
                          { path = "/var/lib/docker", type = None Text }
                        , iscsi =
                            None
                              { chapAuthDiscovery : Optional Bool
                              , chapAuthSession : Optional Bool
                              , fsType : Optional Text
                              , initiatorName : Optional Text
                              , iqn : Text
                              , iscsiInterface : Optional Text
                              , lun : Natural
                              , portals : Optional (List Text)
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , targetPortal : Text
                              }
                        , name = "docker"
                        , nfs =
                            None
                              { path : Text
                              , readOnly : Optional Bool
                              , server : Text
                              }
                        , persistentVolumeClaim =
                            None { claimName : Text, readOnly : Optional Bool }
                        , photonPersistentDisk =
                            None { fsType : Optional Text, pdID : Text }
                        , portworxVolume =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , volumeID : Text
                              }
                        , projected =
                            None
                              { defaultMode : Optional Natural
                              , sources :
                                  List
                                    { configMap :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { key : Text
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    }
                                                )
                                          , name : Optional Text
                                          , optional : Optional Bool
                                          }
                                    , downwardAPI :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { fieldRef :
                                                        Optional
                                                          { apiVersion :
                                                              Optional Text
                                                          , fieldPath : Text
                                                          }
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    , resourceFieldRef :
                                                        Optional
                                                          { containerName :
                                                              Optional Text
                                                          , divisor :
                                                              Optional Text
                                                          , resource : Text
                                                          }
                                                    }
                                                )
                                          }
                                    , secret :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { key : Text
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    }
                                                )
                                          , name : Optional Text
                                          , optional : Optional Bool
                                          }
                                    , serviceAccountToken :
                                        Optional
                                          { audience : Optional Text
                                          , expirationSeconds : Optional Natural
                                          , path : Text
                                          }
                                    }
                              }
                        , quobyte =
                            None
                              { group : Optional Text
                              , readOnly : Optional Bool
                              , registry : Text
                              , tenant : Optional Text
                              , user : Optional Text
                              , volume : Text
                              }
                        , rbd =
                            None
                              { fsType : Optional Text
                              , image : Text
                              , keyring : Optional Text
                              , monitors : List Text
                              , pool : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , user : Optional Text
                              }
                        , scaleIO =
                            None
                              { fsType : Optional Text
                              , gateway : Text
                              , protectionDomain : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : { name : Optional Text }
                              , sslEnabled : Optional Bool
                              , storageMode : Optional Text
                              , storagePool : Optional Text
                              , system : Text
                              , volumeName : Optional Text
                              }
                        , secret =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { key : Text
                                        , mode : Optional Natural
                                        , path : Text
                                        }
                                    )
                              , optional : Optional Bool
                              , secretName : Optional Text
                              }
                        , storageos =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , volumeName : Optional Text
                              , volumeNamespace : Optional Text
                              }
                        , vsphereVolume =
                            None
                              { fsType : Optional Text
                              , storagePolicyID : Optional Text
                              , storagePolicyName : Optional Text
                              , volumePath : Text
                              }
                        }
                      , { awsElasticBlockStore =
                            None
                              { fsType : Optional Text
                              , partition : Optional Natural
                              , readOnly : Optional Bool
                              , volumeID : Text
                              }
                        , azureDisk =
                            None
                              { cachingMode : Optional Text
                              , diskName : Text
                              , diskURI : Text
                              , fsType : Optional Text
                              , kind : Text
                              , readOnly : Optional Bool
                              }
                        , azureFile =
                            None
                              { readOnly : Optional Bool
                              , secretName : Text
                              , shareName : Text
                              }
                        , cephfs =
                            None
                              { monitors : List Text
                              , path : Optional Text
                              , readOnly : Optional Bool
                              , secretFile : Optional Text
                              , secretRef : Optional { name : Optional Text }
                              , user : Optional Text
                              }
                        , cinder =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , volumeID : Text
                              }
                        , configMap =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { key : Text
                                        , mode : Optional Natural
                                        , path : Text
                                        }
                                    )
                              , name : Optional Text
                              , optional : Optional Bool
                              }
                        , csi =
                            None
                              { driver : Text
                              , fsType : Optional Text
                              , nodePublishSecretRef :
                                  Optional { name : Optional Text }
                              , readOnly : Optional Bool
                              , volumeAttributes :
                                  Optional
                                    (List { mapKey : Text, mapValue : Text })
                              }
                        , downwardAPI =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { fieldRef :
                                            Optional
                                              { apiVersion : Optional Text
                                              , fieldPath : Text
                                              }
                                        , mode : Optional Natural
                                        , path : Text
                                        , resourceFieldRef :
                                            Optional
                                              { containerName : Optional Text
                                              , divisor : Optional Text
                                              , resource : Text
                                              }
                                        }
                                    )
                              }
                        , emptyDir =
                            None
                              { medium : Optional Text
                              , sizeLimit : Optional Text
                              }
                        , fc =
                            None
                              { fsType : Optional Text
                              , lun : Optional Natural
                              , readOnly : Optional Bool
                              , targetWWNs : Optional (List Text)
                              , wwids : Optional (List Text)
                              }
                        , flexVolume =
                            None
                              { driver : Text
                              , fsType : Optional Text
                              , options :
                                  Optional
                                    (List { mapKey : Text, mapValue : Text })
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              }
                        , flocker =
                            None
                              { datasetName : Optional Text
                              , datasetUUID : Optional Text
                              }
                        , gcePersistentDisk =
                            None
                              { fsType : Optional Text
                              , partition : Optional Natural
                              , pdName : Text
                              , readOnly : Optional Bool
                              }
                        , gitRepo =
                            None
                              { directory : Optional Text
                              , repository : Text
                              , revision : Optional Text
                              }
                        , glusterfs =
                            None
                              { endpoints : Text
                              , path : Text
                              , readOnly : Optional Bool
                              }
                        , hostPath = Some
                          { path = "/dev/disk", type = None Text }
                        , iscsi =
                            None
                              { chapAuthDiscovery : Optional Bool
                              , chapAuthSession : Optional Bool
                              , fsType : Optional Text
                              , initiatorName : Optional Text
                              , iqn : Text
                              , iscsiInterface : Optional Text
                              , lun : Natural
                              , portals : Optional (List Text)
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , targetPortal : Text
                              }
                        , name = "disk"
                        , nfs =
                            None
                              { path : Text
                              , readOnly : Optional Bool
                              , server : Text
                              }
                        , persistentVolumeClaim =
                            None { claimName : Text, readOnly : Optional Bool }
                        , photonPersistentDisk =
                            None { fsType : Optional Text, pdID : Text }
                        , portworxVolume =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , volumeID : Text
                              }
                        , projected =
                            None
                              { defaultMode : Optional Natural
                              , sources :
                                  List
                                    { configMap :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { key : Text
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    }
                                                )
                                          , name : Optional Text
                                          , optional : Optional Bool
                                          }
                                    , downwardAPI :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { fieldRef :
                                                        Optional
                                                          { apiVersion :
                                                              Optional Text
                                                          , fieldPath : Text
                                                          }
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    , resourceFieldRef :
                                                        Optional
                                                          { containerName :
                                                              Optional Text
                                                          , divisor :
                                                              Optional Text
                                                          , resource : Text
                                                          }
                                                    }
                                                )
                                          }
                                    , secret :
                                        Optional
                                          { items :
                                              Optional
                                                ( List
                                                    { key : Text
                                                    , mode : Optional Natural
                                                    , path : Text
                                                    }
                                                )
                                          , name : Optional Text
                                          , optional : Optional Bool
                                          }
                                    , serviceAccountToken :
                                        Optional
                                          { audience : Optional Text
                                          , expirationSeconds : Optional Natural
                                          , path : Text
                                          }
                                    }
                              }
                        , quobyte =
                            None
                              { group : Optional Text
                              , readOnly : Optional Bool
                              , registry : Text
                              , tenant : Optional Text
                              , user : Optional Text
                              , volume : Text
                              }
                        , rbd =
                            None
                              { fsType : Optional Text
                              , image : Text
                              , keyring : Optional Text
                              , monitors : List Text
                              , pool : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , user : Optional Text
                              }
                        , scaleIO =
                            None
                              { fsType : Optional Text
                              , gateway : Text
                              , protectionDomain : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : { name : Optional Text }
                              , sslEnabled : Optional Bool
                              , storageMode : Optional Text
                              , storagePool : Optional Text
                              , system : Text
                              , volumeName : Optional Text
                              }
                        , secret =
                            None
                              { defaultMode : Optional Natural
                              , items :
                                  Optional
                                    ( List
                                        { key : Text
                                        , mode : Optional Natural
                                        , path : Text
                                        }
                                    )
                              , optional : Optional Bool
                              , secretName : Optional Text
                              }
                        , storageos =
                            None
                              { fsType : Optional Text
                              , readOnly : Optional Bool
                              , secretRef : Optional { name : Optional Text }
                              , volumeName : Optional Text
                              , volumeNamespace : Optional Text
                              }
                        , vsphereVolume =
                            None
                              { fsType : Optional Text
                              , storagePolicyID : Optional Text
                              , storagePolicyName : Optional Text
                              , volumePath : Text
                              }
                        }
                      ]
                    }
                  }
                , updateStrategy =
                    None
                      { rollingUpdate :
                          Optional
                            { maxUnavailable :
                                Optional < Int : Natural | String : Text >
                            }
                      , type : Optional Text
                      }
                }
              , status =
                  None
                    { collisionCount : Optional Natural
                    , conditions :
                        Optional
                          ( List
                              { lastTransitionTime : Optional Text
                              , message : Optional Text
                              , reason : Optional Text
                              , status : Text
                              , type : Text
                              }
                          )
                    , currentNumberScheduled : Natural
                    , desiredNumberScheduled : Natural
                    , numberAvailable : Optional Natural
                    , numberMisscheduled : Natural
                    , numberReady : Natural
                    , numberUnavailable : Optional Natural
                    , observedGeneration : Optional Natural
                    , updatedNumberScheduled : Optional Natural
                    }
              }

        in  daemonSet

let ClusterRole/generate =
      λ(c : Configuration/global.Type) →
        let clusterRole =
              Kubernetes/ClusterRole::{
              , aggregationRule =
                  None
                    { clusterRoleSelectors :
                        Optional
                          ( List
                              { matchExpressions :
                                  Optional
                                    ( List
                                        { key : Text
                                        , operator : Text
                                        , values : Optional (List Text)
                                        }
                                    )
                              , matchLabels :
                                  Optional
                                    (List { mapKey : Text, mapValue : Text })
                              }
                          )
                    }
              , apiVersion = "rbac.authorization.k8s.io/v1"
              , kind = "ClusterRole"
              , metadata =
                { annotations = None (List { mapKey : Text, mapValue : Text })
                , clusterName = None Text
                , creationTimestamp = None Text
                , deletionGracePeriodSeconds = None Natural
                , deletionTimestamp = None Text
                , finalizers = None (List Text)
                , generateName = None Text
                , generation = None Natural
                , labels = Some
                    ( toMap
                        { sourcegraph-resource-requires = "cluster-admin"
                        , category = "rbac"
                        , app = "cadvisor"
                        , deploy = "sourcegraph"
                        }
                    )
                , managedFields =
                    None
                      ( List
                          { apiVersion : Text
                          , fieldsType : Optional Text
                          , fieldsV1 :
                              Optional (List { mapKey : Text, mapValue : Text })
                          , manager : Optional Text
                          , operation : Optional Text
                          , time : Optional Text
                          }
                      )
                , name = Some "cadvisor"
                , namespace = None Text
                , ownerReferences =
                    None
                      ( List
                          { apiVersion : Text
                          , blockOwnerDeletion : Optional Bool
                          , controller : Optional Bool
                          , kind : Text
                          , name : Text
                          , uid : Text
                          }
                      )
                , resourceVersion = None Text
                , selfLink = None Text
                , uid = None Text
                }
              , rules = Some
                [ { apiGroups = Some [ "policy" ]
                  , nonResourceURLs = None (List Text)
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
              Kubernetes/ClusterRoleBinding::{
              , apiVersion = "rbac.authorization.k8s.io/v1"
              , kind = "ClusterRoleBinding"
              , metadata =
                { annotations = None (List { mapKey : Text, mapValue : Text })
                , clusterName = None Text
                , creationTimestamp = None Text
                , deletionGracePeriodSeconds = None Natural
                , deletionTimestamp = None Text
                , finalizers = None (List Text)
                , generateName = None Text
                , generation = None Natural
                , labels = Some
                    ( toMap
                        { sourcegraph-resource-requires = "cluster-admin"
                        , category = "rbac"
                        , app = "cadvisor"
                        , deploy = "sourcegraph"
                        }
                    )
                , managedFields =
                    None
                      ( List
                          { apiVersion : Text
                          , fieldsType : Optional Text
                          , fieldsV1 :
                              Optional (List { mapKey : Text, mapValue : Text })
                          , manager : Optional Text
                          , operation : Optional Text
                          , time : Optional Text
                          }
                      )
                , name = Some "cadvisor"
                , namespace = None Text
                , ownerReferences =
                    None
                      ( List
                          { apiVersion : Text
                          , blockOwnerDeletion : Optional Bool
                          , controller : Optional Bool
                          , kind : Text
                          , name : Text
                          , uid : Text
                          }
                      )
                , resourceVersion = None Text
                , selfLink = None Text
                , uid = None Text
                }
              , roleRef =
                { apiGroup = "rbac.authorization.k8s.io"
                , kind = "ClusterRole"
                , name = "cadvisor"
                }
              , subjects = Some
                [ { apiGroup = None Text
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
              Kubernetes/ServiceAccount::{
              , apiVersion = "v1"
              , automountServiceAccountToken = None Bool
              , imagePullSecrets = None (List { name : Optional Text })
              , kind = "ServiceAccount"
              , metadata =
                { annotations = None (List { mapKey : Text, mapValue : Text })
                , clusterName = None Text
                , creationTimestamp = None Text
                , deletionGracePeriodSeconds = None Natural
                , deletionTimestamp = None Text
                , finalizers = None (List Text)
                , generateName = None Text
                , generation = None Natural
                , labels = Some
                    ( toMap
                        { sourcegraph-resource-requires = "cluster-admin"
                        , category = "rbac"
                        , app = "cadvisor"
                        , deploy = "sourcegraph"
                        }
                    )
                , managedFields =
                    None
                      ( List
                          { apiVersion : Text
                          , fieldsType : Optional Text
                          , fieldsV1 :
                              Optional (List { mapKey : Text, mapValue : Text })
                          , manager : Optional Text
                          , operation : Optional Text
                          , time : Optional Text
                          }
                      )
                , name = Some "cadvisor"
                , namespace = None Text
                , ownerReferences =
                    None
                      ( List
                          { apiVersion : Text
                          , blockOwnerDeletion : Optional Bool
                          , controller : Optional Bool
                          , kind : Text
                          , name : Text
                          , uid : Text
                          }
                      )
                , resourceVersion = None Text
                , selfLink = None Text
                , uid = None Text
                }
              , secrets =
                  None
                    ( List
                        { apiVersion : Text
                        , fieldPath : Optional Text
                        , kind : Text
                        , name : Optional Text
                        , namespace : Optional Text
                        , resourceVersion : Optional Text
                        , uid : Optional Text
                        }
                    )
              }

        in  serviceAccount

let PodSecurityPolicy/generate =
      λ(c : Configuration/global.Type) →
        let podSecurityPolicy =
              Kubernetes/PodSecurityPolicy::{
              , apiVersion = "policy/v1beta1"
              , kind = "PodSecurityPolicy"
              , metadata =
                { annotations = None (List { mapKey : Text, mapValue : Text })
                , clusterName = None Text
                , creationTimestamp = None Text
                , deletionGracePeriodSeconds = None Natural
                , deletionTimestamp = None Text
                , finalizers = None (List Text)
                , generateName = None Text
                , generation = None Natural
                , labels = Some
                    ( toMap
                        { sourcegraph-resource-requires = "cluster-admin"
                        , app = "cadvisor"
                        , deploy = "sourcegraph"
                        }
                    )
                , managedFields =
                    None
                      ( List
                          { apiVersion : Text
                          , fieldsType : Optional Text
                          , fieldsV1 :
                              Optional (List { mapKey : Text, mapValue : Text })
                          , manager : Optional Text
                          , operation : Optional Text
                          , time : Optional Text
                          }
                      )
                , name = Some "cadvisor"
                , namespace = None Text
                , ownerReferences =
                    None
                      ( List
                          { apiVersion : Text
                          , blockOwnerDeletion : Optional Bool
                          , controller : Optional Bool
                          , kind : Text
                          , name : Text
                          , uid : Text
                          }
                      )
                , resourceVersion = None Text
                , selfLink = None Text
                , uid = None Text
                }
              , spec = Some
                { allowPrivilegeEscalation = None Bool
                , allowedCSIDrivers = None (List { name : Text })
                , allowedCapabilities = None (List Text)
                , allowedFlexVolumes = None (List { driver : Text })
                , allowedHostPaths = Some
                  [ { pathPrefix = Some "/", readOnly = None Bool }
                  , { pathPrefix = Some "/var/run", readOnly = None Bool }
                  , { pathPrefix = Some "/sys", readOnly = None Bool }
                  , { pathPrefix = Some "/var/lib/docker"
                    , readOnly = None Bool
                    }
                  , { pathPrefix = Some "/dev/disk", readOnly = None Bool }
                  ]
                , allowedProcMountTypes = None (List Text)
                , allowedUnsafeSysctls = None (List Text)
                , defaultAddCapabilities = None (List Text)
                , defaultAllowPrivilegeEscalation = None Bool
                , forbiddenSysctls = None (List Text)
                , fsGroup =
                  { ranges = None (List { max : Natural, min : Natural })
                  , rule = Some "RunAsAny"
                  }
                , hostIPC = None Bool
                , hostNetwork = None Bool
                , hostPID = None Bool
                , hostPorts = None (List { max : Natural, min : Natural })
                , privileged = None Bool
                , readOnlyRootFilesystem = None Bool
                , requiredDropCapabilities = None (List Text)
                , runAsGroup =
                    None
                      { ranges :
                          Optional (List { max : Natural, min : Natural })
                      , rule : Text
                      }
                , runAsUser =
                  { ranges = None (List { max : Natural, min : Natural })
                  , rule = "RunAsAny"
                  }
                , runtimeClass =
                    None
                      { allowedRuntimeClassNames : List Text
                      , defaultRuntimeClassName : Optional Text
                      }
                , seLinux =
                  { rule = "RunAsAny"
                  , seLinuxOptions =
                      None
                        { level : Optional Text
                        , role : Optional Text
                        , type : Optional Text
                        , user : Optional Text
                        }
                  }
                , supplementalGroups =
                  { ranges = None (List { max : Natural, min : Natural })
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

let ToList =
        ( λ(c : Component) →
            Kubernetes/List::{
            , items =
              [ Kubernetes/TypesUnion.DaemonSet c.DaemonSet
              , Kubernetes/TypesUnion.ClusterRole c.ClusterRole
              , Kubernetes/TypesUnion.ClusterRoleBinding c.ClusterRoleBinding
              , Kubernetes/TypesUnion.PodSecurityPolicy c.PodSecurityPolicy
              , Kubernetes/TypesUnion.ServiceAccount c.ServiceAccount
              ]
            }
        )
      : ∀(c : Component) → Kubernetes/List.Type

let Render =
        (λ(c : Configuration/global.Type) → ToList (Generate c))
      : ∀(c : Configuration/global.Type) → Kubernetes/List.Type

in  { Render, Generate }
