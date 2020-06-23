let Kubernetes/Deployment =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.Deployment.dhall

let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let Configuration/global = ../../configuration/global.dhall

let component =
      { Deployment : Kubernetes/Deployment.Type
      , Service : Kubernetes/Service.Type
      }

let Service/generate =
      λ(c : Configuration/global.Type) →
        let service =
              Kubernetes/Service::{
              , apiVersion = "v1"
              , kind = "Service"
              , metadata =
                { annotations = Some
                    ( toMap
                        { `sourcegraph.prometheus/scrape` = "true"
                        , `prometheus.io/port` = "6060"
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
                        { sourcegraph-resource-requires = "no-cluster-admin"
                        , app = "repo-updater"
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
                , name = Some "repo-updater"
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
                { clusterIP = None Text
                , externalIPs = None (List Text)
                , externalName = None Text
                , externalTrafficPolicy = None Text
                , healthCheckNodePort = None Natural
                , ipFamily = None Text
                , loadBalancerIP = None Text
                , loadBalancerSourceRanges = None (List Text)
                , ports = Some
                  [ { name = Some "http"
                    , nodePort = None Natural
                    , port = 3182
                    , protocol = None Text
                    , targetPort = Some
                        (< Int : Natural | String : Text >.String "http")
                    }
                  ]
                , publishNotReadyAddresses = None Bool
                , selector = Some (toMap { app = "repo-updater" })
                , sessionAffinity = None Text
                , sessionAffinityConfig =
                    None
                      { clientIP :
                          Optional { timeoutSeconds : Optional Natural }
                      }
                , topologyKeys = None (List Text)
                , type = Some "ClusterIP"
                }
              , status =
                  None
                    { loadBalancer :
                        Optional
                          { ingress :
                              Optional
                                ( List
                                    { hostname : Optional Text
                                    , ip : Optional Text
                                    }
                                )
                          }
                    }
              }

        in  service

let Deployment/generate =
      λ(c : Configuration/global.Type) →
        let deployment =
              Kubernetes/Deployment::{
              , apiVersion = "apps/v1"
              , kind = "Deployment"
              , metadata =
                { annotations = Some
                    ( toMap
                        { description =
                            "Handles repository metadata (not Git data) lookups and updates from external code hosts and other similar services."
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
                        { sourcegraph-resource-requires = "no-cluster-admin"
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
                , name = Some "repo-updater"
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
                { minReadySeconds = Some 10
                , paused = None Bool
                , progressDeadlineSeconds = None Natural
                , replicas = Some 1
                , revisionHistoryLimit = Some 10
                , selector =
                  { matchExpressions =
                      None
                        ( List
                            { key : Text
                            , operator : Text
                            , values : Optional (List Text)
                            }
                        )
                  , matchLabels = Some (toMap { app = "repo-updater" })
                  }
                , strategy = Some
                  { rollingUpdate = Some
                    { maxSurge = Some (< Int : Natural | String : Text >.Int 1)
                    , maxUnavailable = Some
                        (< Int : Natural | String : Text >.Int 0)
                    }
                  , type = Some "RollingUpdate"
                  }
                , template =
                  { metadata =
                    { annotations =
                        None (List { mapKey : Text, mapValue : Text })
                    , clusterName = None Text
                    , creationTimestamp = None Text
                    , deletionGracePeriodSeconds = None Natural
                    , deletionTimestamp = None Text
                    , finalizers = None (List Text)
                    , generateName = None Text
                    , generation = None Natural
                    , labels = Some
                        (toMap { app = "repo-updater", deploy = "sourcegraph" })
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
                    , automountServiceAccountToken = None Bool
                    , containers =
                      [ { args = None (List Text)
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
                            "index.docker.io/sourcegraph/repo-updater:3.16.1@sha256:daa3445e601b7fcba2f4a7b790e5e439a1b6c460034dc0c1f372654fd25800bc"
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
                        , name = "repo-updater"
                        , ports = Some
                          [ { containerPort = 3182
                            , hostIP = None Text
                            , hostPort = None Natural
                            , name = Some "http"
                            , protocol = None Text
                            }
                          , { containerPort = 6060
                            , hostIP = None Text
                            , hostPort = None Natural
                            , name = Some "debug"
                            , protocol = None Text
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
                              (toMap { memory = "500Mi", cpu = "100m" })
                          , requests = Some
                              (toMap { memory = "500Mi", cpu = "100m" })
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
                        , terminationMessagePolicy = Some
                            "FallbackToLogsOnError"
                        , tty = None Bool
                        , volumeDevices =
                            None (List { devicePath : Text, name : Text })
                        , volumeMounts =
                            None
                              ( List
                                  { mountPath : Text
                                  , mountPropagation : Optional Text
                                  , name : Text
                                  , readOnly : Optional Bool
                                  , subPath : Optional Text
                                  , subPathExpr : Optional Text
                                  }
                              )
                        , workingDir = None Text
                        }
                      , { args = Some
                          [ "--reporter.grpc.host-port=jaeger-collector:14250"
                          , "--reporter.type=grpc"
                          ]
                        , command = None (List Text)
                        , env = Some
                          [ { name = "POD_NAME"
                            , value = None Text
                            , valueFrom = Some
                              { configMapKeyRef =
                                  None
                                    { key : Text
                                    , name : Optional Text
                                    , optional : Optional Bool
                                    }
                              , fieldRef = Some
                                { apiVersion = Some "v1"
                                , fieldPath = "metadata.name"
                                }
                              , resourceFieldRef =
                                  None
                                    { containerName : Optional Text
                                    , divisor : Optional Text
                                    , resource : Text
                                    }
                              , secretKeyRef =
                                  None
                                    { key : Text
                                    , name : Optional Text
                                    , optional : Optional Bool
                                    }
                              }
                            }
                          ]
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
                            "index.docker.io/sourcegraph/jaeger-agent:3.16.1@sha256:2fc0cdd7db449e411a01a6ba175ad0b33f8515c343edd7c19569e6f87c6f7fe2"
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
                        , name = "jaeger-agent"
                        , ports = Some
                          [ { containerPort = 5775
                            , hostIP = None Text
                            , hostPort = None Natural
                            , name = None Text
                            , protocol = Some "UDP"
                            }
                          , { containerPort = 5778
                            , hostIP = None Text
                            , hostPort = None Natural
                            , name = None Text
                            , protocol = Some "TCP"
                            }
                          , { containerPort = 6831
                            , hostIP = None Text
                            , hostPort = None Natural
                            , name = None Text
                            , protocol = Some "UDP"
                            }
                          , { containerPort = 6832
                            , hostIP = None Text
                            , hostPort = None Natural
                            , name = None Text
                            , protocol = Some "UDP"
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
                          { limits = Some (toMap { memory = "500M", cpu = "1" })
                          , requests = Some
                              (toMap { memory = "100M", cpu = "100m" })
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
                        , volumeMounts =
                            None
                              ( List
                                  { mountPath : Text
                                  , mountPropagation : Optional Text
                                  , name : Text
                                  , readOnly : Optional Bool
                                  , subPath : Optional Text
                                  , subPathExpr : Optional Text
                                  }
                              )
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
                    , securityContext = Some
                      { fsGroup = None Natural
                      , runAsGroup = None Natural
                      , runAsNonRoot = None Bool
                      , runAsUser = Some 0
                      , seLinuxOptions =
                          None
                            { level : Optional Text
                            , role : Optional Text
                            , type : Optional Text
                            , user : Optional Text
                            }
                      , supplementalGroups = None (List Natural)
                      , sysctls = None (List { name : Text, value : Text })
                      , windowsOptions =
                          None
                            { gmsaCredentialSpec : Optional Text
                            , gmsaCredentialSpecName : Optional Text
                            , runAsUserName : Optional Text
                            }
                      }
                    , serviceAccount = None Text
                    , serviceAccountName = None Text
                    , shareProcessNamespace = None Bool
                    , subdomain = None Text
                    , terminationGracePeriodSeconds = None Natural
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
                    , volumes =
                        None
                          ( List
                              { awsElasticBlockStore :
                                  Optional
                                    { fsType : Optional Text
                                    , partition : Optional Natural
                                    , readOnly : Optional Bool
                                    , volumeID : Text
                                    }
                              , azureDisk :
                                  Optional
                                    { cachingMode : Optional Text
                                    , diskName : Text
                                    , diskURI : Text
                                    , fsType : Optional Text
                                    , kind : Text
                                    , readOnly : Optional Bool
                                    }
                              , azureFile :
                                  Optional
                                    { readOnly : Optional Bool
                                    , secretName : Text
                                    , shareName : Text
                                    }
                              , cephfs :
                                  Optional
                                    { monitors : List Text
                                    , path : Optional Text
                                    , readOnly : Optional Bool
                                    , secretFile : Optional Text
                                    , secretRef :
                                        Optional { name : Optional Text }
                                    , user : Optional Text
                                    }
                              , cinder :
                                  Optional
                                    { fsType : Optional Text
                                    , readOnly : Optional Bool
                                    , secretRef :
                                        Optional { name : Optional Text }
                                    , volumeID : Text
                                    }
                              , configMap :
                                  Optional
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
                              , csi :
                                  Optional
                                    { driver : Text
                                    , fsType : Optional Text
                                    , nodePublishSecretRef :
                                        Optional { name : Optional Text }
                                    , readOnly : Optional Bool
                                    , volumeAttributes :
                                        Optional
                                          ( List
                                              { mapKey : Text, mapValue : Text }
                                          )
                                    }
                              , downwardAPI :
                                  Optional
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
                                                    { containerName :
                                                        Optional Text
                                                    , divisor : Optional Text
                                                    , resource : Text
                                                    }
                                              }
                                          )
                                    }
                              , emptyDir :
                                  Optional
                                    { medium : Optional Text
                                    , sizeLimit : Optional Text
                                    }
                              , fc :
                                  Optional
                                    { fsType : Optional Text
                                    , lun : Optional Natural
                                    , readOnly : Optional Bool
                                    , targetWWNs : Optional (List Text)
                                    , wwids : Optional (List Text)
                                    }
                              , flexVolume :
                                  Optional
                                    { driver : Text
                                    , fsType : Optional Text
                                    , options :
                                        Optional
                                          ( List
                                              { mapKey : Text, mapValue : Text }
                                          )
                                    , readOnly : Optional Bool
                                    , secretRef :
                                        Optional { name : Optional Text }
                                    }
                              , flocker :
                                  Optional
                                    { datasetName : Optional Text
                                    , datasetUUID : Optional Text
                                    }
                              , gcePersistentDisk :
                                  Optional
                                    { fsType : Optional Text
                                    , partition : Optional Natural
                                    , pdName : Text
                                    , readOnly : Optional Bool
                                    }
                              , gitRepo :
                                  Optional
                                    { directory : Optional Text
                                    , repository : Text
                                    , revision : Optional Text
                                    }
                              , glusterfs :
                                  Optional
                                    { endpoints : Text
                                    , path : Text
                                    , readOnly : Optional Bool
                                    }
                              , hostPath :
                                  Optional { path : Text, type : Optional Text }
                              , iscsi :
                                  Optional
                                    { chapAuthDiscovery : Optional Bool
                                    , chapAuthSession : Optional Bool
                                    , fsType : Optional Text
                                    , initiatorName : Optional Text
                                    , iqn : Text
                                    , iscsiInterface : Optional Text
                                    , lun : Natural
                                    , portals : Optional (List Text)
                                    , readOnly : Optional Bool
                                    , secretRef :
                                        Optional { name : Optional Text }
                                    , targetPortal : Text
                                    }
                              , name : Text
                              , nfs :
                                  Optional
                                    { path : Text
                                    , readOnly : Optional Bool
                                    , server : Text
                                    }
                              , persistentVolumeClaim :
                                  Optional
                                    { claimName : Text
                                    , readOnly : Optional Bool
                                    }
                              , photonPersistentDisk :
                                  Optional
                                    { fsType : Optional Text, pdID : Text }
                              , portworxVolume :
                                  Optional
                                    { fsType : Optional Text
                                    , readOnly : Optional Bool
                                    , volumeID : Text
                                    }
                              , projected :
                                  Optional
                                    { defaultMode : Optional Natural
                                    , sources :
                                        List
                                          { configMap :
                                              Optional
                                                { items :
                                                    Optional
                                                      ( List
                                                          { key : Text
                                                          , mode :
                                                              Optional Natural
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
                                                                    Optional
                                                                      Text
                                                                , fieldPath :
                                                                    Text
                                                                }
                                                          , mode :
                                                              Optional Natural
                                                          , path : Text
                                                          , resourceFieldRef :
                                                              Optional
                                                                { containerName :
                                                                    Optional
                                                                      Text
                                                                , divisor :
                                                                    Optional
                                                                      Text
                                                                , resource :
                                                                    Text
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
                                                          , mode :
                                                              Optional Natural
                                                          , path : Text
                                                          }
                                                      )
                                                , name : Optional Text
                                                , optional : Optional Bool
                                                }
                                          , serviceAccountToken :
                                              Optional
                                                { audience : Optional Text
                                                , expirationSeconds :
                                                    Optional Natural
                                                , path : Text
                                                }
                                          }
                                    }
                              , quobyte :
                                  Optional
                                    { group : Optional Text
                                    , readOnly : Optional Bool
                                    , registry : Text
                                    , tenant : Optional Text
                                    , user : Optional Text
                                    , volume : Text
                                    }
                              , rbd :
                                  Optional
                                    { fsType : Optional Text
                                    , image : Text
                                    , keyring : Optional Text
                                    , monitors : List Text
                                    , pool : Optional Text
                                    , readOnly : Optional Bool
                                    , secretRef :
                                        Optional { name : Optional Text }
                                    , user : Optional Text
                                    }
                              , scaleIO :
                                  Optional
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
                              , secret :
                                  Optional
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
                              , storageos :
                                  Optional
                                    { fsType : Optional Text
                                    , readOnly : Optional Bool
                                    , secretRef :
                                        Optional { name : Optional Text }
                                    , volumeName : Optional Text
                                    , volumeNamespace : Optional Text
                                    }
                              , vsphereVolume :
                                  Optional
                                    { fsType : Optional Text
                                    , storagePolicyID : Optional Text
                                    , storagePolicyName : Optional Text
                                    , volumePath : Text
                                    }
                              }
                          )
                    }
                  }
                }
              , status =
                  None
                    { availableReplicas : Optional Natural
                    , collisionCount : Optional Natural
                    , conditions :
                        Optional
                          ( List
                              { lastTransitionTime : Optional Text
                              , lastUpdateTime : Optional Text
                              , message : Optional Text
                              , reason : Optional Text
                              , status : Text
                              , type : Text
                              }
                          )
                    , observedGeneration : Optional Natural
                    , readyReplicas : Optional Natural
                    , replicas : Optional Natural
                    , unavailableReplicas : Optional Natural
                    , updatedReplicas : Optional Natural
                    }
              }

        in  deployment

let Generate =
        ( λ(c : Configuration/global.Type) →
            { Deployment = Deployment/generate c, Service = Service/generate c }
        )
      : ∀(c : Configuration/global.Type) → component

let ToList =
        ( λ(c : component) →
            Kubernetes/List::{
            , items =
              [ Kubernetes/TypesUnion.Deployment c.Deployment
              , Kubernetes/TypesUnion.Service c.Service
              ]
            }
        )
      : ∀(c : component) → Kubernetes/List.Type

let Render =
        (λ(c : Configuration/global.Type) → ToList (Generate c))
      : ∀(c : Configuration/global.Type) → Kubernetes/List.Type

in  Render
