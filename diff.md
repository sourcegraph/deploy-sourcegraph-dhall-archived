```

{ Cadvisor = { DaemonSet = { spec = Some
                                    { template = { spec = Some
                                                          { containers = [ { image = Some
                                                                                     "�[41mindex�[0m�[42mus�[0m�[2m.�[0m�[41mdo�[0m�[42mg�[0m�[2mc�[0m�[41mke�[0m�[2mr.io/sourcegraph�[0m�[42m-dev�[0m�[2m/cadvisor:�[0m�[42m0dc�[0m�[2m3�[0m�[41m.17.2@sha25�[0m�[42m3�[0m�[2m6�[0m�[41m:�[0m�[2m9�[0m�[41mfb42b�[0m�[42m11�[0m�[2m0�[0m�[41m67�[0m�[42m5�[0m�[2md�[0m�[41m1�[0m�[2mf�[0m�[41m9cc84558�[0m�[2mf�[0m�[41m61b6e�[0m�[42m7dda�[0m�[2mc�[0m�[42mb1�[0m�[2m4�[0m�[41m2f8cf�[0m�[42m3�[0m�[2me�[0m�[41m7�[0m�[42m63�[0m�[2ma�[0m�[41md87�[0m�[2m4�[0m�[42ma5�[0m�[2m6�[0m�[42m5ba�[0m�[2m25�[0m�[41mc767�[0m�[42m80�[0m�[2m3�[0m�[41mefa�[0m�[42md_6�[0m�[2m9�[0m�[41mb�[0m�[2m1�[0m�[41mf0�[0m�[2m4�[0m�[41m7fa3�[0m�[42m8_�[0m�[2mc�[0m�[41me�[0m�[42man�[0m�[2md�[0m�[42midate�[0m"
                                                                           , resources = Some
                                                                                         { limits = Some
                                                                                                    [ …
                                                                                                    , + { mapKey =
                                                                                                            "ephemeral-storage"
                                                                                                        , mapValue =
                                                                                                            "1Gi"
                                                                                                        }
                                                                                                    ]

                                                                                         , requests = Some
                                                                                                      [ …
                                                                                                      , + { mapKey =
                                                                                                              "ephemeral-storage"
                                                                                                          , mapValue =
                                                                                                              "1Gi"
                                                                                                          }
                                                                                                      ]

                                                                                         }
                                                                           , …
                                                                           }
                                                                         ]

                                                          , …
                                                          }
                                                 , …
                                                 }
                                    , …
                                    }
                           , …
                           }
             , …
             }
, Frontend = { Deployment = { spec = Some
                                     { template = { spec = Some
                                                           { containers = [ { env = Some
                                                                                    [ …
                                                                                    , { value = Some
                                                                                                "�[2mgitserver-0.gitserver:3178�[0m�[42m gitserver-1.gitserver:3178 gitserver-2.gitserver:3178 gitserver-3.gitserver:3178�[0m"
                                                                                      , …
                                                                                      }
                                                                                    , …
                                                                                    , + { name =
                                                                                            "SENTRY_DSN_BACKEND"
                                                                                        , value = Some
                                                                                            "https://cb3bfeb73fb141cf9ed71d06ae1f02b8@sentry.io/1249389"
                                                                                        , valueFrom =
                                                                                            None
                                                                                              { configMapKeyRef :
                                                                                                  Optional
                                                                                                    { key :
                                                                                                        Text
                                                                                                    , name :
                                                                                                        Optional
                                                                                                          Text
                                                                                                    , optional :
                                                                                                        Optional
                                                                                                          Bool
                                                                                                    }
                                                                                              , fieldRef :
                                                                                                  Optional
                                                                                                    { apiVersion :
                                                                                                        Optional
                                                                                                          Text
                                                                                                    , fieldPath :
                                                                                                        Text
                                                                                                    }
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
                                                                                              , secretKeyRef :
                                                                                                  Optional
                                                                                                    { key :
                                                                                                        Text
                                                                                                    , name :
                                                                                                        Optional
                                                                                                          Text
                                                                                                    , optional :
                                                                                                        Optional
                                                                                                          Bool
                                                                                                    }
                                                                                              }
                                                                                        }
                                                                                    , + { name =
                                                                                            "SENTRY_DSN_FRONTEND"
                                                                                        , value = Some
                                                                                            "https://cb3bfeb73fb141cf9ed71d06ae1f02b8@sentry.io/1249389"
                                                                                        , valueFrom =
                                                                                            None
                                                                                              { configMapKeyRef :
                                                                                                  Optional
                                                                                                    { key :
                                                                                                        Text
                                                                                                    , name :
                                                                                                        Optional
                                                                                                          Text
                                                                                                    , optional :
                                                                                                        Optional
                                                                                                          Bool
                                                                                                    }
                                                                                              , fieldRef :
                                                                                                  Optional
                                                                                                    { apiVersion :
                                                                                                        Optional
                                                                                                          Text
                                                                                                    , fieldPath :
                                                                                                        Text
                                                                                                    }
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
                                                                                              , secretKeyRef :
                                                                                                  Optional
                                                                                                    { key :
                                                                                                        Text
                                                                                                    , name :
                                                                                                        Optional
                                                                                                          Text
                                                                                                    , optional :
                                                                                                        Optional
                                                                                                          Bool
                                                                                                    }
                                                                                              }
                                                                                        }
                                                                                    ]

                                                                            , image = Some
                                                                                      "�[2mindex.docker.io/sourcegraph/frontend:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[42ma�[0m�[2m2�[0m�[41m3788993656�[0m�[2m1�[0m�[41m963�[0m�[42m1�[0m�[2m5�[0m�[42m68�[0m�[2mc�[0m�[41me7a�[0m�[42m55�[0m�[2mc�[0m�[41md9�[0m�[2m8�[0m�[41m35�[0m�[42m67f7�[0m�[2m8�[0m�[42mc7ef�[0m�[2m2�[0m�[41m4�[0m�[2m07�[0m�[41m688d4�[0m�[42m0017�[0m�[2md�[0m�[41me�[0m�[2mf�[0m�[41m72a�[0m�[42m16�[0m�[2m3�[0m�[41mf�[0m�[42m3�[0m�[2md�[0m�[42m2d4�[0m�[2m62�[0m�[41ma�[0m�[42md�[0m�[2me�[0m�[41m6fa0�[0m�[2mc2�[0m�[41m3a�[0m�[42m4cf7�[0m�[2m05�[0m�[41m54�[0m�[2mf�[0m�[42m0635ca�[0m�[2md�[0m�[41me�[0m�[42mb9a25a�[0m"
                                                                            , resources = Some
                                                                                          { limits = Some
                                                                                                     [ - { mapKey =
                                                                                                             "memory"
                                                                                                         , mapValue =
                                                                                                             "4G"
                                                                                                         }
                                                                                                     , - { mapKey =
                                                                                                             "cpu"
                                                                                                         , mapValue =
                                                                                                             "2"
                                                                                                         }
                                                                                                     , + { mapKey =
                                                                                                             "memory"
                                                                                                         , mapValue =
                                                                                                             "6G"
                                                                                                         }
                                                                                                     , + { mapKey =
                                                                                                             "cpu"
                                                                                                         , mapValue =
                                                                                                             "8000m"
                                                                                                         }
                                                                                                     , + { mapKey =
                                                                                                             "ephemeral-storage"
                                                                                                         , mapValue =
                                                                                                             "1Gi"
                                                                                                         }
                                                                                                     ]

                                                                                          , requests = Some
                                                                                                       [ - { mapKey =
                                                                                                               "memory"
                                                                                                           , mapValue =
                                                                                                               "2G"
                                                                                                           }
                                                                                                       , - { mapKey =
                                                                                                               "cpu"
                                                                                                           , mapValue =
                                                                                                               "2"
                                                                                                           }
                                                                                                       , + { mapKey =
                                                                                                               "memory"
                                                                                                           , mapValue =
                                                                                                               "4G"
                                                                                                           }
                                                                                                       , + { mapKey =
                                                                                                               "cpu"
                                                                                                           , mapValue =
                                                                                                               "6000m"
                                                                                                           }
                                                                                                       , + { mapKey =
                                                                                                               "ephemeral-storage"
                                                                                                           , mapValue =
                                                                                                               "1Gi"
                                                                                                           }
                                                                                                       ]

                                                                                          }
                                                                            , …
                                                                            }
                                                                          , …
                                                                          ]

                                                           , …
                                                           }
                                                  , …
                                                  }
                                     , …
                                     }
                            , …
                            }
             , Ingress = { metadata = { annotations = Some
                                                      [ …
                                                      , + { mapKey =
                                                              "certmanager.k8s.io/issuer"
                                                          , mapValue =
                                                              "letsencrypt-prod"
                                                          }
                                                      , + { mapKey =
                                                              "nginx.ingress.kubernetes.io/proxy-read-timeout"
                                                          , mapValue = "1d"
                                                          }
                                                      , + { mapKey =
                                                              "certmanager.k8s.io/acme-challenge-type"
                                                          , mapValue = "http01"
                                                          }
                                                      ]

                                      , …
                                      }
                         , spec = Some
                                  { tls = - None …
                                          + Some …
                                  , …
                                  }
                         , …
                         }
             , …
             }
, GitHubProxy = { Deployment = { spec = Some
                                        { template = { spec = Some
                                                              { containers = [ { image = Some
                                                                                         "�[2mindex.docker.io/sourcegraph/github-proxy:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[41mb�[0m�[2m5�[0m�[41m4c�[0m�[42mdf�[0m�[2m8�[0m�[41m4�[0m�[2m5�[0m�[41md7�[0m�[2maa�[0m�[41m96779�[0m�[42ma�[0m�[2m1�[0m�[42mfb332322c4�[0m�[2mea�[0m�[41m5�[0m�[2mf�[0m�[41m1�[0m�[2m6�[0m�[42mb�[0m�[2m6�[0m�[41ma19d�[0m�[2mf�[0m�[41m8�[0m�[42m6�[0m�[2mf�[0m�[41m3abee�[0m�[2md�[0m�[41ma4�[0m�[2m0�[0m�[41m8ae�[0m�[42mbd�[0m�[2m7�[0m�[41me�[0m�[42mff505�[0m�[2md�[0m�[41m9�[0m�[42mb�[0m�[2me�[0m�[41m1�[0m�[42mc0b8b8�[0m�[2m25�[0m�[41m1f�[0m�[42m4c�[0m�[2m0�[0m�[41m7�[0m�[42mb30�[0m�[2me�[0m�[42md�[0m�[2m2�[0m�[41mc83a4�[0m�[2mf�[0m�[41m6�[0m�[42m5d930�[0m"
                                                                               , resources = Some
                                                                                             { limits = Some
                                                                                                        [ …
                                                                                                        , + { mapKey =
                                                                                                                "ephemeral-storage"
                                                                                                            , mapValue =
                                                                                                                "1Gi"
                                                                                                            }
                                                                                                        ]

                                                                                             , requests = Some
                                                                                                          [ …
                                                                                                          , + { mapKey =
                                                                                                                  "ephemeral-storage"
                                                                                                              , mapValue =
                                                                                                                  "1Gi"
                                                                                                              }
                                                                                                          ]

                                                                                             }
                                                                               , …
                                                                               }
                                                                             , …
                                                                             ]

                                                              , …
                                                              }
                                                     , …
                                                     }
                                        , …
                                        }
                               , …
                               }
                , …
                }
, Gitserver = { StatefulSet = { spec = Some
                                       { replicas = Some
                                                    - 1
                                                    + 4
                                       , template = { spec = Some
                                                             { containers = [ { image = Some
                                                                                        "�[2mindex.docker.io/sourcegraph/gitserver:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[41ma�[0m�[42m4861c68644�[0m�[2m2�[0m�[41mda�[0m�[2mc�[0m�[41m3�[0m�[42m66�[0m�[2me�[0m�[41md8�[0m�[2mc�[0m�[41m9bbd7f9�[0m�[42m5�[0m�[2m3�[0m�[42m1�[0m�[2m0�[0m�[41mae8d2�[0m�[2mbb4�[0m�[41m46�[0m�[42mcac2f�[0m�[2m8�[0m�[42m8c8�[0m�[2m78�[0m�[41mf43�[0m�[42mc91dbd9�[0m�[2mf�[0m�[41m326�[0m�[2m0�[0m�[41m0�[0m�[42m6e4�[0m�[2m2�[0m�[41m77�[0m�[2m4�[0m�[41mf�[0m�[42m09�[0m�[2md�[0m�[41m85�[0m�[42mdf�[0m�[2m6�[0m�[41m4�[0m�[42m2�[0m�[2m7�[0m�[41m94�[0m�[42md�[0m�[2m5�[0m�[42m8c�[0m�[2ma�[0m�[41m9�[0m�[2m0�[0m�[41m535�[0m�[2m7�[0m�[41m33�[0m�[42me�[0m"
                                                                              , resources = Some
                                                                                            { limits = Some
                                                                                                       [ …
                                                                                                       , + { mapKey =
                                                                                                               "ephemeral-storage"
                                                                                                           , mapValue =
                                                                                                               "1Gi"
                                                                                                           }
                                                                                                       ]

                                                                                            , requests = Some
                                                                                                         [ …
                                                                                                         , + { mapKey =
                                                                                                                 "ephemeral-storage"
                                                                                                             , mapValue =
                                                                                                                 "1Gi"
                                                                                                             }
                                                                                                         ]

                                                                                            }
                                                                              , …
                                                                              }
                                                                            , …
                                                                            ]

                                                             , volumes = Some
                                                                         [ …
                                                                         , + { awsElasticBlockStore =
                                                                                 None
                                                                                   { fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , partition :
                                                                                       Optional
                                                                                         Natural
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , volumeID :
                                                                                       Text
                                                                                   }
                                                                             , azureDisk =
                                                                                 None
                                                                                   { cachingMode :
                                                                                       Optional
                                                                                         Text
                                                                                   , diskName :
                                                                                       Text
                                                                                   , diskURI :
                                                                                       Text
                                                                                   , fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , kind :
                                                                                       Text
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   }
                                                                             , azureFile =
                                                                                 None
                                                                                   { readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , secretName :
                                                                                       Text
                                                                                   , shareName :
                                                                                       Text
                                                                                   }
                                                                             , cephfs =
                                                                                 None
                                                                                   { monitors :
                                                                                       List
                                                                                         Text
                                                                                   , path :
                                                                                       Optional
                                                                                         Text
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , secretFile :
                                                                                       Optional
                                                                                         Text
                                                                                   , secretRef :
                                                                                       Optional
                                                                                         { name :
                                                                                             Optional
                                                                                               Text
                                                                                         }
                                                                                   , user :
                                                                                       Optional
                                                                                         Text
                                                                                   }
                                                                             , cinder =
                                                                                 None
                                                                                   { fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , secretRef :
                                                                                       Optional
                                                                                         { name :
                                                                                             Optional
                                                                                               Text
                                                                                         }
                                                                                   , volumeID :
                                                                                       Text
                                                                                   }
                                                                             , configMap =
                                                                                 None
                                                                                   { defaultMode :
                                                                                       Optional
                                                                                         Natural
                                                                                   , items :
                                                                                       Optional
                                                                                         ( List
                                                                                             { key :
                                                                                                 Text
                                                                                             , mode :
                                                                                                 Optional
                                                                                                   Natural
                                                                                             , path :
                                                                                                 Text
                                                                                             }
                                                                                         )
                                                                                   , name :
                                                                                       Optional
                                                                                         Text
                                                                                   , optional :
                                                                                       Optional
                                                                                         Bool
                                                                                   }
                                                                             , csi =
                                                                                 None
                                                                                   { driver :
                                                                                       Text
                                                                                   , fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , nodePublishSecretRef :
                                                                                       Optional
                                                                                         { name :
                                                                                             Optional
                                                                                               Text
                                                                                         }
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , volumeAttributes :
                                                                                       Optional
                                                                                         ( List
                                                                                             { mapKey :
                                                                                                 Text
                                                                                             , mapValue :
                                                                                                 Text
                                                                                             }
                                                                                         )
                                                                                   }
                                                                             , downwardAPI =
                                                                                 None
                                                                                   { defaultMode :
                                                                                       Optional
                                                                                         Natural
                                                                                   , items :
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
                                                                                                 Optional
                                                                                                   Natural
                                                                                             , path :
                                                                                                 Text
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
                                                                             , emptyDir =
                                                                                 None
                                                                                   { medium :
                                                                                       Optional
                                                                                         Text
                                                                                   , sizeLimit :
                                                                                       Optional
                                                                                         Text
                                                                                   }
                                                                             , fc =
                                                                                 None
                                                                                   { fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , lun :
                                                                                       Optional
                                                                                         Natural
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , targetWWNs :
                                                                                       Optional
                                                                                         ( List
                                                                                             Text
                                                                                         )
                                                                                   , wwids :
                                                                                       Optional
                                                                                         ( List
                                                                                             Text
                                                                                         )
                                                                                   }
                                                                             , flexVolume =
                                                                                 None
                                                                                   { driver :
                                                                                       Text
                                                                                   , fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , options :
                                                                                       Optional
                                                                                         ( List
                                                                                             { mapKey :
                                                                                                 Text
                                                                                             , mapValue :
                                                                                                 Text
                                                                                             }
                                                                                         )
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , secretRef :
                                                                                       Optional
                                                                                         { name :
                                                                                             Optional
                                                                                               Text
                                                                                         }
                                                                                   }
                                                                             , flocker =
                                                                                 None
                                                                                   { datasetName :
                                                                                       Optional
                                                                                         Text
                                                                                   , datasetUUID :
                                                                                       Optional
                                                                                         Text
                                                                                   }
                                                                             , gcePersistentDisk =
                                                                                 None
                                                                                   { fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , partition :
                                                                                       Optional
                                                                                         Natural
                                                                                   , pdName :
                                                                                       Text
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   }
                                                                             , gitRepo =
                                                                                 None
                                                                                   { directory :
                                                                                       Optional
                                                                                         Text
                                                                                   , repository :
                                                                                       Text
                                                                                   , revision :
                                                                                       Optional
                                                                                         Text
                                                                                   }
                                                                             , glusterfs =
                                                                                 None
                                                                                   { endpoints :
                                                                                       Text
                                                                                   , path :
                                                                                       Text
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   }
                                                                             , hostPath =
                                                                                 None
                                                                                   { path :
                                                                                       Text
                                                                                   , type :
                                                                                       Optional
                                                                                         Text
                                                                                   }
                                                                             , iscsi =
                                                                                 None
                                                                                   { chapAuthDiscovery :
                                                                                       Optional
                                                                                         Bool
                                                                                   , chapAuthSession :
                                                                                       Optional
                                                                                         Bool
                                                                                   , fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , initiatorName :
                                                                                       Optional
                                                                                         Text
                                                                                   , iqn :
                                                                                       Text
                                                                                   , iscsiInterface :
                                                                                       Optional
                                                                                         Text
                                                                                   , lun :
                                                                                       Natural
                                                                                   , portals :
                                                                                       Optional
                                                                                         ( List
                                                                                             Text
                                                                                         )
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , secretRef :
                                                                                       Optional
                                                                                         { name :
                                                                                             Optional
                                                                                               Text
                                                                                         }
                                                                                   , targetPortal :
                                                                                       Text
                                                                                   }
                                                                             , name =
                                                                                 "ssh"
                                                                             , nfs =
                                                                                 None
                                                                                   { path :
                                                                                       Text
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , server :
                                                                                       Text
                                                                                   }
                                                                             , persistentVolumeClaim =
                                                                                 None
                                                                                   { claimName :
                                                                                       Text
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   }
                                                                             , photonPersistentDisk =
                                                                                 None
                                                                                   { fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , pdID :
                                                                                       Text
                                                                                   }
                                                                             , portworxVolume =
                                                                                 None
                                                                                   { fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , volumeID :
                                                                                       Text
                                                                                   }
                                                                             , projected =
                                                                                 None
                                                                                   { defaultMode :
                                                                                       Optional
                                                                                         Natural
                                                                                   , sources :
                                                                                       List
                                                                                         { configMap :
                                                                                             Optional
                                                                                               { items :
                                                                                                   Optional
                                                                                                     ( List
                                                                                                         { key :
                                                                                                             Text
                                                                                                         , mode :
                                                                                                             Optional
                                                                                                               Natural
                                                                                                         , path :
                                                                                                             Text
                                                                                                         }
                                                                                                     )
                                                                                               , name :
                                                                                                   Optional
                                                                                                     Text
                                                                                               , optional :
                                                                                                   Optional
                                                                                                     Bool
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
                                                                                                             Optional
                                                                                                               Natural
                                                                                                         , path :
                                                                                                             Text
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
                                                                                                         { key :
                                                                                                             Text
                                                                                                         , mode :
                                                                                                             Optional
                                                                                                               Natural
                                                                                                         , path :
                                                                                                             Text
                                                                                                         }
                                                                                                     )
                                                                                               , name :
                                                                                                   Optional
                                                                                                     Text
                                                                                               , optional :
                                                                                                   Optional
                                                                                                     Bool
                                                                                               }
                                                                                         , serviceAccountToken :
                                                                                             Optional
                                                                                               { audience :
                                                                                                   Optional
                                                                                                     Text
                                                                                               , expirationSeconds :
                                                                                                   Optional
                                                                                                     Natural
                                                                                               , path :
                                                                                                   Text
                                                                                               }
                                                                                         }
                                                                                   }
                                                                             , quobyte =
                                                                                 None
                                                                                   { group :
                                                                                       Optional
                                                                                         Text
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , registry :
                                                                                       Text
                                                                                   , tenant :
                                                                                       Optional
                                                                                         Text
                                                                                   , user :
                                                                                       Optional
                                                                                         Text
                                                                                   , volume :
                                                                                       Text
                                                                                   }
                                                                             , rbd =
                                                                                 None
                                                                                   { fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , image :
                                                                                       Text
                                                                                   , keyring :
                                                                                       Optional
                                                                                         Text
                                                                                   , monitors :
                                                                                       List
                                                                                         Text
                                                                                   , pool :
                                                                                       Optional
                                                                                         Text
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , secretRef :
                                                                                       Optional
                                                                                         { name :
                                                                                             Optional
                                                                                               Text
                                                                                         }
                                                                                   , user :
                                                                                       Optional
                                                                                         Text
                                                                                   }
                                                                             , scaleIO =
                                                                                 None
                                                                                   { fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , gateway :
                                                                                       Text
                                                                                   , protectionDomain :
                                                                                       Optional
                                                                                         Text
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , secretRef :
                                                                                       { name :
                                                                                           Optional
                                                                                             Text
                                                                                       }
                                                                                   , sslEnabled :
                                                                                       Optional
                                                                                         Bool
                                                                                   , storageMode :
                                                                                       Optional
                                                                                         Text
                                                                                   , storagePool :
                                                                                       Optional
                                                                                         Text
                                                                                   , system :
                                                                                       Text
                                                                                   , volumeName :
                                                                                       Optional
                                                                                         Text
                                                                                   }
                                                                             , secret = Some
                                                                               { defaultMode = Some
                                                                                   384
                                                                               , items =
                                                                                   None
                                                                                     ( List
                                                                                         { key :
                                                                                             Text
                                                                                         , mode :
                                                                                             Optional
                                                                                               Natural
                                                                                         , path :
                                                                                             Text
                                                                                         }
                                                                                     )
                                                                               , optional =
                                                                                   None
                                                                                     Bool
                                                                               , secretName = Some
                                                                                   "gitserver-ssh"
                                                                               }
                                                                             , storageos =
                                                                                 None
                                                                                   { fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , readOnly :
                                                                                       Optional
                                                                                         Bool
                                                                                   , secretRef :
                                                                                       Optional
                                                                                         { name :
                                                                                             Optional
                                                                                               Text
                                                                                         }
                                                                                   , volumeName :
                                                                                       Optional
                                                                                         Text
                                                                                   , volumeNamespace :
                                                                                       Optional
                                                                                         Text
                                                                                   }
                                                                             , vsphereVolume =
                                                                                 None
                                                                                   { fsType :
                                                                                       Optional
                                                                                         Text
                                                                                   , storagePolicyID :
                                                                                       Optional
                                                                                         Text
                                                                                   , storagePolicyName :
                                                                                       Optional
                                                                                         Text
                                                                                   , volumePath :
                                                                                       Text
                                                                                   }
                                                                             }
                                                                         ]

                                                             , …
                                                             }
                                                    , …
                                                    }
                                       , volumeClaimTemplates = Some
                                                                [ { spec = Some
                                                                           { resources = Some
                                                                                         { requests = Some
                                                                                                      [ { mapValue = "�[41m200G�[0m�[42m4T�[0m�[2mi�[0m"
                                                                                                        , …
                                                                                                        }
                                                                                                      ]

                                                                                         , …
                                                                                         }
                                                                           , …
                                                                           }
                                                                  , …
                                                                  }
                                                                ]

                                       , …
                                       }
                              , …
                              }
              , …
              }
, Grafana = { StatefulSet = { spec = Some
                                     { template = { spec = Some
                                                           { containers = [ { env = Some
                                                                                    ( [ + { name =
                                                                                              "GF_SERVER_ROOT_URL"
                                                                                          , value = Some
                                                                                              "https://k8s.sgdev.org/-/debug/grafana"
                                                                                          , valueFrom =
                                                                                              None
                                                                                                { configMapKeyRef :
                                                                                                    Optional
                                                                                                      { key :
                                                                                                          Text
                                                                                                      , name :
                                                                                                          Optional
                                                                                                            Text
                                                                                                      , optional :
                                                                                                          Optional
                                                                                                            Bool
                                                                                                      }
                                                                                                , fieldRef :
                                                                                                    Optional
                                                                                                      { apiVersion :
                                                                                                          Optional
                                                                                                            Text
                                                                                                      , fieldPath :
                                                                                                          Text
                                                                                                      }
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
                                                                                                , secretKeyRef :
                                                                                                    Optional
                                                                                                      { key :
                                                                                                          Text
                                                                                                      , name :
                                                                                                          Optional
                                                                                                            Text
                                                                                                      , optional :
                                                                                                          Optional
                                                                                                            Bool
                                                                                                      }
                                                                                                }
                                                                                          }
                                                                                      ]
                                                                                      - : …
                                                                                      +

                                                                                    )
                                                                            , image = Some
                                                                                      "�[2mindex.docker.io/sourcegraph/grafana:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[41mf3903�[0m�[42m6�[0m�[2m8�[0m�[41m4e�[0m�[2m2�[0m�[41mf57f�[0m�[2m3�[0m�[42m1�[0m�[2ma�[0m�[42m60ffc�[0m�[2mb�[0m�[41ma4eae4�[0m�[42mfb�[0m�[2m1�[0m�[41me�[0m�[42m04�[0m�[2m5�[0m�[41m1�[0m�[42m7�[0m�[2m3�[0m�[41m40�[0m�[2ma�[0m�[42mb�[0m�[2m5�[0m�[41m4�[0m�[42m3�[0m�[2m1�[0m�[41ma5�[0m�[42m9f�[0m�[2mb�[0m�[41m7a�[0m�[2m82�[0m�[41mee�[0m�[2m1�[0m�[41m6�[0m�[42m4�[0m�[2mb�[0m�[42m7�[0m�[2md�[0m�[41mce�[0m�[42m59292d�[0m�[2ma3�[0m�[41mcd�[0m�[2m9�[0m�[42mb9e�[0m�[2m5�[0m�[42mad�[0m�[2m2�[0m�[42ma6c6�[0m�[2m0�[0m�[41m423f193�[0m�[2ma�[0m�[42m9c0e81b�[0m"
                                                                            , resources = Some
                                                                                          { limits = Some
                                                                                                     [ - { mapKey =
                                                                                                             "memory"
                                                                                                         , mapValue =
                                                                                                             "512Mi"
                                                                                                         }
                                                                                                     , - { mapKey =
                                                                                                             "cpu"
                                                                                                         , mapValue =
                                                                                                             "1"
                                                                                                         }
                                                                                                     , + { mapKey =
                                                                                                             "memory"
                                                                                                         , mapValue =
                                                                                                             "100Mi"
                                                                                                         }
                                                                                                     , + { mapKey =
                                                                                                             "cpu"
                                                                                                         , mapValue =
                                                                                                             "100m"
                                                                                                         }
                                                                                                     , + { mapKey =
                                                                                                             "ephemeral-storage"
                                                                                                         , mapValue =
                                                                                                             "1Gi"
                                                                                                         }
                                                                                                     ]

                                                                                          , requests = Some
                                                                                                       [ { mapValue = "�[41m5�[0m�[2m1�[0m�[41m2�[0m�[42m00�[0m�[2mMi�[0m"
                                                                                                         , …
                                                                                                         }
                                                                                                       , …
                                                                                                       , + { mapKey =
                                                                                                               "ephemeral-storage"
                                                                                                           , mapValue =
                                                                                                               "1Gi"
                                                                                                           }
                                                                                                       ]

                                                                                          }
                                                                            , …
                                                                            }
                                                                          ]

                                                           , …
                                                           }
                                                  , …
                                                  }
                                     , …
                                     }
                            , …
                            }
            , …
            }
, IndexedSearch = { StatefulSet = { spec = Some
                                           { replicas = Some
                                                        - 1
                                                        + 2
                                           , template = { spec = Some
                                                                 { containers = [ { image = Some
                                                                                            "�[2mindex.docker.io/sourcegraph/indexed-searcher:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[41m832�[0m�[42mb55�[0m�[2m4�[0m�[41m9�[0m�[42m7e�[0m�[2m4�[0m�[42m41474c08ee�[0m�[2m3�[0m�[42m5�[0m�[2me�[0m�[42m09�[0m�[2m1�[0m�[41mb52466�[0m�[42m1�[0m�[2md�[0m�[42m44a�[0m�[2mc�[0m�[41m2�[0m�[42m7dd�[0m�[2m05�[0m�[42m9�[0m�[2m2�[0m�[41mcf�[0m�[2m8�[0m�[41m2b�[0m�[2mf�[0m�[41md22b18ad0�[0m�[2m45�[0m�[41m34�[0m�[42m81�[0m�[2m6�[0m�[42m999�[0m�[2md�[0m�[41m2b0e�[0m�[2ma�[0m�[41m403�[0m�[42m6�[0m�[2mb4�[0m�[41m6�[0m�[42m993e31�[0m�[2m7�[0m�[41m4f48�[0m�[2m2�[0m�[42m5a�[0m�[2m14�[0m�[41m602�[0m�[42m1�[0m"
                                                                                  , resources = Some
                                                                                                { limits = Some
                                                                                                           [ - { mapKey =
                                                                                                                   "memory"
                                                                                                               , mapValue =
                                                                                                                   "4G"
                                                                                                               }
                                                                                                           , - { mapKey =
                                                                                                                   "cpu"
                                                                                                               , mapValue =
                                                                                                                   "2"
                                                                                                               }
                                                                                                           , + { mapKey =
                                                                                                                   "memory"
                                                                                                               , mapValue =
                                                                                                                   "120Gi"
                                                                                                               }
                                                                                                           , + { mapKey =
                                                                                                                   "cpu"
                                                                                                               , mapValue =
                                                                                                                   "12"
                                                                                                               }
                                                                                                           , + { mapKey =
                                                                                                                   "ephemeral-storage"
                                                                                                               , mapValue =
                                                                                                                   "1Gi"
                                                                                                               }
                                                                                                           ]

                                                                                                , requests = Some
                                                                                                             [ - { mapKey =
                                                                                                                     "memory"
                                                                                                                 , mapValue =
                                                                                                                     "2G"
                                                                                                                 }
                                                                                                             , - { mapKey =
                                                                                                                     "cpu"
                                                                                                                 , mapValue =
                                                                                                                     "500m"
                                                                                                                 }
                                                                                                             , + { mapKey =
                                                                                                                     "memory"
                                                                                                                 , mapValue =
                                                                                                                     "120Gi"
                                                                                                                 }
                                                                                                             , + { mapKey =
                                                                                                                     "cpu"
                                                                                                                 , mapValue =
                                                                                                                     "12"
                                                                                                                 }
                                                                                                             , + { mapKey =
                                                                                                                     "ephemeral-storage"
                                                                                                                 , mapValue =
                                                                                                                     "1Gi"
                                                                                                                 }
                                                                                                             ]

                                                                                                }
                                                                                  , …
                                                                                  }
                                                                                , { image = Some
                                                                                            "�[2mindex.docker.io/sourcegraph/search-indexer:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[41mf31�[0m�[42m8�[0m�[2me�[0m�[41mc�[0m�[42meb8�[0m�[2m6�[0m�[42m6�[0m�[2m8�[0m�[41m2b907b�[0m�[42m4�[0m�[2md�[0m�[41me2�[0m�[42m6634�[0m�[2m9�[0m�[41m7�[0m�[42mc3418�[0m�[2m5�[0m�[42mb6c�[0m�[2macd�[0m�[41ma8�[0m�[42m54�[0m�[2m8�[0m�[41mee99ac�[0m�[42m1�[0m�[2m2�[0m�[41m6�[0m�[42m04�[0m�[2m8�[0m�[42m856�[0m�[2me�[0m�[41mf32�[0m�[42m6�[0m�[2ma7�[0m�[41m9�[0m�[2m3�[0m�[41m0�[0m�[42mb�[0m�[2m9�[0m�[42m17�[0m�[2ma�[0m�[41m6�[0m�[2m0�[0m�[41m36ef�[0m�[2m5�[0m�[41mf�[0m�[42m91�[0m�[2m2�[0m�[41m6e�[0m�[42m02�[0m�[2m8�[0m�[41ma�[0m�[2mf�[0m�[42me�[0m�[2m0�[0m�[42m4e�[0m�[2md�[0m�[41mcac�[0m�[42m1d�[0m"
                                                                                  , resources = Some
                                                                                                { limits = Some
                                                                                                           [ …
                                                                                                           , + { mapKey =
                                                                                                                   "ephemeral-storage"
                                                                                                               , mapValue =
                                                                                                                   "1Gi"
                                                                                                               }
                                                                                                           ]

                                                                                                , requests = Some
                                                                                                             [ …
                                                                                                             , + { mapKey =
                                                                                                                     "ephemeral-storage"
                                                                                                                 , mapValue =
                                                                                                                     "1Gi"
                                                                                                                 }
                                                                                                             ]

                                                                                                }
                                                                                  , …
                                                                                  }
                                                                                ]

                                                                 , …
                                                                 }
                                                        , …
                                                        }
                                           , volumeClaimTemplates = Some
                                                                    [ { spec = Some
                                                                               { resources = Some
                                                                                             { requests = Some
                                                                                                          [ { mapValue = "�[41m200G�[0m�[42m4T�[0m�[2mi�[0m"
                                                                                                            , …
                                                                                                            }
                                                                                                          ]

                                                                                             , …
                                                                                             }
                                                                               , …
                                                                               }
                                                                      , …
                                                                      }
                                                                    ]

                                           , …
                                           }
                                  , …
                                  }
                  , …
                  }
, IngressNginx = - None …
                 + Some …
, Jaeger = { Deployment = { spec = Some
                                   { template = { spec = Some
                                                         { containers = [ { resources = Some
                                                                                        { limits = Some
                                                                                                   [ …
                                                                                                   , + { mapKey =
                                                                                                           "ephemeral-storage"
                                                                                                       , mapValue =
                                                                                                           "1Gi"
                                                                                                       }
                                                                                                   ]

                                                                                        , requests = Some
                                                                                                     [ …
                                                                                                     , + { mapKey =
                                                                                                             "ephemeral-storage"
                                                                                                         , mapValue =
                                                                                                             "1Gi"
                                                                                                         }
                                                                                                     ]

                                                                                        }
                                                                          , …
                                                                          }
                                                                        ]

                                                         , …
                                                         }
                                                , …
                                                }
                                   , …
                                   }
                          , …
                          }
           , …
           }
, Postgres = { Deployment = { spec = Some
                                     { template = { spec = Some
                                                           { containers = [ { image = Some
                                                                                      "�[2mindex.docker.io/sourcegraph/postgres-11.4:�[0m�[41m3.16.1�[0m�[42minsiders�[0m�[2m@sha256:63090799b34b3115a387d96fe2227a37999d432b774a1d9b7966b8c5d81b56ad�[0m"
                                                                            , resources = Some
                                                                                          { limits = Some
                                                                                                     [ - { mapKey =
                                                                                                             "memory"
                                                                                                         , mapValue =
                                                                                                             "2Gi"
                                                                                                         }
                                                                                                     , - { mapKey =
                                                                                                             "cpu"
                                                                                                         , mapValue =
                                                                                                             "4"
                                                                                                         }
                                                                                                     , + { mapKey =
                                                                                                             "memory"
                                                                                                         , mapValue =
                                                                                                             "24Gi"
                                                                                                         }
                                                                                                     , + { mapKey =
                                                                                                             "cpu"
                                                                                                         , mapValue =
                                                                                                             "16"
                                                                                                         }
                                                                                                     , + { mapKey =
                                                                                                             "ephemeral-storage"
                                                                                                         , mapValue =
                                                                                                             "1Gi"
                                                                                                         }
                                                                                                     ]

                                                                                          , requests = Some
                                                                                                       [ - { mapKey =
                                                                                                               "memory"
                                                                                                           , mapValue =
                                                                                                               "2Gi"
                                                                                                           }
                                                                                                       , - { mapKey =
                                                                                                               "cpu"
                                                                                                           , mapValue =
                                                                                                               "4"
                                                                                                           }
                                                                                                       , + { mapKey =
                                                                                                               "memory"
                                                                                                           , mapValue =
                                                                                                               "24Gi"
                                                                                                           }
                                                                                                       , + { mapKey =
                                                                                                               "cpu"
                                                                                                           , mapValue =
                                                                                                               "16"
                                                                                                           }
                                                                                                       , + { mapKey =
                                                                                                               "ephemeral-storage"
                                                                                                           , mapValue =
                                                                                                               "1Gi"
                                                                                                           }
                                                                                                       ]

                                                                                          }
                                                                            , …
                                                                            }
                                                                          , …
                                                                          ]

                                                           , …
                                                           }
                                                  , …
                                                  }
                                     , …
                                     }
                            , …
                            }
             , …
             }
, PreciseCodeIntel = { BundleManager = { Deployment = { spec = Some
                                                               { template = { spec = Some
                                                                                     { containers = [ { image = Some
                                                                                                                "�[2mindex.docker.io/sourcegraph/precise-code-intel-bundle-manager:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[41m7�[0m�[42m5fe�[0m�[2mdf�[0m�[42m4�[0m�[2mf0�[0m�[41me7e8c7a345�[0m�[2m1�[0m�[41mce12cf�[0m�[2m5�[0m�[41meb�[0m�[42m8d�[0m�[2m5�[0m�[41me40�[0m�[42m6a�[0m�[2m7�[0m�[41m3b�[0m�[42mca�[0m�[2mb9�[0m�[41m502752�[0m�[42m8fb�[0m�[2m9�[0m�[41m26�[0m�[2ma�[0m�[41mcf3�[0m�[42m2�[0m�[2m3�[0m�[42m2�[0m�[2mf1�[0m�[41m3e�[0m�[42m7�[0m�[2mb�[0m�[42m4�[0m�[2m3�[0m�[41m7�[0m�[42me4d489�[0m�[2m0d�[0m�[41mc�[0m�[42mf�[0m�[2m5�[0m�[42m6�[0m�[2m7�[0m�[42m4177b�[0m�[2m0�[0m�[41mcc�[0m�[42me35�[0m�[2m8�[0m�[42mb5ff8a3d�[0m"
                                                                                                      , resources = Some
                                                                                                                    { limits = Some
                                                                                                                               [ …
                                                                                                                               , + { mapKey =
                                                                                                                                       "ephemeral-storage"
                                                                                                                                   , mapValue =
                                                                                                                                       "1Gi"
                                                                                                                                   }
                                                                                                                               ]

                                                                                                                    , requests = Some
                                                                                                                                 [ …
                                                                                                                                 , + { mapKey =
                                                                                                                                         "ephemeral-storage"
                                                                                                                                     , mapValue =
                                                                                                                                         "1Gi"
                                                                                                                                     }
                                                                                                                                 ]

                                                                                                                    }
                                                                                                      , …
                                                                                                      }
                                                                                                    ]

                                                                                     , …
                                                                                     }
                                                                            , …
                                                                            }
                                                               , …
                                                               }
                                                      , …
                                                      }
                                       , …
                                       }
                     , Worker = { Deployment = { spec = Some
                                                        { template = { spec = Some
                                                                              { containers = [ { image = Some
                                                                                                         "�[2mindex.docker.io/sourcegraph/precise-code-intel-worker:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[41m123dd�[0m�[42mf9�[0m�[2mc�[0m�[42md�[0m�[2ma�[0m�[42m51f68388�[0m�[2mb�[0m�[42m0b80�[0m�[2m9�[0m�[41m7�[0m�[2mc�[0m�[41m2�[0m�[42m64�[0m�[2m7�[0m�[41m359�[0m�[42me�[0m�[2m9�[0m�[41mb�[0m�[2m5�[0m�[41m69a76�[0m�[42m4d�[0m�[2mbc�[0m�[41md�[0m�[2m2�[0m�[41mc7dd7c�[0m�[42maa96�[0m�[2m4�[0m�[41m2�[0m�[2m3�[0m�[42mef�[0m�[2mc�[0m�[41m1d�[0m�[42m4b�[0m�[2me�[0m�[42mb�[0m�[2m8�[0m�[41m16fda1�[0m�[42me2�[0m�[2mc�[0m�[41m3�[0m�[42mb9cbc�[0m�[2m5�[0m�[42m6�[0m�[2mb�[0m�[41m78�[0m�[2m1�[0m�[41me004�[0m�[2mb�[0m�[41m4dde�[0m�[42m9c1675�[0m"
                                                                                               , resources = Some
                                                                                                             { limits = Some
                                                                                                                        [ …
                                                                                                                        , + { mapKey =
                                                                                                                                "ephemeral-storage"
                                                                                                                            , mapValue =
                                                                                                                                "1Gi"
                                                                                                                            }
                                                                                                                        ]

                                                                                                             , requests = Some
                                                                                                                          [ …
                                                                                                                          , + { mapKey =
                                                                                                                                  "ephemeral-storage"
                                                                                                                              , mapValue =
                                                                                                                                  "1Gi"
                                                                                                                              }
                                                                                                                          ]

                                                                                                             }
                                                                                               , …
                                                                                               }
                                                                                             ]

                                                                              , …
                                                                              }
                                                                     , …
                                                                     }
                                                        , …
                                                        }
                                               , …
                                               }
                                , …
                                }
                     }
, Prometheus = { Deployment = { spec = Some
                                       { template = { spec = Some
                                                             { containers = [ { image = Some
                                                                                        "�[2mindex.docker.io/sourcegraph/prometheus:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[42m96�[0m�[2ma�[0m�[42m0�[0m�[2m7�[0m�[41m25�[0m�[42mdb09f71f�[0m�[2m4�[0m�[42mc�[0m�[2m1�[0m�[41m9�[0m�[42m10ecee�[0m�[2ma�[0m�[41m5�[0m�[42m81�[0m�[2m3�[0m�[41m2�[0m�[42ma�[0m�[2mf�[0m�[42m48555�[0m�[2mb�[0m�[41m17�[0m�[2mf�[0m�[42mc�[0m�[2m6�[0m�[41m955�[0m�[2me�[0m�[41m80�[0m�[2mf�[0m�[42mc6�[0m�[2m8�[0m�[41ma�[0m�[42m900�[0m�[2m2�[0m�[41mf�[0m�[2m3�[0m�[41m5efe�[0m�[2m1�[0m�[41m528�[0m�[2m7�[0m�[41mc�[0m�[42m8�[0m�[2m0�[0m�[41ma556e4fe7�[0m�[42m8�[0m�[2m16�[0m�[42mb�[0m�[2m8�[0m�[41md5fc�[0m�[2m6�[0m�[41mff730d�[0m�[2m8�[0m�[42m232292�[0m"
                                                                              , resources = Some
                                                                                            { limits = Some
                                                                                                       [ …
                                                                                                       , + { mapKey =
                                                                                                               "ephemeral-storage"
                                                                                                           , mapValue =
                                                                                                               "1Gi"
                                                                                                           }
                                                                                                       ]

                                                                                            , requests = Some
                                                                                                         [ { mapValue = "�[41m3G�[0m�[42m500M�[0m"
                                                                                                           , …
                                                                                                           }
                                                                                                         , …
                                                                                                         , + { mapKey =
                                                                                                                 "ephemeral-storage"
                                                                                                             , mapValue =
                                                                                                                 "1Gi"
                                                                                                             }
                                                                                                         ]

                                                                                            }
                                                                              , …
                                                                              }
                                                                            ]

                                                             , …
                                                             }
                                                    , …
                                                    }
                                       , …
                                       }
                              , …
                              }
               , …
               }
, QueryRunner = { Deployment = { spec = Some
                                        { template = { spec = Some
                                                              { containers = [ { image = Some
                                                                                         "�[2mindex.docker.io/sourcegraph/query-runner:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[42me�[0m�[2m7�[0m�[41m3f1a1116f�[0m�[42m8b�[0m�[2me�[0m�[41m1�[0m�[2m2�[0m�[41mc8384c5�[0m�[42m9ed�[0m�[2m7�[0m�[41mf0�[0m�[42m5�[0m�[2m8�[0m�[42m93�[0m�[2m1b�[0m�[41mb4af5�[0m�[42m6�[0m�[2m0e�[0m�[41m7�[0m�[2m0�[0m�[41m00�[0m�[2me�[0m�[41m35�[0m�[2m8�[0m�[42m42c�[0m�[2m9�[0m�[41mb�[0m�[42m49�[0m�[2mc�[0m�[42mfe3�[0m�[2mc�[0m�[42m9c�[0m�[2m0�[0m�[41m4�[0m�[42mf56093e�[0m�[2m2�[0m�[42m0�[0m�[2m2�[0m�[41m4c5�[0m�[42m1928�[0m�[2mb�[0m�[41mf�[0m�[2mb2�[0m�[41m0f404a�[0m�[42m58c355�[0m�[2mf�[0m�[41md�[0m�[42m36ee�[0m"
                                                                               , resources = Some
                                                                                             { limits = Some
                                                                                                        [ …
                                                                                                        , + { mapKey =
                                                                                                                "ephemeral-storage"
                                                                                                            , mapValue =
                                                                                                                "1Gi"
                                                                                                            }
                                                                                                        ]

                                                                                             , requests = Some
                                                                                                          [ …
                                                                                                          , + { mapKey =
                                                                                                                  "ephemeral-storage"
                                                                                                              , mapValue =
                                                                                                                  "1Gi"
                                                                                                              }
                                                                                                          ]

                                                                                             }
                                                                               , …
                                                                               }
                                                                             , …
                                                                             ]

                                                              , …
                                                              }
                                                     , …
                                                     }
                                        , …
                                        }
                               , …
                               }
                , …
                }
, Redis = { Cache = { Deployment = { spec = Some
                                            { template = { spec = Some
                                                                  { containers = [ { image = Some
                                                                                             "�[2mindex.docker.io/sourcegraph/redis-cache:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:7820219195ab3e8fdae5875cd690fed1b2a01fd1063bd94210c0e9d529c38e56�[0m"
                                                                                   , resources = Some
                                                                                                 { limits = Some
                                                                                                            [ …
                                                                                                            , + { mapKey =
                                                                                                                    "ephemeral-storage"
                                                                                                                , mapValue =
                                                                                                                    "1Gi"
                                                                                                                }
                                                                                                            ]

                                                                                                 , requests = Some
                                                                                                              [ …
                                                                                                              , + { mapKey =
                                                                                                                      "ephemeral-storage"
                                                                                                                  , mapValue =
                                                                                                                      "1Gi"
                                                                                                                  }
                                                                                                              ]

                                                                                                 }
                                                                                   , …
                                                                                   }
                                                                                 , …
                                                                                 ]

                                                                  , …
                                                                  }
                                                         , …
                                                         }
                                            , …
                                            }
                                   , …
                                   }
                    , …
                    }
          , Store = { Deployment = { spec = Some
                                            { template = { spec = Some
                                                                  { containers = [ { image = Some
                                                                                             "�[2mindex.docker.io/sourcegraph/redis-store:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:e8467a8279832207559bdfbc4a89b68916ecd5b44ab5cf7620c995461c005168�[0m"
                                                                                   , resources = Some
                                                                                                 { limits = Some
                                                                                                            [ …
                                                                                                            , + { mapKey =
                                                                                                                    "ephemeral-storage"
                                                                                                                , mapValue =
                                                                                                                    "1Gi"
                                                                                                                }
                                                                                                            ]

                                                                                                 , requests = Some
                                                                                                              [ …
                                                                                                              , + { mapKey =
                                                                                                                      "ephemeral-storage"
                                                                                                                  , mapValue =
                                                                                                                      "1Gi"
                                                                                                                  }
                                                                                                              ]

                                                                                                 }
                                                                                   , …
                                                                                   }
                                                                                 , …
                                                                                 ]

                                                                  , …
                                                                  }
                                                         , …
                                                         }
                                            , …
                                            }
                                   , …
                                   }
                    , …
                    }
          }
, Replacer = { Deployment = { spec = Some
                                     { template = { spec = Some
                                                           { containers = [ { image = Some
                                                                                      "�[2mindex.docker.io/sourcegraph/replacer:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[42m1b1�[0m�[2ma�[0m�[41md4748e62�[0m�[2mf�[0m�[41md�[0m�[42m9a�[0m�[2mc�[0m�[41m7e�[0m�[42m5c�[0m�[2me�[0m�[41m49�[0m�[2m3�[0m�[42m58009b99b9d5f69c�[0m�[2m2�[0m�[41m7�[0m�[2m4�[0m�[41m70�[0m�[42m854�[0m�[2m6�[0m�[41maa�[0m�[2me�[0m�[41m51�[0m�[42m38�[0m�[2m6�[0m�[41mb�[0m�[42ma�[0m�[2mb�[0m�[42m4�[0m�[2m5�[0m�[42m6d6�[0m�[2m1�[0m�[41mb3b�[0m�[2mf�[0m�[42m6c�[0m�[2md�[0m�[41ma81�[0m�[42m39�[0m�[2md�[0m�[41m1af4�[0m�[2m2�[0m�[41m1f2f9454�[0m�[2m3�[0m�[41md7�[0m�[2m1�[0m�[42m0�[0m�[2ma�[0m�[41m42�[0m�[42m7�[0m�[2m4�[0m�[42m9b09�[0m"
                                                                            , resources = Some
                                                                                          { limits = Some
                                                                                                     [ …
                                                                                                     , + { mapKey =
                                                                                                             "ephemeral-storage"
                                                                                                         , mapValue =
                                                                                                             "1Gi"
                                                                                                         }
                                                                                                     ]

                                                                                          , requests = Some
                                                                                                       [ …
                                                                                                       , + { mapKey =
                                                                                                               "ephemeral-storage"
                                                                                                           , mapValue =
                                                                                                               "1Gi"
                                                                                                           }
                                                                                                       ]

                                                                                          }
                                                                            , …
                                                                            }
                                                                          , …
                                                                          ]

                                                           , …
                                                           }
                                                  , …
                                                  }
                                     , …
                                     }
                            , …
                            }
             , …
             }
, RepoUpdater = { Deployment = { spec = Some
                                        { template = { spec = Some
                                                              { containers = [ { image = Some
                                                                                         "�[2mindex.docker.io/sourcegraph/repo-updater:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[41m1db�[0m�[42m98ff�[0m�[2m6�[0m�[42m7f�[0m�[2me�[0m�[41m134�[0m�[42m5�[0m�[2m3�[0m�[42m1�[0m�[2me�[0m�[41m65�[0m�[42mf�[0m�[2ma�[0m�[42m079�[0m�[2m4�[0m�[42mec�[0m�[2mb�[0m�[42mba43d403a2�[0m�[2mf�[0m�[41m8�[0m�[42m3d�[0m�[2mf�[0m�[42m1c�[0m�[2m6�[0m�[41md�[0m�[2m0�[0m�[41mb524�[0m�[42ma�[0m�[2md�[0m�[42m65�[0m�[2mc�[0m�[42m48�[0m�[2md�[0m�[41m722b�[0m�[2m1�[0m�[41mfb�[0m�[42m6�[0m�[2mb�[0m�[41me4172�[0m�[42m0�[0m�[2m2�[0m�[41m7e6�[0m�[42ma�[0m�[2m6�[0m�[41m42b1d�[0m�[42m9�[0m�[2me8�[0m�[41m24�[0m�[2md�[0m�[41me966ff�[0m�[42m01�[0m�[2mc�[0m�[41m8�[0m�[42mda7�[0m"
                                                                               , resources = Some
                                                                                             { limits = Some
                                                                                                        [ …
                                                                                                        , + { mapKey =
                                                                                                                "ephemeral-storage"
                                                                                                            , mapValue =
                                                                                                                "1Gi"
                                                                                                            }
                                                                                                        ]

                                                                                             , requests = Some
                                                                                                          [ …
                                                                                                          , + { mapKey =
                                                                                                                  "ephemeral-storage"
                                                                                                              , mapValue =
                                                                                                                  "1Gi"
                                                                                                              }
                                                                                                          ]

                                                                                             }
                                                                               , …
                                                                               }
                                                                             , …
                                                                             ]

                                                              , …
                                                              }
                                                     , …
                                                     }
                                        , …
                                        }
                               , …
                               }
                , …
                }
, Searcher = { Deployment = { spec = Some
                                     { template = { spec = Some
                                                           { containers = [ { image = Some
                                                                                      "�[2mindex.docker.io/sourcegraph/searcher:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[41m7813�[0m�[42m5�[0m�[2md4�[0m�[41m4b378e6c�[0m�[42md�[0m�[2me�[0m�[41m9f8�[0m�[42m4�[0m�[2m5�[0m�[41mbbe8a�[0m�[42mc0�[0m�[2m3�[0m�[41m78�[0m�[2ma�[0m�[41m6�[0m�[42mc�[0m�[2mb�[0m�[42m5�[0m�[2m6�[0m�[41m71�[0m�[2mf�[0m�[41m5�[0m�[2m2�[0m�[41m55453�[0m�[42m2b�[0m�[2m6�[0m�[41m9�[0m�[2mf�[0m�[41mc4�[0m�[42m61�[0m�[2md�[0m�[41m8b�[0m�[42m9�[0m�[2m22�[0m�[42m060�[0m�[2m98�[0m�[42m7b1f5aa5b22e�[0m�[2m4�[0m�[42m3�[0m�[2mc�[0m�[41md�[0m�[2m9�[0m�[41mb�[0m�[42mc2�[0m�[2mff�[0m�[41me�[0m�[2m4�[0m�[42m9a1�[0m�[2mb�[0m�[42m3f25�[0m�[2m1�[0m�[42mc0�[0m"
                                                                            , resources = Some
                                                                                          { limits = Some
                                                                                                     [ …
                                                                                                     , + { mapKey =
                                                                                                             "ephemeral-storage"
                                                                                                         , mapValue =
                                                                                                             "1Gi"
                                                                                                         }
                                                                                                     ]

                                                                                          , requests = Some
                                                                                                       [ …
                                                                                                       , + { mapKey =
                                                                                                               "ephemeral-storage"
                                                                                                           , mapValue =
                                                                                                               "1Gi"
                                                                                                           }
                                                                                                       ]

                                                                                          }
                                                                            , …
                                                                            }
                                                                          , …
                                                                          ]

                                                           , …
                                                           }
                                                  , …
                                                  }
                                     , …
                                     }
                            , …
                            }
             , …
             }
, StorageClass = - None …
                 + Some …
, Symbols = { Deployment = { spec = Some
                                    { template = { spec = Some
                                                          { containers = [ { image = Some
                                                                                     "�[2mindex.docker.io/sourcegraph/symbols:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:�[0m�[41m224�[0m�[2me�[0m�[41m1�[0m�[42ma�[0m�[2m6�[0m�[42mfd�[0m�[2m7�[0m�[42mb�[0m�[2m5�[0m�[41m86�[0m�[2mf�[0m�[41m927�[0m�[42m5b33�[0m�[2mc�[0m�[42m5�[0m�[2m6�[0m�[41m0�[0m�[42m3b69�[0m�[2mf�[0m�[41ma�[0m�[42m7�[0m�[2mf�[0m�[41m345�[0m�[2m0�[0m�[41m27�[0m�[42m1�[0m�[2m4�[0m�[41m52a�[0m�[42mc89c�[0m�[2ma�[0m�[41m035�[0m�[2me�[0m�[42mf3�[0m�[2me�[0m�[41mb�[0m�[42m9�[0m�[2m2�[0m�[41md65dd6�[0m�[42mfb03�[0m�[2m8�[0m�[42m6�[0m�[2m2�[0m�[41m1�[0m�[2m6�[0m�[41m078�[0m�[42mb�[0m�[2m3�[0m�[42m49ab77c7e�[0m�[2m3�[0m�[42m62�[0m�[2md�[0m�[42m5c8�[0m�[2m2�[0m�[41m669030e4f�[0m"
                                                                           , resources = Some
                                                                                         { limits = Some
                                                                                                    [ …
                                                                                                    , + { mapKey =
                                                                                                            "ephemeral-storage"
                                                                                                        , mapValue =
                                                                                                            "1Gi"
                                                                                                        }
                                                                                                    ]

                                                                                         , requests = Some
                                                                                                      [ …
                                                                                                      , + { mapKey =
                                                                                                              "ephemeral-storage"
                                                                                                          , mapValue =
                                                                                                              "1Gi"
                                                                                                          }
                                                                                                      ]

                                                                                         }
                                                                           , …
                                                                           }
                                                                         , …
                                                                         ]

                                                          , …
                                                          }
                                                 , …
                                                 }
                                    , …
                                    }
                           , …
                           }
            , …
            }
, SyntaxHighlighter = { Deployment = { spec = Some
                                              { template = { spec = Some
                                                                    { containers = [ { image = Some
                                                                                               "�[2mindex.docker.io/sourcegraph/syntax-highlighter:�[0m�[41m3.17.2�[0m�[42minsiders�[0m�[2m@sha256:aa93514b7bc3aaf7a4e9c92e5ff52ee5052db6fb101255a69f054e5b8cdb46ff�[0m"
                                                                                     , resources = Some
                                                                                                   { limits = Some
                                                                                                              [ …
                                                                                                              , + { mapKey =
                                                                                                                      "ephemeral-storage"
                                                                                                                  , mapValue =
                                                                                                                      "1Gi"
                                                                                                                  }
                                                                                                              ]

                                                                                                   , requests = Some
                                                                                                                [ …
                                                                                                                , + { mapKey =
                                                                                                                        "ephemeral-storage"
                                                                                                                    , mapValue =
                                                                                                                        "1Gi"
                                                                                                                    }
                                                                                                                ]

                                                                                                   }
                                                                                     , …
                                                                                     }
                                                                                   ]

                                                                    , …
                                                                    }
                                                           , …
                                                           }
                                              , …
                                              }
                                     , …
                                     }
                      , …
                      }
}
```
