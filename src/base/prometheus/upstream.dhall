{ ClusterRole =
  { aggregationRule =
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
                      Optional (List { mapKey : Text, mapValue : Text })
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
      [ { mapKey = "category", mapValue = "rbac" }
      , { mapKey = "deploy", mapValue = "sourcegraph" }
      , { mapKey = "sourcegraph-resource-requires", mapValue = "cluster-admin" }
      ]
    , managedFields =
        None
          ( List
              { apiVersion : Text
              , fieldsType : Optional Text
              , fieldsV1 : Optional (List { mapKey : Text, mapValue : Text })
              , manager : Optional Text
              , operation : Optional Text
              , time : Optional Text
              }
          )
    , name = Some "prometheus"
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
    [ { apiGroups = Some [ "" ]
      , nonResourceURLs = None (List Text)
      , resourceNames = None (List Text)
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
    , { apiGroups = Some [ "" ]
      , nonResourceURLs = None (List Text)
      , resourceNames = None (List Text)
      , resources = Some [ "configmaps" ]
      , verbs = [ "get" ]
      }
    , { apiGroups = None (List Text)
      , nonResourceURLs = Some [ "/metrics" ]
      , resourceNames = None (List Text)
      , resources = None (List Text)
      , verbs = [ "get" ]
      }
    ]
  }
, ClusterRoleBinding =
  { apiVersion = "rbac.authorization.k8s.io/v1"
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
      [ { mapKey = "category", mapValue = "rbac" }
      , { mapKey = "deploy", mapValue = "sourcegraph" }
      , { mapKey = "sourcegraph-resource-requires", mapValue = "cluster-admin" }
      ]
    , managedFields =
        None
          ( List
              { apiVersion : Text
              , fieldsType : Optional Text
              , fieldsV1 : Optional (List { mapKey : Text, mapValue : Text })
              , manager : Optional Text
              , operation : Optional Text
              , time : Optional Text
              }
          )
    , name = Some "prometheus"
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
  , roleRef = { apiGroup = "", kind = "ClusterRole", name = "prometheus" }
  , subjects = Some
    [ { apiGroup = None Text
      , kind = "ServiceAccount"
      , name = "prometheus"
      , namespace = Some "default"
      }
    ]
  }
, ConfigMap =
  { apiVersion = "v1"
  , binaryData = None (List { mapKey : Text, mapValue : Text })
  , data = Some
    [ { mapKey = "alert_rules.yml"
      , mapValue =
          ''
          groups:
            - name: alert.rules
              rules:
                - alert: PodsMissing
                  expr: app:up:ratio{app!=""} < 0.9
                  for: 10m
                  labels:
                    severity: page
                  annotations:
                    description: 'Pods missing from {{`{{`}} $labels.app {{`}}`}}: {{`{{`}} $value
                  {{`}}`}}'
                    help: Alerts when pods are missing.
                    summary: Pods missing from {{`{{`}} $labels.app {{`}}`}}
                - alert: NoPodsRunning
                  expr: app:up:ratio{app!=""} < 0.1
                  for: 2m
                  labels:
                    severity: page
                  annotations:
                    description: 'No pods are running for {{`{{`}} $labels.app {{`}}`}}: {{`{{`}}
                  $value {{`}}`}}'
                    help: Alerts when no pods are running for a service.
                    summary: No pods are running for {{`{{`}} $labels.app {{`}}`}}
                - alert: ProdPageLoadLatency
                  expr: histogram_quantile(0.9, sum by(le) (rate(src_http_request_duration_seconds_bucket{job="sourcegraph-frontend",route!="raw"}[10m])))
                    > 20
                  labels:
                    severity: page
                  annotations:
                    description: 'Page load latency > 20s (90th percentile over all routes; current
                  value: {{`{{`}}$value{{`}}`}}s)'
                    help: Alerts when the page load latency is too high.
                    summary: High page load latency
                - alert: GoroutineLeak
                  expr: go_goroutines >= 10000
                  for: 10m
                  annotations:
                    description: '{{`{{`}} $labels.app {{`}}`}} has more than 10k goroutines. This
                  is probably a regression causing a goroutine leak'
                    help: Alerts when a service has excessive running goroutines.
                    summary: Excessive number of goroutines
                - alert: FSINodesRemainingLow
                  expr: sum by(instance) (container_fs_inodes_total{pod_name!=""}) > 3e+06
                  labels:
                    severity: page
                  annotations:
                    description: '{{`{{`}}$labels.instance{{`}}`}} is using {{`{{`}}humanize $value{{`}}`}}
                  inodes'
                    help: Alerts when a node's remaining FS inodes are low.
                    summary: '{{`{{`}}$labels.instance{{`}}`}} remaining fs inodes is low'
                - alert: DiskSpaceLow
                  expr: node:k8snode_filesystem_avail_bytes:ratio < 0.1
                  annotations:
                    help: Alerts when a node has less than 10% available disk space.
                    summary: '{{`{{`}}$labels.exported_name{{`}}`}} has less than 10% available
                  disk space'
                - alert: DiskSpaceLowCritical
                  expr: node:k8snode_filesystem_avail_bytes:ratio{exported_name=~".*prod.*"} < 0.05
                  labels:
                    severity: page
                  annotations:
                    help: Alerts when a node has less than 5% available disk space.
                    summary: Critical! {{`{{`}}$labels.exported_name{{`}}`}} has less than 5% available
                      disk space
                - alert: GitserverDiskSpaceLow
                  expr: src_gitserver_disk_space_available / src_gitserver_disk_space_total < 0.1
                  annotations:
                    help: Alerts when gitserverdisk space is low.
                    summary: gitserver {{`{{`}}$labels.instance{{`}}`}} disk space is less than 10% of available disk space
                - alert: GitserverDiskSpaceLowCritical
                  expr: src_gitserver_disk_space_available / src_gitserver_disk_space_total < 0.05
                  labels:
                    severity: page
                  annotations:
                    help: Alerts when gitserverdisk space is critically low.
                    summary: Critical! gitserver {{`{{`}}$labels.instance{{`}}`}} disk space is less than 5% of available disk space
                - alert: SearcherErrorRatioTooHigh
                  expr: searcher_errors:ratio10m > 0.1
                  for: 20m
                  annotations:
                    help: Alerts when the search service has more than 10% of requests failing.
                    summary: Error ratio exceeds 10%
                - alert: PrometheusMetricsBloat
                  expr: http_response_size_bytes{handler="prometheus",job!="kubernetes-apiservers",job!="kubernetes-nodes",quantile="0.5"}
                    > 20000
                  annotations:
                    help: Alerts when a service is probably leaking metrics (unbounded attribute).
                    summary: '{{`{{`}}$labels.job{{`}}`}} in {{`{{`}}$labels.ns{{`}}`}} is probably
                  leaking metrics (unbounded attribute)'
          ''
      }
    , { mapKey = "extra_rules.yml", mapValue = "" }
    , { mapKey = "node_rules.yml"
      , mapValue =
          ''
          groups:
            - name: nodes.rules
              rules:
                - record: node:container_cpu_usage_seconds_total:ratio_rate5m
                  expr: sum by(instance) (rate(container_cpu_usage_seconds_total{kubernetes_pod_name=""}[5m]))
                    / max by(instance) (machine_cpu_cores)
                - record: task:container_memory_usage_bytes:max
                  expr: max by(namespace, container_name) (container_memory_usage_bytes{container_name!=""})
                - record: task:container_cpu_usage_seconds_total:sum
                  expr: sum by(id, namespace, container_name) (irate(container_cpu_usage_seconds_total{container_name!=""}[1m]))
                - record: node:k8snode_filesystem_avail_bytes:ratio
                  expr: min by(exported_name) (k8snode_filesystem_avail_bytes / k8snode_filesystem_size_bytes)
          ''
      }
    , { mapKey = "prometheus.yml"
      , mapValue =
          ''
          global:
            scrape_interval:     30s
            evaluation_interval: 30s

          alerting:
            alertmanagers:
              - kubernetes_sd_configs:
                - role: endpoints
                relabel_configs:
                  - source_labels: [__meta_kubernetes_service_name]
                    regex: alertmanager
                    action: keep

          rule_files:
            - '*_rules.yml'
            - "/sg_config_prometheus/*_rules.yml"
            - "/sg_prometheus_add_ons/*_rules.yml"

          # A scrape configuration for running Prometheus on a Kubernetes cluster.
          # This uses separate scrape configs for cluster components (i.e. API server, node)
          # and services to allow each to use different authentication configs.
          #
          # Kubernetes labels will be added as Prometheus labels on metrics via the
          # `labelmap` relabeling action.

          # Scrape config for API servers.
          #
          # Kubernetes exposes API servers as endpoints to the default/kubernetes
          # service so this uses `endpoints` role and uses relabelling to only keep
          # the endpoints associated with the default/kubernetes service using the
          # default named port `https`. This works for single API server deployments as
          # well as HA API server deployments.
          scrape_configs:
          - job_name: 'kubernetes-apiservers'

            kubernetes_sd_configs:
            - role: endpoints

            # Default to scraping over https. If required, just disable this or change to
            # `http`.
            scheme: https

            # This TLS & bearer token file config is used to connect to the actual scrape
            # endpoints for cluster components. This is separate to discovery auth
            # configuration because discovery & scraping are two separate concerns in
            # Prometheus. The discovery auth config is automatic if Prometheus runs inside
            # the cluster. Otherwise, more config options have to be provided within the
            # <kubernetes_sd_config>.
            tls_config:
              ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
              # If your node certificates are self-signed or use a different CA to the
              # master CA, then disable certificate verification below. Note that
              # certificate verification is an integral part of a secure infrastructure
              # so this should only be disabled in a controlled environment. You can
              # disable certificate verification by uncommenting the line below.
              #
              # insecure_skip_verify: true
            bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token

            # Keep only the default/kubernetes service endpoints for the https port. This
            # will add targets for each API server which Kubernetes adds an endpoint to
            # the default/kubernetes service.
            relabel_configs:
            - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
              action: keep
              regex: default;kubernetes;https

          - job_name: 'kubernetes-nodes'

            # Default to scraping over https. If required, just disable this or change to
            # `http`.
            scheme: https

            # This TLS & bearer token file config is used to connect to the actual scrape
            # endpoints for cluster components. This is separate to discovery auth
            # configuration because discovery & scraping are two separate concerns in
            # Prometheus. The discovery auth config is automatic if Prometheus runs inside
            # the cluster. Otherwise, more config options have to be provided within the
            # <kubernetes_sd_config>.
            tls_config:
              ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
              # If your node certificates are self-signed or use a different CA to the
              # master CA, then disable certificate verification below. Note that
              # certificate verification is an integral part of a secure infrastructure
              # so this should only be disabled in a controlled environment. You can
              # disable certificate verification by uncommenting the line below.
              #
              insecure_skip_verify: true
            bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token

            kubernetes_sd_configs:
            - role: node

            relabel_configs:
            - action: labelmap
              regex: __meta_kubernetes_node_label_(.+)
            - target_label: __address__
              replacement: kubernetes.default.svc:443
            - source_labels: [__meta_kubernetes_node_name]
              regex: (.+)
              target_label: __metrics_path__
              replacement: /api/v1/nodes/''${1}/proxy/metrics

          # Scrape config for service endpoints.
          #
          # The relabeling allows the actual service scrape endpoint to be configured
          # via the following annotations:
          #
          # * `prometheus.io/scrape`: Only scrape services that have a value of `true`
          # * `prometheus.io/scheme`: If the metrics endpoint is secured then you will need
          # to set this to `https` & most likely set the `tls_config` of the scrape config.
          # * `prometheus.io/path`: If the metrics path is not `/metrics` override this.
          # * `prometheus.io/port`: If the metrics are exposed on a different port to the
          # service then set this appropriately.
          - job_name: 'kubernetes-service-endpoints'

            kubernetes_sd_configs:
            - role: endpoints

            relabel_configs:
            - source_labels: [__meta_kubernetes_service_annotation_sourcegraph_prometheus_scrape]
              action: keep
              regex: true
            - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scheme]
              action: replace
              target_label: __scheme__
              regex: (https?)
            - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_path]
              action: replace
              target_label: __metrics_path__
              regex: (.+)
            - source_labels: [__address__, __meta_kubernetes_service_annotation_prometheus_io_port]
              action: replace
              target_label: __address__
              regex: (.+)(?::\d+);(\d+)
              replacement: $1:$2
            - action: labelmap
              regex: __meta_kubernetes_service_label_(.+)
            - source_labels: [__meta_kubernetes_namespace]
              action: replace
              # Sourcegraph specific customization. We want a more convenient to type label.
              # target_label: kubernetes_namespace
              target_label: ns
            - source_labels: [__meta_kubernetes_service_name]
              action: replace
              target_label: kubernetes_name
            # Sourcegraph specific customization. We want a nicer name for job
            - source_labels: [app]
              action: replace
              target_label: job
            # Sourcegraph specific customization. We want a nicer name for instance
            - source_labels: [__meta_kubernetes_pod_name]
              action: replace
              target_label: instance

          # Example scrape config for probing services via the Blackbox Exporter.
          #
          # The relabeling allows the actual service scrape endpoint to be configured
          # via the following annotations:
          #
          # * `prometheus.io/probe`: Only probe services that have a value of `true`
          - job_name: 'kubernetes-services'

            metrics_path: /probe
            params:
              module: [http_2xx]

            kubernetes_sd_configs:
            - role: service

            relabel_configs:
            - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_probe]
              action: keep
              regex: true
            - source_labels: [__address__]
              target_label: __param_target
            - target_label: __address__
              replacement: blackbox
            - source_labels: [__param_target]
              target_label: instance
            - action: labelmap
              regex: __meta_kubernetes_service_label_(.+)
            - source_labels: [__meta_kubernetes_service_namespace]
              # Sourcegraph specific customization. We want a more convenient to type label.
              # target_label: kubernetes_namespace
              target_label: ns
            - source_labels: [__meta_kubernetes_service_name]
              target_label: kubernetes_name

          # Example scrape config for pods
          #
          # The relabeling allows the actual pod scrape endpoint to be configured via the
          # following annotations:
          #
          # * `prometheus.io/scrape`: Only scrape pods that have a value of `true`
          # * `prometheus.io/path`: If the metrics path is not `/metrics` override this.
          # * `prometheus.io/port`: Scrape the pod on the indicated port instead of the default of `9102`.
          - job_name: 'kubernetes-pods'

            kubernetes_sd_configs:
            - role: pod

            relabel_configs:
            - source_labels: [__meta_kubernetes_pod_annotation_sourcegraph_prometheus_scrape]
              action: keep
              regex: true
            - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]
              action: replace
              target_label: __metrics_path__
              regex: (.+)
            - source_labels: [__address__, __meta_kubernetes_pod_annotation_prometheus_io_port]
              action: replace
              regex: (.+):(?:\d+);(\d+)
              replacement: ''${1}:''${2}
              target_label: __address__
            - action: labelmap
              regex: __meta_kubernetes_pod_label_(.+)
            - source_labels: [__meta_kubernetes_namespace]
              action: replace
              # Sourcegraph specific customization. We want a more convenient to type label.
              # target_label: kubernetes_namespace
              target_label: ns
            - source_labels: [__meta_kubernetes_pod_name]
              action: replace
              target_label: kubernetes_pod_name
          ''
      }
    , { mapKey = "sourcegraph_rules.yml"
      , mapValue =
          ''
          groups:
            - name: sourcegraph.rules
              rules:
                - record: app:up:sum
                  expr: sum by(app) (up)
                - record: app:up:count
                  expr: count by(app) (up)
                - record: app:up:ratio
                  expr: app:up:sum / on(app) app:up:count
          ''
      }
    ]
  , kind = "ConfigMap"
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
      [ { mapKey = "deploy", mapValue = "sourcegraph" }
      , { mapKey = "sourcegraph-resource-requires"
        , mapValue = "no-cluster-admin"
        }
      ]
    , managedFields =
        None
          ( List
              { apiVersion : Text
              , fieldsType : Optional Text
              , fieldsV1 : Optional (List { mapKey : Text, mapValue : Text })
              , manager : Optional Text
              , operation : Optional Text
              , time : Optional Text
              }
          )
    , name = Some "prometheus"
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
  }
, Deployment =
  { apiVersion = "apps/v1"
  , kind = "Deployment"
  , metadata =
    { annotations = Some
      [ { mapKey = "description"
        , mapValue = "Collects metrics and aggregates them into graphs."
        }
      ]
    , clusterName = None Text
    , creationTimestamp = None Text
    , deletionGracePeriodSeconds = None Natural
    , deletionTimestamp = None Text
    , finalizers = None (List Text)
    , generateName = None Text
    , generation = None Natural
    , labels = Some
      [ { mapKey = "deploy", mapValue = "sourcegraph" }
      , { mapKey = "sourcegraph-resource-requires"
        , mapValue = "no-cluster-admin"
        }
      ]
    , managedFields =
        None
          ( List
              { apiVersion : Text
              , fieldsType : Optional Text
              , fieldsV1 : Optional (List { mapKey : Text, mapValue : Text })
              , manager : Optional Text
              , operation : Optional Text
              , time : Optional Text
              }
          )
    , name = Some "prometheus"
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
                { key : Text, operator : Text, values : Optional (List Text) }
            )
      , matchLabels = Some [ { mapKey = "app", mapValue = "prometheus" } ]
      }
    , strategy = Some
      { rollingUpdate =
          None
            { maxSurge : Optional < Int : Natural | String : Text >
            , maxUnavailable : Optional < Int : Natural | String : Text >
            }
      , type = Some "Recreate"
      }
    , template =
      { metadata =
        { annotations = None (List { mapKey : Text, mapValue : Text })
        , clusterName = None Text
        , creationTimestamp = None Text
        , deletionGracePeriodSeconds = None Natural
        , deletionTimestamp = None Text
        , finalizers = None (List Text)
        , generateName = None Text
        , generation = None Natural
        , labels = Some
          [ { mapKey = "app", mapValue = "prometheus" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          ]
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
                                            , values : Optional (List Text)
                                            }
                                        )
                                  , matchFields :
                                      Optional
                                        ( List
                                            { key : Text
                                            , operator : Text
                                            , values : Optional (List Text)
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
                                          , values : Optional (List Text)
                                          }
                                      )
                                , matchFields :
                                    Optional
                                      ( List
                                          { key : Text
                                          , operator : Text
                                          , values : Optional (List Text)
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
                                                      Optional (List Text)
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
                                              , values : Optional (List Text)
                                              }
                                          )
                                    , matchLabels :
                                        Optional
                                          ( List
                                              { mapKey : Text, mapValue : Text }
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
                                                      Optional (List Text)
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
                                              , values : Optional (List Text)
                                              }
                                          )
                                    , matchLabels :
                                        Optional
                                          ( List
                                              { mapKey : Text, mapValue : Text }
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
                            { name : Optional Text, optional : Optional Bool }
                      , prefix : Optional Text
                      , secretRef :
                          Optional
                            { name : Optional Text, optional : Optional Bool }
                      }
                  )
            , image = Some
                "index.docker.io/sourcegraph/prometheus:3.17.2@sha256:a725419a532fb17f6955e80f8a2f35efe15287c0a556e4fe7168d5fc6ff730d8"
            , imagePullPolicy = None Text
            , lifecycle =
                None
                  { postStart :
                      Optional
                        { exec : Optional { command : Optional (List Text) }
                        , httpGet :
                            Optional
                              { host : Optional Text
                              , httpHeaders :
                                  Optional (List { name : Text, value : Text })
                              , path : Optional Text
                              , port : < Int : Natural | String : Text >
                              , scheme : Optional Text
                              }
                        , tcpSocket :
                            Optional
                              { host : Optional Text
                              , port : < Int : Natural | String : Text >
                              }
                        }
                  , preStop :
                      Optional
                        { exec : Optional { command : Optional (List Text) }
                        , httpGet :
                            Optional
                              { host : Optional Text
                              , httpHeaders :
                                  Optional (List { name : Text, value : Text })
                              , path : Optional Text
                              , port : < Int : Natural | String : Text >
                              , scheme : Optional Text
                              }
                        , tcpSocket :
                            Optional
                              { host : Optional Text
                              , port : < Int : Natural | String : Text >
                              }
                        }
                  }
            , livenessProbe = Some
              { exec = None { command : Optional (List Text) }
              , failureThreshold = None Natural
              , httpGet = Some
                { host = None Text
                , httpHeaders = None (List { name : Text, value : Text })
                , path = Some "/-/healthy"
                , port = < Int : Natural | String : Text >.Int 9090
                , scheme = None Text
                }
              , initialDelaySeconds = Some 30
              , periodSeconds = None Natural
              , successThreshold = None Natural
              , tcpSocket =
                  None
                    { host : Optional Text
                    , port : < Int : Natural | String : Text >
                    }
              , timeoutSeconds = Some 30
              }
            , name = "prometheus"
            , ports = Some
              [ { containerPort = 9090
                , hostIP = None Text
                , hostPort = None Natural
                , name = Some "http"
                , protocol = None Text
                }
              ]
            , readinessProbe = Some
              { exec = None { command : Optional (List Text) }
              , failureThreshold = None Natural
              , httpGet = Some
                { host = None Text
                , httpHeaders = None (List { name : Text, value : Text })
                , path = Some "/-/ready"
                , port = < Int : Natural | String : Text >.Int 9090
                , scheme = None Text
                }
              , initialDelaySeconds = Some 30
              , periodSeconds = None Natural
              , successThreshold = None Natural
              , tcpSocket =
                  None
                    { host : Optional Text
                    , port : < Int : Natural | String : Text >
                    }
              , timeoutSeconds = Some 30
              }
            , resources = Some
              { limits = Some
                [ { mapKey = "cpu", mapValue = "2" }
                , { mapKey = "memory", mapValue = "3G" }
                ]
              , requests = Some
                [ { mapKey = "cpu", mapValue = "500m" }
                , { mapKey = "memory", mapValue = "3G" }
                ]
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
                  { exec : Optional { command : Optional (List Text) }
                  , failureThreshold : Optional Natural
                  , httpGet :
                      Optional
                        { host : Optional Text
                        , httpHeaders :
                            Optional (List { name : Text, value : Text })
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
            , terminationMessagePolicy = Some "FallbackToLogsOnError"
            , tty = None Bool
            , volumeDevices = None (List { devicePath : Text, name : Text })
            , volumeMounts = Some
              [ { mountPath = "/prometheus"
                , mountPropagation = None Text
                , name = "data"
                , readOnly = None Bool
                , subPath = None Text
                , subPathExpr = None Text
                }
              , { mountPath = "/sg_prometheus_add_ons"
                , mountPropagation = None Text
                , name = "config"
                , readOnly = None Bool
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
                    (List { name : Optional Text, value : Optional Text })
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
                                  Optional { command : Optional (List Text) }
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
                              , tcpSocket :
                                  Optional
                                    { host : Optional Text
                                    , port : < Int : Natural | String : Text >
                                    }
                              }
                        , preStop :
                            Optional
                              { exec :
                                  Optional { command : Optional (List Text) }
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
                              , tcpSocket :
                                  Optional
                                    { host : Optional Text
                                    , port : < Int : Natural | String : Text >
                                    }
                              }
                        }
                  , livenessProbe :
                      Optional
                        { exec : Optional { command : Optional (List Text) }
                        , failureThreshold : Optional Natural
                        , httpGet :
                            Optional
                              { host : Optional Text
                              , httpHeaders :
                                  Optional (List { name : Text, value : Text })
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
                        { exec : Optional { command : Optional (List Text) }
                        , failureThreshold : Optional Natural
                        , httpGet :
                            Optional
                              { host : Optional Text
                              , httpHeaders :
                                  Optional (List { name : Text, value : Text })
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
                  , resources :
                      Optional
                        { limits :
                            Optional (List { mapKey : Text, mapValue : Text })
                        , requests :
                            Optional (List { mapKey : Text, mapValue : Text })
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
                              , gmsaCredentialSpecName : Optional Text
                              , runAsUserName : Optional Text
                              }
                        }
                  , startupProbe :
                      Optional
                        { exec : Optional { command : Optional (List Text) }
                        , failureThreshold : Optional Natural
                        , httpGet :
                            Optional
                              { host : Optional Text
                              , httpHeaders :
                                  Optional (List { name : Text, value : Text })
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
                  , stdin : Optional Bool
                  , stdinOnce : Optional Bool
                  , targetContainerName : Optional Text
                  , terminationMessagePath : Optional Text
                  , terminationMessagePolicy : Optional Text
                  , tty : Optional Bool
                  , volumeDevices :
                      Optional (List { devicePath : Text, name : Text })
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
            None (List { hostnames : Optional (List Text), ip : Optional Text })
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
                                  Optional { command : Optional (List Text) }
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
                              , tcpSocket :
                                  Optional
                                    { host : Optional Text
                                    , port : < Int : Natural | String : Text >
                                    }
                              }
                        , preStop :
                            Optional
                              { exec :
                                  Optional { command : Optional (List Text) }
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
                              , tcpSocket :
                                  Optional
                                    { host : Optional Text
                                    , port : < Int : Natural | String : Text >
                                    }
                              }
                        }
                  , livenessProbe :
                      Optional
                        { exec : Optional { command : Optional (List Text) }
                        , failureThreshold : Optional Natural
                        , httpGet :
                            Optional
                              { host : Optional Text
                              , httpHeaders :
                                  Optional (List { name : Text, value : Text })
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
                        { exec : Optional { command : Optional (List Text) }
                        , failureThreshold : Optional Natural
                        , httpGet :
                            Optional
                              { host : Optional Text
                              , httpHeaders :
                                  Optional (List { name : Text, value : Text })
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
                  , resources :
                      Optional
                        { limits :
                            Optional (List { mapKey : Text, mapValue : Text })
                        , requests :
                            Optional (List { mapKey : Text, mapValue : Text })
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
                              , gmsaCredentialSpecName : Optional Text
                              , runAsUserName : Optional Text
                              }
                        }
                  , startupProbe :
                      Optional
                        { exec : Optional { command : Optional (List Text) }
                        , failureThreshold : Optional Natural
                        , httpGet :
                            Optional
                              { host : Optional Text
                              , httpHeaders :
                                  Optional (List { name : Text, value : Text })
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
                  , stdin : Optional Bool
                  , stdinOnce : Optional Bool
                  , terminationMessagePath : Optional Text
                  , terminationMessagePolicy : Optional Text
                  , tty : Optional Bool
                  , volumeDevices :
                      Optional (List { devicePath : Text, name : Text })
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
        , nodeSelector = None (List { mapKey : Text, mapValue : Text })
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
        , serviceAccountName = Some "prometheus"
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
                            Optional (List { mapKey : Text, mapValue : Text })
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
                            { key : Text, mode : Optional Natural, path : Text }
                        )
                  , name : Optional Text
                  , optional : Optional Bool
                  }
            , csi =
                None
                  { driver : Text
                  , fsType : Optional Text
                  , nodePublishSecretRef : Optional { name : Optional Text }
                  , readOnly : Optional Bool
                  , volumeAttributes :
                      Optional (List { mapKey : Text, mapValue : Text })
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
                None { medium : Optional Text, sizeLimit : Optional Text }
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
                  , options : Optional (List { mapKey : Text, mapValue : Text })
                  , readOnly : Optional Bool
                  , secretRef : Optional { name : Optional Text }
                  }
            , flocker =
                None
                  { datasetName : Optional Text, datasetUUID : Optional Text }
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
                None { endpoints : Text, path : Text, readOnly : Optional Bool }
            , hostPath = None { path : Text, type : Optional Text }
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
            , name = "data"
            , nfs =
                None { path : Text, readOnly : Optional Bool, server : Text }
            , persistentVolumeClaim = Some
              { claimName = "prometheus", readOnly = None Bool }
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
                            { key : Text, mode : Optional Natural, path : Text }
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
            , configMap = Some
              { defaultMode = Some 777
              , items =
                  None
                    (List { key : Text, mode : Optional Natural, path : Text })
              , name = Some "prometheus"
              , optional = None Bool
              }
            , csi =
                None
                  { driver : Text
                  , fsType : Optional Text
                  , nodePublishSecretRef : Optional { name : Optional Text }
                  , readOnly : Optional Bool
                  , volumeAttributes :
                      Optional (List { mapKey : Text, mapValue : Text })
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
                None { medium : Optional Text, sizeLimit : Optional Text }
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
                  , options : Optional (List { mapKey : Text, mapValue : Text })
                  , readOnly : Optional Bool
                  , secretRef : Optional { name : Optional Text }
                  }
            , flocker =
                None
                  { datasetName : Optional Text, datasetUUID : Optional Text }
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
                None { endpoints : Text, path : Text, readOnly : Optional Bool }
            , hostPath = None { path : Text, type : Optional Text }
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
            , name = "config"
            , nfs =
                None { path : Text, readOnly : Optional Bool, server : Text }
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
                            { key : Text, mode : Optional Natural, path : Text }
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
, PersistentVolumeClaim =
  { apiVersion = "v1"
  , kind = "PersistentVolumeClaim"
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
      [ { mapKey = "deploy", mapValue = "sourcegraph" }
      , { mapKey = "sourcegraph-resource-requires"
        , mapValue = "no-cluster-admin"
        }
      ]
    , managedFields =
        None
          ( List
              { apiVersion : Text
              , fieldsType : Optional Text
              , fieldsV1 : Optional (List { mapKey : Text, mapValue : Text })
              , manager : Optional Text
              , operation : Optional Text
              , time : Optional Text
              }
          )
    , name = Some "prometheus"
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
    { accessModes = Some [ "ReadWriteOnce" ]
    , dataSource = None { apiGroup : Optional Text, kind : Text, name : Text }
    , resources = Some
      { limits = None (List { mapKey : Text, mapValue : Text })
      , requests = Some [ { mapKey = "storage", mapValue = "200Gi" } ]
      }
    , selector =
        None
          { matchExpressions :
              Optional
                ( List
                    { key : Text
                    , operator : Text
                    , values : Optional (List Text)
                    }
                )
          , matchLabels : Optional (List { mapKey : Text, mapValue : Text })
          }
    , storageClassName = Some "sourcegraph"
    , volumeMode = None Text
    , volumeName = None Text
    }
  , status =
      None
        { accessModes : Optional (List Text)
        , capacity : Optional (List { mapKey : Text, mapValue : Text })
        , conditions :
            Optional
              ( List
                  { lastProbeTime : Optional Text
                  , lastTransitionTime : Optional Text
                  , message : Optional Text
                  , reason : Optional Text
                  , status : Text
                  , type : Text
                  }
              )
        , phase : Optional Text
        }
  }
, Service =
  { apiVersion = "v1"
  , kind = "Service"
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
      [ { mapKey = "app", mapValue = "prometheus" }
      , { mapKey = "deploy", mapValue = "sourcegraph" }
      , { mapKey = "sourcegraph-resource-requires"
        , mapValue = "no-cluster-admin"
        }
      ]
    , managedFields =
        None
          ( List
              { apiVersion : Text
              , fieldsType : Optional Text
              , fieldsV1 : Optional (List { mapKey : Text, mapValue : Text })
              , manager : Optional Text
              , operation : Optional Text
              , time : Optional Text
              }
          )
    , name = Some "prometheus"
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
        , port = 30090
        , protocol = None Text
        , targetPort = Some (< Int : Natural | String : Text >.String "http")
        }
      ]
    , publishNotReadyAddresses = None Bool
    , selector = Some [ { mapKey = "app", mapValue = "prometheus" } ]
    , sessionAffinity = None Text
    , sessionAffinityConfig =
        None { clientIP : Optional { timeoutSeconds : Optional Natural } }
    , topologyKeys = None (List Text)
    , type = Some "ClusterIP"
    }
  , status =
      None
        { loadBalancer :
            Optional
              { ingress :
                  Optional
                    (List { hostname : Optional Text, ip : Optional Text })
              }
        }
  }
, ServiceAccount =
  { apiVersion = "v1"
  , automountServiceAccountToken = None Bool
  , imagePullSecrets = Some [ { name = Some "docker-registry" } ]
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
      [ { mapKey = "category", mapValue = "rbac" }
      , { mapKey = "deploy", mapValue = "sourcegraph" }
      , { mapKey = "sourcegraph-resource-requires"
        , mapValue = "no-cluster-admin"
        }
      ]
    , managedFields =
        None
          ( List
              { apiVersion : Text
              , fieldsType : Optional Text
              , fieldsV1 : Optional (List { mapKey : Text, mapValue : Text })
              , manager : Optional Text
              , operation : Optional Text
              , time : Optional Text
              }
          )
    , name = Some "prometheus"
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
}
