let schemas = ../../k8s/schemas.dhall

in  { admission-webhook =
      { ClusterRole.ingress-nginx-admission = schemas.ClusterRole::{
        , metadata = schemas.ObjectMeta::{
          , annotations = Some
            [ { mapKey = "helm.sh/hook"
              , mapValue = "pre-install,pre-upgrade,post-install,post-upgrade"
              }
            , { mapKey = "helm.sh/hook-delete-policy"
              , mapValue = "before-hook-creation,hook-succeeded"
              }
            ]
          , labels = Some
            [ { mapKey = "app.kubernetes.io/component"
              , mapValue = "admission-webhook"
              }
            , { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx-admission"
          , namespace = Some "ingress-nginx"
          }
        , rules = Some
          [ schemas.PolicyRule::{
            , apiGroups = Some [ "admissionregistration.k8s.io" ]
            , resources = Some [ "validatingwebhookconfigurations" ]
            , verbs = [ "get", "update" ]
            }
          ]
        }
      , ClusterRoleBinding.ingress-nginx-admission = schemas.RoleBinding::{
        , kind = "ClusterRoleBinding"
        , metadata = schemas.ObjectMeta::{
          , annotations = Some
            [ { mapKey = "helm.sh/hook"
              , mapValue = "pre-install,pre-upgrade,post-install,post-upgrade"
              }
            , { mapKey = "helm.sh/hook-delete-policy"
              , mapValue = "before-hook-creation,hook-succeeded"
              }
            ]
          , labels = Some
            [ { mapKey = "app.kubernetes.io/component"
              , mapValue = "admission-webhook"
              }
            , { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx-admission"
          , namespace = Some "ingress-nginx"
          }
        , roleRef = schemas.RoleRef::{
          , apiGroup = "rbac.authorization.k8s.io"
          , kind = "ClusterRole"
          , name = "ingress-nginx-admission"
          }
        , subjects = Some
          [ schemas.Subject::{
            , kind = "ServiceAccount"
            , name = "ingress-nginx-admission"
            , namespace = Some "ingress-nginx"
            }
          ]
        }
      , Job =
        { ingress-nginx-admission-create = schemas.Job::{
          , metadata = schemas.ObjectMeta::{
            , annotations = Some
              [ { mapKey = "helm.sh/hook"
                , mapValue = "pre-install,pre-upgrade"
                }
              , { mapKey = "helm.sh/hook-delete-policy"
                , mapValue = "before-hook-creation,hook-succeeded"
                }
              ]
            , labels = Some
              [ { mapKey = "app.kubernetes.io/component"
                , mapValue = "admission-webhook"
                }
              , { mapKey = "app.kubernetes.io/instance"
                , mapValue = "ingress-nginx"
                }
              , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
              , { mapKey = "app.kubernetes.io/name"
                , mapValue = "ingress-nginx"
                }
              , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
              , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
              ]
            , name = Some "ingress-nginx-admission-create"
            , namespace = Some "ingress-nginx"
            }
          , spec = Some schemas.JobSpec::{
            , template = schemas.PodTemplateSpec::{
              , metadata = schemas.ObjectMeta::{
                , labels = Some
                  [ { mapKey = "app.kubernetes.io/component"
                    , mapValue = "admission-webhook"
                    }
                  , { mapKey = "app.kubernetes.io/instance"
                    , mapValue = "ingress-nginx"
                    }
                  , { mapKey = "app.kubernetes.io/managed-by"
                    , mapValue = "Helm"
                    }
                  , { mapKey = "app.kubernetes.io/name"
                    , mapValue = "ingress-nginx"
                    }
                  , { mapKey = "app.kubernetes.io/version"
                    , mapValue = "0.34.1"
                    }
                  , { mapKey = "helm.sh/chart"
                    , mapValue = "ingress-nginx-2.11.1"
                    }
                  ]
                , name = Some "ingress-nginx-admission-create"
                }
              , spec = Some schemas.PodSpec::{
                , containers =
                  [ schemas.Container::{
                    , args = Some
                      [ "create"
                      , "--host=ingress-nginx-controller-admission,ingress-nginx-controller-admission.ingress-nginx.svc"
                      , "--namespace=ingress-nginx"
                      , "--secret-name=ingress-nginx-admission"
                      ]
                    , image = Some
                        "docker.io/jettech/kube-webhook-certgen:v1.2.2"
                    , imagePullPolicy = Some "IfNotPresent"
                    , name = "create"
                    }
                  ]
                , restartPolicy = Some "OnFailure"
                , securityContext = Some schemas.PodSecurityContext::{
                  , runAsNonRoot = Some True
                  , runAsUser = Some 2000
                  }
                , serviceAccountName = Some "ingress-nginx-admission"
                }
              }
            }
          }
        , ingress-nginx-admission-patch = schemas.Job::{
          , metadata = schemas.ObjectMeta::{
            , annotations = Some
              [ { mapKey = "helm.sh/hook"
                , mapValue = "post-install,post-upgrade"
                }
              , { mapKey = "helm.sh/hook-delete-policy"
                , mapValue = "before-hook-creation,hook-succeeded"
                }
              ]
            , labels = Some
              [ { mapKey = "app.kubernetes.io/component"
                , mapValue = "admission-webhook"
                }
              , { mapKey = "app.kubernetes.io/instance"
                , mapValue = "ingress-nginx"
                }
              , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
              , { mapKey = "app.kubernetes.io/name"
                , mapValue = "ingress-nginx"
                }
              , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
              , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
              ]
            , name = Some "ingress-nginx-admission-patch"
            , namespace = Some "ingress-nginx"
            }
          , spec = Some schemas.JobSpec::{
            , template = schemas.PodTemplateSpec::{
              , metadata = schemas.ObjectMeta::{
                , labels = Some
                  [ { mapKey = "app.kubernetes.io/component"
                    , mapValue = "admission-webhook"
                    }
                  , { mapKey = "app.kubernetes.io/instance"
                    , mapValue = "ingress-nginx"
                    }
                  , { mapKey = "app.kubernetes.io/managed-by"
                    , mapValue = "Helm"
                    }
                  , { mapKey = "app.kubernetes.io/name"
                    , mapValue = "ingress-nginx"
                    }
                  , { mapKey = "app.kubernetes.io/version"
                    , mapValue = "0.34.1"
                    }
                  , { mapKey = "helm.sh/chart"
                    , mapValue = "ingress-nginx-2.11.1"
                    }
                  ]
                , name = Some "ingress-nginx-admission-patch"
                }
              , spec = Some schemas.PodSpec::{
                , containers =
                  [ schemas.Container::{
                    , args = Some
                      [ "patch"
                      , "--webhook-name=ingress-nginx-admission"
                      , "--namespace=ingress-nginx"
                      , "--patch-mutating=false"
                      , "--secret-name=ingress-nginx-admission"
                      , "--patch-failure-policy=Fail"
                      ]
                    , image = Some
                        "docker.io/jettech/kube-webhook-certgen:v1.2.2"
                    , imagePullPolicy = Some "IfNotPresent"
                    , name = "patch"
                    }
                  ]
                , restartPolicy = Some "OnFailure"
                , securityContext = Some schemas.PodSecurityContext::{
                  , runAsNonRoot = Some True
                  , runAsUser = Some 2000
                  }
                , serviceAccountName = Some "ingress-nginx-admission"
                }
              }
            }
          }
        }
      , Role.ingress-nginx-admission = schemas.Role::{
        , metadata = schemas.ObjectMeta::{
          , annotations = Some
            [ { mapKey = "helm.sh/hook"
              , mapValue = "pre-install,pre-upgrade,post-install,post-upgrade"
              }
            , { mapKey = "helm.sh/hook-delete-policy"
              , mapValue = "before-hook-creation,hook-succeeded"
              }
            ]
          , labels = Some
            [ { mapKey = "app.kubernetes.io/component"
              , mapValue = "admission-webhook"
              }
            , { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx-admission"
          , namespace = Some "ingress-nginx"
          }
        , rules = Some
          [ schemas.PolicyRule::{
            , apiGroups = Some [ "" ]
            , resources = Some [ "secrets" ]
            , verbs = [ "get", "create" ]
            }
          ]
        }
      , RoleBinding.ingress-nginx-admission = schemas.RoleBinding::{
        , metadata = schemas.ObjectMeta::{
          , annotations = Some
            [ { mapKey = "helm.sh/hook"
              , mapValue = "pre-install,pre-upgrade,post-install,post-upgrade"
              }
            , { mapKey = "helm.sh/hook-delete-policy"
              , mapValue = "before-hook-creation,hook-succeeded"
              }
            ]
          , labels = Some
            [ { mapKey = "app.kubernetes.io/component"
              , mapValue = "admission-webhook"
              }
            , { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx-admission"
          , namespace = Some "ingress-nginx"
          }
        , roleRef = schemas.RoleRef::{
          , apiGroup = "rbac.authorization.k8s.io"
          , kind = "Role"
          , name = "ingress-nginx-admission"
          }
        , subjects = Some
          [ schemas.Subject::{
            , kind = "ServiceAccount"
            , name = "ingress-nginx-admission"
            , namespace = Some "ingress-nginx"
            }
          ]
        }
      , ServiceAccount.ingress-nginx-admission = schemas.ServiceAccount::{
        , metadata = schemas.ObjectMeta::{
          , annotations = Some
            [ { mapKey = "helm.sh/hook"
              , mapValue = "pre-install,pre-upgrade,post-install,post-upgrade"
              }
            , { mapKey = "helm.sh/hook-delete-policy"
              , mapValue = "before-hook-creation,hook-succeeded"
              }
            ]
          , labels = Some
            [ { mapKey = "app.kubernetes.io/component"
              , mapValue = "admission-webhook"
              }
            , { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx-admission"
          , namespace = Some "ingress-nginx"
          }
        }
      , ValidatingWebhookConfiguration.ingress-nginx-admission = schemas.ValidatingWebhookConfiguration::{
        , apiVersion = "admissionregistration.k8s.io/v1beta1"
        , metadata = schemas.ObjectMeta::{
          , labels = Some
            [ { mapKey = "app.kubernetes.io/component"
              , mapValue = "admission-webhook"
              }
            , { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx-admission"
          , namespace = Some "ingress-nginx"
          }
        , webhooks = Some
          [ schemas.ValidatingWebhook::{
            , admissionReviewVersions = [ "v1", "v1beta1" ]
            , clientConfig = schemas.WebhookClientConfig::{
              , service = Some
                { name = "ingress-nginx-controller-admission"
                , namespace = "ingress-nginx"
                , path = Some "/extensions/v1beta1/ingresses"
                , port = None Natural
                }
              }
            , failurePolicy = Some "Fail"
            , name = "validate.nginx.ingress.kubernetes.io"
            , rules = Some
              [ schemas.RuleWithOperations::{
                , apiGroups = Some [ "extensions", "networking.k8s.io" ]
                , apiVersions = Some [ "v1beta1" ]
                , operations = Some [ "CREATE", "UPDATE" ]
                , resources = Some [ "ingresses" ]
                }
              ]
            , sideEffects = "None"
            }
          ]
        }
      }
    , controller =
      { ConfigMap.ingress-nginx-controller = schemas.ConfigMap::{
        , metadata = schemas.ObjectMeta::{
          , labels = Some
            [ { mapKey = "app.kubernetes.io/component"
              , mapValue = "controller"
              }
            , { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx-controller"
          , namespace = Some "ingress-nginx"
          }
        }
      , Deployment.ingress-nginx-controller = schemas.Deployment::{
        , metadata = schemas.ObjectMeta::{
          , labels = Some
            [ { mapKey = "app.kubernetes.io/component"
              , mapValue = "controller"
              }
            , { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx-controller"
          , namespace = Some "ingress-nginx"
          }
        , spec = Some schemas.DeploymentSpec::{
          , minReadySeconds = Some 0
          , revisionHistoryLimit = Some 10
          , selector = schemas.LabelSelector::{
            , matchLabels = Some
              [ { mapKey = "app.kubernetes.io/component"
                , mapValue = "controller"
                }
              , { mapKey = "app.kubernetes.io/instance"
                , mapValue = "ingress-nginx"
                }
              , { mapKey = "app.kubernetes.io/name"
                , mapValue = "ingress-nginx"
                }
              ]
            }
          , template = schemas.PodTemplateSpec::{
            , metadata = schemas.ObjectMeta::{
              , labels = Some
                [ { mapKey = "app.kubernetes.io/component"
                  , mapValue = "controller"
                  }
                , { mapKey = "app.kubernetes.io/instance"
                  , mapValue = "ingress-nginx"
                  }
                , { mapKey = "app.kubernetes.io/name"
                  , mapValue = "ingress-nginx"
                  }
                ]
              }
            , spec = Some schemas.PodSpec::{
              , containers =
                [ schemas.Container::{
                  , args = Some
                    [ "/nginx-ingress-controller"
                    , "--publish-service=ingress-nginx/ingress-nginx-controller"
                    , "--election-id=ingress-controller-leader"
                    , "--ingress-class=nginx"
                    , "--configmap=ingress-nginx/ingress-nginx-controller"
                    , "--validating-webhook=:8443"
                    , "--validating-webhook-certificate=/usr/local/certificates/cert"
                    , "--validating-webhook-key=/usr/local/certificates/key"
                    ]
                  , env = Some
                    [ schemas.EnvVar::{
                      , name = "POD_NAME"
                      , valueFrom = Some schemas.EnvVarSource::{
                        , fieldRef = Some schemas.ObjectFieldSelector::{
                          , fieldPath = "metadata.name"
                          }
                        }
                      }
                    , schemas.EnvVar::{
                      , name = "POD_NAMESPACE"
                      , valueFrom = Some schemas.EnvVarSource::{
                        , fieldRef = Some schemas.ObjectFieldSelector::{
                          , fieldPath = "metadata.namespace"
                          }
                        }
                      }
                    ]
                  , image = Some
                      "us.gcr.io/k8s-artifacts-prod/ingress-nginx/controller:v0.34.1@sha256:0e072dddd1f7f8fc8909a2ca6f65e76c5f0d2fcfb8be47935ae3457e8bbceb20"
                  , imagePullPolicy = Some "IfNotPresent"
                  , lifecycle = Some schemas.Lifecycle::{
                    , preStop = Some schemas.Handler::{
                      , exec = Some schemas.ExecAction::{
                        , command = Some [ "/wait-shutdown" ]
                        }
                      }
                    }
                  , livenessProbe = Some schemas.Probe::{
                    , failureThreshold = Some 5
                    , httpGet = Some schemas.HTTPGetAction::{
                      , path = Some "/healthz"
                      , port = < Int : Natural | String : Text >.Int 10254
                      , scheme = Some "HTTP"
                      }
                    , initialDelaySeconds = Some 10
                    , periodSeconds = Some 10
                    , successThreshold = Some 1
                    , timeoutSeconds = Some 1
                    }
                  , name = "controller"
                  , ports = Some
                    [ schemas.ContainerPort::{
                      , containerPort = 80
                      , name = Some "http"
                      , protocol = Some "TCP"
                      }
                    , schemas.ContainerPort::{
                      , containerPort = 443
                      , name = Some "https"
                      , protocol = Some "TCP"
                      }
                    , schemas.ContainerPort::{
                      , containerPort = 8443
                      , name = Some "webhook"
                      , protocol = Some "TCP"
                      }
                    ]
                  , readinessProbe = Some schemas.Probe::{
                    , failureThreshold = Some 3
                    , httpGet = Some schemas.HTTPGetAction::{
                      , path = Some "/healthz"
                      , port = < Int : Natural | String : Text >.Int 10254
                      , scheme = Some "HTTP"
                      }
                    , initialDelaySeconds = Some 10
                    , periodSeconds = Some 10
                    , successThreshold = Some 1
                    , timeoutSeconds = Some 1
                    }
                  , resources = Some schemas.ResourceRequirements::{
                    , requests = Some
                      [ { mapKey = "cpu", mapValue = "100m" }
                      , { mapKey = "memory", mapValue = "90Mi" }
                      ]
                    }
                  , securityContext = Some schemas.SecurityContext::{
                    , allowPrivilegeEscalation = Some True
                    , capabilities = Some schemas.Capabilities::{
                      , add = Some [ "NET_BIND_SERVICE" ]
                      , drop = Some [ "ALL" ]
                      }
                    , runAsUser = Some 101
                    }
                  , volumeMounts = Some
                    [ schemas.VolumeMount::{
                      , mountPath = "/usr/local/certificates/"
                      , name = "webhook-cert"
                      , readOnly = Some True
                      }
                    ]
                  }
                ]
              , dnsPolicy = Some "ClusterFirst"
              , serviceAccountName = Some "ingress-nginx"
              , terminationGracePeriodSeconds = Some 300
              , volumes = Some
                [ schemas.Volume::{
                  , name = "webhook-cert"
                  , secret = Some schemas.SecretVolumeSource::{
                    , secretName = Some "ingress-nginx-admission"
                    }
                  }
                ]
              }
            }
          }
        }
      , Role.ingress-nginx = schemas.Role::{
        , metadata = schemas.ObjectMeta::{
          , labels = Some
            [ { mapKey = "app.kubernetes.io/component"
              , mapValue = "controller"
              }
            , { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx"
          , namespace = Some "ingress-nginx"
          }
        , rules = Some
          [ schemas.PolicyRule::{
            , apiGroups = Some [ "" ]
            , resources = Some [ "namespaces" ]
            , verbs = [ "get" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "" ]
            , resources = Some [ "configmaps", "pods", "secrets", "endpoints" ]
            , verbs = [ "get", "list", "watch" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "" ]
            , resources = Some [ "services" ]
            , verbs = [ "get", "list", "update", "watch" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "extensions", "networking.k8s.io" ]
            , resources = Some [ "ingresses" ]
            , verbs = [ "get", "list", "watch" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "extensions", "networking.k8s.io" ]
            , resources = Some [ "ingresses/status" ]
            , verbs = [ "update" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "networking.k8s.io" ]
            , resources = Some [ "ingressclasses" ]
            , verbs = [ "get", "list", "watch" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "" ]
            , resourceNames = Some [ "ingress-controller-leader-nginx" ]
            , resources = Some [ "configmaps" ]
            , verbs = [ "get", "update" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "" ]
            , resources = Some [ "configmaps" ]
            , verbs = [ "create" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "" ]
            , resources = Some [ "endpoints" ]
            , verbs = [ "create", "get", "update" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "" ]
            , resources = Some [ "events" ]
            , verbs = [ "create", "patch" ]
            }
          ]
        }
      , RoleBinding.ingress-nginx = schemas.RoleBinding::{
        , metadata = schemas.ObjectMeta::{
          , labels = Some
            [ { mapKey = "app.kubernetes.io/component"
              , mapValue = "controller"
              }
            , { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx"
          , namespace = Some "ingress-nginx"
          }
        , roleRef = schemas.RoleRef::{
          , apiGroup = "rbac.authorization.k8s.io"
          , kind = "Role"
          , name = "ingress-nginx"
          }
        , subjects = Some
          [ schemas.Subject::{
            , kind = "ServiceAccount"
            , name = "ingress-nginx"
            , namespace = Some "ingress-nginx"
            }
          ]
        }
      , Service =
        { ingress-nginx-controller = schemas.Service::{
          , metadata = schemas.ObjectMeta::{
            , labels = Some
              [ { mapKey = "app.kubernetes.io/component"
                , mapValue = "controller"
                }
              , { mapKey = "app.kubernetes.io/instance"
                , mapValue = "ingress-nginx"
                }
              , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
              , { mapKey = "app.kubernetes.io/name"
                , mapValue = "ingress-nginx"
                }
              , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
              , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
              ]
            , name = Some "ingress-nginx-controller"
            , namespace = Some "ingress-nginx"
            }
          , spec = Some schemas.ServiceSpec::{
            , externalTrafficPolicy = Some "Local"
            , ports = Some
              [ schemas.ServicePort::{
                , name = Some "http"
                , port = 80
                , protocol = Some "TCP"
                , targetPort = Some
                    (< Int : Natural | String : Text >.String "http")
                }
              , schemas.ServicePort::{
                , name = Some "https"
                , port = 443
                , protocol = Some "TCP"
                , targetPort = Some
                    (< Int : Natural | String : Text >.String "https")
                }
              ]
            , selector = Some
              [ { mapKey = "app.kubernetes.io/component"
                , mapValue = "controller"
                }
              , { mapKey = "app.kubernetes.io/instance"
                , mapValue = "ingress-nginx"
                }
              , { mapKey = "app.kubernetes.io/name"
                , mapValue = "ingress-nginx"
                }
              ]
            , type = Some "LoadBalancer"
            }
          }
        , ingress-nginx-controller-admission = schemas.Service::{
          , metadata = schemas.ObjectMeta::{
            , labels = Some
              [ { mapKey = "app.kubernetes.io/component"
                , mapValue = "controller"
                }
              , { mapKey = "app.kubernetes.io/instance"
                , mapValue = "ingress-nginx"
                }
              , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
              , { mapKey = "app.kubernetes.io/name"
                , mapValue = "ingress-nginx"
                }
              , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
              , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
              ]
            , name = Some "ingress-nginx-controller-admission"
            , namespace = Some "ingress-nginx"
            }
          , spec = Some schemas.ServiceSpec::{
            , ports = Some
              [ schemas.ServicePort::{
                , name = Some "https-webhook"
                , port = 443
                , targetPort = Some
                    (< Int : Natural | String : Text >.String "webhook")
                }
              ]
            , selector = Some
              [ { mapKey = "app.kubernetes.io/component"
                , mapValue = "controller"
                }
              , { mapKey = "app.kubernetes.io/instance"
                , mapValue = "ingress-nginx"
                }
              , { mapKey = "app.kubernetes.io/name"
                , mapValue = "ingress-nginx"
                }
              ]
            , type = Some "ClusterIP"
            }
          }
        }
      , ServiceAccount.ingress-nginx = schemas.ServiceAccount::{
        , metadata = schemas.ObjectMeta::{
          , labels = Some
            [ { mapKey = "app.kubernetes.io/component"
              , mapValue = "controller"
              }
            , { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx"
          , namespace = Some "ingress-nginx"
          }
        }
      }
    , root =
      { ClusterRole.ingress-nginx = schemas.ClusterRole::{
        , metadata = schemas.ObjectMeta::{
          , labels = Some
            [ { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx"
          , namespace = Some "ingress-nginx"
          }
        , rules = Some
          [ schemas.PolicyRule::{
            , apiGroups = Some [ "" ]
            , resources = Some
              [ "configmaps", "endpoints", "nodes", "pods", "secrets" ]
            , verbs = [ "list", "watch" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "" ]
            , resources = Some [ "nodes" ]
            , verbs = [ "get" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "" ]
            , resources = Some [ "services" ]
            , verbs = [ "get", "list", "update", "watch" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "extensions", "networking.k8s.io" ]
            , resources = Some [ "ingresses" ]
            , verbs = [ "get", "list", "watch" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "" ]
            , resources = Some [ "events" ]
            , verbs = [ "create", "patch" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "extensions", "networking.k8s.io" ]
            , resources = Some [ "ingresses/status" ]
            , verbs = [ "update" ]
            }
          , schemas.PolicyRule::{
            , apiGroups = Some [ "networking.k8s.io" ]
            , resources = Some [ "ingressclasses" ]
            , verbs = [ "get", "list", "watch" ]
            }
          ]
        }
      , ClusterRoleBinding.ingress-nginx = schemas.RoleBinding::{
        , kind = "ClusterRoleBinding"
        , metadata = schemas.ObjectMeta::{
          , labels = Some
            [ { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/managed-by", mapValue = "Helm" }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            , { mapKey = "app.kubernetes.io/version", mapValue = "0.34.1" }
            , { mapKey = "helm.sh/chart", mapValue = "ingress-nginx-2.11.1" }
            ]
          , name = Some "ingress-nginx"
          , namespace = Some "ingress-nginx"
          }
        , roleRef = schemas.RoleRef::{
          , apiGroup = "rbac.authorization.k8s.io"
          , kind = "ClusterRole"
          , name = "ingress-nginx"
          }
        , subjects = Some
          [ schemas.Subject::{
            , kind = "ServiceAccount"
            , name = "ingress-nginx"
            , namespace = Some "ingress-nginx"
            }
          ]
        }
      , Namespace.ingress-nginx = schemas.Namespace::{
        , metadata = schemas.ObjectMeta::{
          , labels = Some
            [ { mapKey = "app.kubernetes.io/instance"
              , mapValue = "ingress-nginx"
              }
            , { mapKey = "app.kubernetes.io/name", mapValue = "ingress-nginx" }
            ]
          , name = Some "ingress-nginx"
          }
        }
      }
    }
