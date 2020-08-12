{ Cadvisor =
  { ClusterRole =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , ClusterRoleBinding =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , DaemonSet =
    { Containers.Cadvisor =
      { additionalEnvironmentVariables =
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
                            { apiVersion : Optional Text, fieldPath : Text }
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
      , image = Some
          "us.gcr.io/sourcegraph-dev/cadvisor:0dc33691105dff7ddacb143e63a4a565ba25803d_69148_candidate"
      , resources =
        { limits =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        , requests =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , PodSecurityPolicy =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , ServiceAccount =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  }
, Frontend =
  { Deployment =
    { Containers.SourcegraphFrontend =
      { additionalEnvironmentVariables = Some
        [ { name = "SENTRY_DSN_BACKEND"
          , value = Some
              "https://cb3bfeb73fb141cf9ed71d06ae1f02b8@sentry.io/1249389"
          , valueFrom =
              None
                { configMapKeyRef :
                    Optional
                      { key : Text
                      , name : Optional Text
                      , optional : Optional Bool
                      }
                , fieldRef :
                    Optional { apiVersion : Optional Text, fieldPath : Text }
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
        , { name = "SENTRY_DSN_FRONTEND"
          , value = Some
              "https://cb3bfeb73fb141cf9ed71d06ae1f02b8@sentry.io/1249389"
          , valueFrom =
              None
                { configMapKeyRef :
                    Optional
                      { key : Text
                      , name : Optional Text
                      , optional : Optional Bool
                      }
                , fieldRef :
                    Optional { apiVersion : Optional Text, fieldPath : Text }
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
        ]
      , image = Some
          "index.docker.io/sourcegraph/frontend:insiders@sha256:a211568c55c867f78c7ef2070017df1633d2d462dec24cf705f0635cadb9a25a"
      , resources =
        { limits =
          { cpu = Some "8000m"
          , ephemeralStorage = Some "1Gi"
          , memory = Some "6G"
          }
        , requests =
          { cpu = Some "6000m"
          , ephemeralStorage = Some "1Gi"
          , memory = Some "4G"
          }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , replicas = None Natural
    }
  , Ingress =
    { additionalAnnotations = Some
      [ { mapKey = "certmanager.k8s.io/issuer", mapValue = "letsencrypt-prod" }
      , { mapKey = "nginx.ingress.kubernetes.io/proxy-read-timeout"
        , mapValue = "1d"
        }
      , { mapKey = "certmanager.k8s.io/acme-challenge-type"
        , mapValue = "http01"
        }
      ]
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , tls = Some
      [ { hosts = Some [ "catfood.sgdev.org" ]
        , secretName = Some "sourcegraph-tls"
        }
      ]
    }
  , Role =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , RoleBinding =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , ServiceAccount =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , ServiceInternal =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  }
, GithubProxy =
  { Deployment =
    { Containers.GithubProxy =
      { additionalEnvironmentVariables =
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
                            { apiVersion : Optional Text, fieldPath : Text }
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
      , image = Some
          "index.docker.io/sourcegraph/github-proxy:insiders@sha256:5df85aaa1fb332322c4eaf6b6f6fd0bd7ff505dbec0b8b8254c0b30ed2f5d930"
      , resources =
        { limits =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        , requests =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , replicas = None Natural
    }
  , Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  }
, Gitserver =
  { Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , StatefulSet =
    { Containers.Gitserver =
      { additionalEnvironmentVariables =
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
                            { apiVersion : Optional Text, fieldPath : Text }
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
      , image = Some
          "index.docker.io/sourcegraph/gitserver:insiders@sha256:4861c686442c66ec5310bb4cac2f88c878c91dbd9f06e42409ddf627d58ca07e"
      , resources =
        { limits =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        , requests =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , persistentVolumeSize = Some "4Ti"
    , replicas = Some 4
    , sshSecretName = Some "gitserver-ssh"
    }
  }
, Grafana =
  { ConfigMap =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , ServiceAccount =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , StatefulSet =
    { Containers.Grafana =
      { additionalEnvironmentVariables = Some
        [ { name = "GF_SERVER_ROOT_URL"
          , value = Some "https://k8s.sgdev.org/-/debug/grafana"
          , valueFrom =
              None
                { configMapKeyRef :
                    Optional
                      { key : Text
                      , name : Optional Text
                      , optional : Optional Bool
                      }
                , fieldRef :
                    Optional { apiVersion : Optional Text, fieldPath : Text }
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
        ]
      , image = Some
          "index.docker.io/sourcegraph/grafana:insiders@sha256:68231a60ffcbfb104573ab5319fb8214b7d59292da39b9e5ad2a6c60a9c0e81b"
      , resources =
        { limits =
          { cpu = Some "100m"
          , ephemeralStorage = Some "1Gi"
          , memory = Some "100Mi"
          }
        , requests =
          { cpu = None Text
          , ephemeralStorage = Some "1Gi"
          , memory = Some "100Mi"
          }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , replicas = None Natural
    }
  }
, IndexedSearch =
  { Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , StatefulSet =
    { Containers =
      { ZoektIndexServer =
        { additionalEnvironmentVariables =
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
                              { apiVersion : Optional Text, fieldPath : Text }
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
        , image = Some
            "index.docker.io/sourcegraph/search-indexer:insiders@sha256:8eeb86684d66349c34185b6cacd54812048856e6a73b917a05912028fe04ed1d"
        , resources =
          { limits =
            { cpu = None Text
            , ephemeralStorage = Some "1Gi"
            , memory = None Text
            }
          , requests =
            { cpu = None Text
            , ephemeralStorage = Some "1Gi"
            , memory = None Text
            }
          }
        }
      , ZoektWebServer =
        { additionalEnvironmentVariables =
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
                              { apiVersion : Optional Text, fieldPath : Text }
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
        , image = Some
            "index.docker.io/sourcegraph/indexed-searcher:insiders@sha256:b5547e441474c08ee35e0911d44ac7dd05928f45816999da6b4993e31725a141"
        , resources =
          { limits =
            { cpu = Some "12"
            , ephemeralStorage = Some "1Gi"
            , memory = Some "120Gi"
            }
          , requests =
            { cpu = Some "12"
            , ephemeralStorage = Some "1Gi"
            , memory = Some "120Gi"
            }
          }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , persistentVolumeSize = Some "4Ti"
    , replicas = Some 2
    }
  }
, IngressNginx = { Enabled = True, IPAddress = Some "34.66.96.138" }
, Jaeger =
  { Collector =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , Deployment =
    { Containers.JaegerAllInOne =
      { additionalEnvironmentVariables =
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
                            { apiVersion : Optional Text, fieldPath : Text }
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
      , image = None Text
      , resources =
        { limits =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        , requests =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , replicas = None Natural
    }
  , Query =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  }
, Postgres =
  { ConfigMap =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , Deployment =
    { Containers =
      { Init =
        { additionalEnvironmentVariables =
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
                              { apiVersion : Optional Text, fieldPath : Text }
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
        , image = None Text
        , resources =
          { limits =
            { cpu = None Text
            , ephemeralStorage = None Text
            , memory = None Text
            }
          , requests =
            { cpu = None Text
            , ephemeralStorage = None Text
            , memory = None Text
            }
          }
        }
      , Postgres =
        { additionalEnvironmentVariables =
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
                              { apiVersion : Optional Text, fieldPath : Text }
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
        , image = Some
            "index.docker.io/sourcegraph/postgres-11.4:insiders@sha256:63090799b34b3115a387d96fe2227a37999d432b774a1d9b7966b8c5d81b56ad"
        , resources =
          { limits =
            { cpu = Some "16"
            , ephemeralStorage = Some "1Gi"
            , memory = Some "24Gi"
            }
          , requests =
            { cpu = Some "16"
            , ephemeralStorage = Some "1Gi"
            , memory = Some "24Gi"
            }
          }
        }
      , PostgresExporter =
        { additionalEnvironmentVariables =
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
                              { apiVersion : Optional Text, fieldPath : Text }
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
        , image = None Text
        , resources =
          { limits =
            { cpu = None Text
            , ephemeralStorage = None Text
            , memory = None Text
            }
          , requests =
            { cpu = None Text
            , ephemeralStorage = None Text
            , memory = None Text
            }
          }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , replicas = None Natural
    }
  , PersistentVolumeClaim =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  }
, PreciseCodeIntel =
  { BundleManager =
    { Deployment =
      { Containers.BundleManager =
        { additionalEnvironmentVariables =
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
                              { apiVersion : Optional Text, fieldPath : Text }
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
        , image = Some
            "index.docker.io/sourcegraph/precise-code-intel-bundle-manager:insiders@sha256:5fedf4f0158d56a7cab98fb9a232f17b43e4d4890df5674177b0e358b5ff8a3d"
        , resources =
          { limits =
            { cpu = None Text
            , ephemeralStorage = Some "1Gi"
            , memory = None Text
            }
          , requests =
            { cpu = None Text
            , ephemeralStorage = Some "1Gi"
            , memory = None Text
            }
          }
        }
      , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
      , additionalLabels = None (List { mapKey : Text, mapValue : Text })
      , namespace = None Text
      , replicas = None Natural
      }
    , PersistentVolumeClaim =
      { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
      , additionalLabels = None (List { mapKey : Text, mapValue : Text })
      , namespace = None Text
      }
    , Service =
      { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
      , additionalLabels = None (List { mapKey : Text, mapValue : Text })
      , namespace = None Text
      }
    }
  , Worker =
    { Deployment =
      { Containers.Worker =
        { additionalEnvironmentVariables =
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
                              { apiVersion : Optional Text, fieldPath : Text }
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
        , image = Some
            "index.docker.io/sourcegraph/precise-code-intel-worker:insiders@sha256:f9cda51f68388b0b809c647e954dbc2aa9643efc4beb8e2cb9cbc56b1b9c1675"
        , resources =
          { limits =
            { cpu = None Text
            , ephemeralStorage = Some "1Gi"
            , memory = None Text
            }
          , requests =
            { cpu = None Text
            , ephemeralStorage = Some "1Gi"
            , memory = None Text
            }
          }
        }
      , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
      , additionalLabels = None (List { mapKey : Text, mapValue : Text })
      , namespace = None Text
      , replicas = None Natural
      }
    , Service =
      { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
      , additionalLabels = None (List { mapKey : Text, mapValue : Text })
      , namespace = None Text
      }
    }
  }
, Prometheus =
  { ClusterRole =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , ClusterRoleBinding =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , ConfigMap =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , Deployment =
    { Containers =
      { Blackbox =
        { additionalEnvironmentVariables =
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
                              { apiVersion : Optional Text, fieldPath : Text }
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
        , image = None Text
        , resources =
          { limits =
            { cpu = Some "1G"
            , ephemeralStorage = None Text
            , memory = Some "1G"
            }
          , requests =
            { cpu = Some "500m"
            , ephemeralStorage = None Text
            , memory = Some "500M"
            }
          }
        }
      , Prometheus =
        { additionalEnvironmentVariables =
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
                              { apiVersion : Optional Text, fieldPath : Text }
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
        , image = Some
            "index.docker.io/sourcegraph/prometheus:insiders@sha256:96a07db09f71f4c110eceea813af48555bfc6efc68900231780816b868232292"
        , resources =
          { limits =
            { cpu = None Text
            , ephemeralStorage = Some "1Gi"
            , memory = Some "3G"
            }
          , requests =
            { cpu = None Text
            , ephemeralStorage = Some "1Gi"
            , memory = Some "500M"
            }
          }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , replicas = None Natural
    }
  , Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  , ServiceAccount =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  }
, QueryRunner =
  { Deployment =
    { Containers.QueryRunner =
      { additionalEnvironmentVariables =
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
                            { apiVersion : Optional Text, fieldPath : Text }
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
      , image = Some
          "index.docker.io/sourcegraph/query-runner:insiders@sha256:e78be29ed758931b60e0e842c949cfe3c9c0f56093e2021928bb258c355f36ee"
      , resources =
        { limits =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        , requests =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , replicas = None Natural
    }
  , Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  }
, Redis =
  { Cache =
    { Deployment =
      { Containers =
        { Cache =
          { additionalEnvironmentVariables =
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
                                { apiVersion : Optional Text, fieldPath : Text }
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
          , image = Some
              "index.docker.io/sourcegraph/redis-cache:insiders@sha256:7820219195ab3e8fdae5875cd690fed1b2a01fd1063bd94210c0e9d529c38e56"
          , resources =
            { limits =
              { cpu = None Text
              , ephemeralStorage = Some "1Gi"
              , memory = None Text
              }
            , requests =
              { cpu = None Text
              , ephemeralStorage = Some "1Gi"
              , memory = None Text
              }
            }
          }
        , Exporter =
          { additionalEnvironmentVariables =
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
                                { apiVersion : Optional Text, fieldPath : Text }
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
          , image = None Text
          , resources =
            { limits =
              { cpu = None Text
              , ephemeralStorage = None Text
              , memory = None Text
              }
            , requests =
              { cpu = None Text
              , ephemeralStorage = None Text
              , memory = None Text
              }
            }
          }
        }
      , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
      , additionalLabels = None (List { mapKey : Text, mapValue : Text })
      , namespace = None Text
      , replicas = None Natural
      }
    , PersistentVolumeClaim =
      { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
      , additionalLabels = None (List { mapKey : Text, mapValue : Text })
      , namespace = None Text
      }
    , Service =
      { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
      , additionalLabels = None (List { mapKey : Text, mapValue : Text })
      , namespace = None Text
      }
    }
  , Store =
    { Deployment =
      { Containers =
        { Exporter =
          { additionalEnvironmentVariables =
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
                                { apiVersion : Optional Text, fieldPath : Text }
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
          , image = None Text
          , resources =
            { limits =
              { cpu = None Text
              , ephemeralStorage = None Text
              , memory = None Text
              }
            , requests =
              { cpu = None Text
              , ephemeralStorage = None Text
              , memory = None Text
              }
            }
          }
        , Store =
          { additionalEnvironmentVariables =
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
                                { apiVersion : Optional Text, fieldPath : Text }
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
          , image = Some
              "index.docker.io/sourcegraph/redis-store:insiders@sha256:e8467a8279832207559bdfbc4a89b68916ecd5b44ab5cf7620c995461c005168"
          , resources =
            { limits =
              { cpu = None Text
              , ephemeralStorage = Some "1Gi"
              , memory = None Text
              }
            , requests =
              { cpu = None Text
              , ephemeralStorage = Some "1Gi"
              , memory = None Text
              }
            }
          }
        }
      , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
      , additionalLabels = None (List { mapKey : Text, mapValue : Text })
      , namespace = None Text
      , replicas = None Natural
      }
    , PersistentVolumeClaim =
      { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
      , additionalLabels = None (List { mapKey : Text, mapValue : Text })
      , namespace = None Text
      }
    , Service =
      { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
      , additionalLabels = None (List { mapKey : Text, mapValue : Text })
      , namespace = None Text
      }
    }
  }
, Replacer =
  { Deployment =
    { Containers.Replacer =
      { additionalEnvironmentVariables =
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
                            { apiVersion : Optional Text, fieldPath : Text }
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
      , image = Some
          "index.docker.io/sourcegraph/replacer:insiders@sha256:1b1af9ac5ce358009b99b9d5f69c248546e386ab456d61f6cd39d2310a749b09"
      , resources =
        { limits =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        , requests =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , replicas = None Natural
    }
  , Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  }
, RepoUpdater =
  { Deployment =
    { Containers.RepoUpdater =
      { additionalEnvironmentVariables =
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
                            { apiVersion : Optional Text, fieldPath : Text }
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
      , image = Some
          "index.docker.io/sourcegraph/repo-updater:insiders@sha256:98ff67fe531efa0794ecbba43d403a2f3df1c60ad65c48d16b02a69e8d01cda7"
      , resources =
        { limits =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        , requests =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , replicas = None Natural
    }
  , Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  }
, Searcher =
  { Deployment =
    { Containers.Searcher =
      { additionalEnvironmentVariables =
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
                            { apiVersion : Optional Text, fieldPath : Text }
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
      , image = Some
          "index.docker.io/sourcegraph/searcher:insiders@sha256:5d4de45c03acb56f22b6f61d922060987b1f5aa5b22e43c9c2ff49a1b3f251c0"
      , resources =
        { limits =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        , requests =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , replicas = None Natural
    }
  , Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  }
, StorageClass.CloudProvider = < AWS | AZURE | CUSTOM | GCP >.GCP
, Symbols =
  { Deployment =
    { Containers.Symbols =
      { additionalEnvironmentVariables =
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
                            { apiVersion : Optional Text, fieldPath : Text }
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
      , image = Some
          "index.docker.io/sourcegraph/symbols:insiders@sha256:ea6fd7b5f5b33c563b69f7f014c89caef3e92fb038626b349ab77c7e362d5c82"
      , resources =
        { limits =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        , requests =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , replicas = None Natural
    }
  , Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  }
, SyntaxHighlighter =
  { Deployment =
    { Containers.SyntaxHighlighter =
      { additionalEnvironmentVariables =
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
                            { apiVersion : Optional Text, fieldPath : Text }
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
      , image = Some
          "index.docker.io/sourcegraph/syntax-highlighter:insiders@sha256:aa93514b7bc3aaf7a4e9c92e5ff52ee5052db6fb101255a69f054e5b8cdb46ff"
      , resources =
        { limits =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        , requests =
          { cpu = None Text, ephemeralStorage = Some "1Gi", memory = None Text }
        }
      }
    , additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    , replicas = None Natural
    }
  , Service =
    { additionalAnnotations = None (List { mapKey : Text, mapValue : Text })
    , additionalLabels = None (List { mapKey : Text, mapValue : Text })
    , namespace = None Text
    }
  }
}
