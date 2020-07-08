let schemas = ../../deps/k8s/schemas.dhall

in  { ClusterRole = schemas.ClusterRole::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "category", mapValue = "rbac" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "cluster-admin"
            }
          ]
        , name = Some "prometheus"
        }
      , rules = Some
        [ schemas.PolicyRule::{
          , apiGroups = Some [ "" ]
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
        , schemas.PolicyRule::{
          , apiGroups = Some [ "" ]
          , resources = Some [ "configmaps" ]
          , verbs = [ "get" ]
          }
        , schemas.PolicyRule::{
          , nonResourceURLs = Some [ "/metrics" ]
          , verbs = [ "get" ]
          }
        ]
      }
    , ClusterRoleBinding = schemas.ClusterRoleBinding::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "category", mapValue = "rbac" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "cluster-admin"
            }
          ]
        , name = Some "prometheus"
        }
      , roleRef = schemas.RoleRef::{
        , apiGroup = ""
        , kind = "ClusterRole"
        , name = "prometheus"
        }
      , subjects = Some
        [ schemas.Subject::{
          , kind = "ServiceAccount"
          , name = "prometheus"
          , namespace = Some "default"
          }
        ]
      }
    , ConfigMap = schemas.ConfigMap::{
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
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "prometheus"
        }
      }
    , Deployment = schemas.Deployment::{
      , metadata = schemas.ObjectMeta::{
        , annotations = Some
          [ { mapKey = "description"
            , mapValue = "Collects metrics and aggregates them into graphs."
            }
          ]
        , labels = Some
          [ { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "prometheus"
        }
      , spec = Some schemas.DeploymentSpec::{
        , minReadySeconds = Some 10
        , replicas = Some 1
        , revisionHistoryLimit = Some 10
        , selector = schemas.LabelSelector::{
          , matchLabels = Some [ { mapKey = "app", mapValue = "prometheus" } ]
          }
        , strategy = Some schemas.DeploymentStrategy::{ type = Some "Recreate" }
        , template = schemas.PodTemplateSpec::{
          , metadata = schemas.ObjectMeta::{
            , labels = Some
              [ { mapKey = "app", mapValue = "prometheus" }
              , { mapKey = "deploy", mapValue = "sourcegraph" }
              ]
            }
          , spec = Some schemas.PodSpec::{
            , containers =
              [ schemas.Container::{
                , image = Some
                    "index.docker.io/sourcegraph/prometheus:3.17.2@sha256:a725419a532fb17f6955e80f8a2f35efe15287c0a556e4fe7168d5fc6ff730d8"
                , livenessProbe = Some schemas.Probe::{
                  , httpGet = Some schemas.HTTPGetAction::{
                    , path = Some "/-/healthy"
                    , port = < Int : Natural | String : Text >.Int 9090
                    }
                  , initialDelaySeconds = Some 30
                  , timeoutSeconds = Some 30
                  }
                , name = "prometheus"
                , ports = Some
                  [ schemas.ContainerPort::{
                    , containerPort = 9090
                    , name = Some "http"
                    }
                  ]
                , readinessProbe = Some schemas.Probe::{
                  , httpGet = Some schemas.HTTPGetAction::{
                    , path = Some "/-/ready"
                    , port = < Int : Natural | String : Text >.Int 9090
                    }
                  , initialDelaySeconds = Some 30
                  , timeoutSeconds = Some 30
                  }
                , resources = Some schemas.ResourceRequirements::{
                  , limits = Some
                    [ { mapKey = "cpu", mapValue = "2" }
                    , { mapKey = "memory", mapValue = "3G" }
                    ]
                  , requests = Some
                    [ { mapKey = "cpu", mapValue = "500m" }
                    , { mapKey = "memory", mapValue = "3G" }
                    ]
                  }
                , terminationMessagePolicy = Some "FallbackToLogsOnError"
                , volumeMounts = Some
                  [ schemas.VolumeMount::{
                    , mountPath = "/prometheus"
                    , name = "data"
                    }
                  , schemas.VolumeMount::{
                    , mountPath = "/sg_prometheus_add_ons"
                    , name = "config"
                    }
                  ]
                }
              ]
            , securityContext = Some schemas.PodSecurityContext::{
              , runAsUser = Some 0
              }
            , serviceAccountName = Some "prometheus"
            , volumes = Some
              [ schemas.Volume::{
                , name = "data"
                , persistentVolumeClaim = Some schemas.PersistentVolumeClaimVolumeSource::{
                  , claimName = "prometheus"
                  }
                }
              , schemas.Volume::{
                , configMap = Some schemas.ConfigMapVolumeSource::{
                  , defaultMode = Some 777
                  , name = Some "prometheus"
                  }
                , name = "config"
                }
              ]
            }
          }
        }
      }
    , PersistentVolumeClaim = schemas.PersistentVolumeClaim::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "prometheus"
        }
      , spec = Some schemas.PersistentVolumeClaimSpec::{
        , accessModes = Some [ "ReadWriteOnce" ]
        , resources = Some schemas.ResourceRequirements::{
          , requests = Some [ { mapKey = "storage", mapValue = "200Gi" } ]
          }
        , storageClassName = Some "sourcegraph"
        }
      }
    , Service = schemas.Service::{
      , metadata = schemas.ObjectMeta::{
        , labels = Some
          [ { mapKey = "app", mapValue = "prometheus" }
          , { mapKey = "deploy", mapValue = "sourcegraph" }
          , { mapKey = "sourcegraph-resource-requires"
            , mapValue = "no-cluster-admin"
            }
          ]
        , name = Some "prometheus"
        }
      , spec = Some schemas.ServiceSpec::{
        , ports = Some
          [ schemas.ServicePort::{
            , name = Some "http"
            , port = 30090
            , targetPort = Some
                (< Int : Natural | String : Text >.String "http")
            }
          ]
        , selector = Some [ { mapKey = "app", mapValue = "prometheus" } ]
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
        , name = Some "prometheus"
        }
      }
    }
