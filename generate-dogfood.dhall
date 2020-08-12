let Sourcegraph =
      https://raw.githubusercontent.com/sourcegraph/deploy-sourcegraph-dhall/d95e9674ebefc6b82b651c8f44fac63ab60f1030/package.dhall sha256:2d68414383b4b368c5be77b533ece77e36b189bf28c41c8c3eec25253607aad4

let Generate = ./src/base/generate.dhall

let c =
      Sourcegraph.Configuration.Global::{=}
      with Frontend.Deployment.Containers.SourcegraphFrontend.image = Some
          "index.docker.io/sourcegraph/frontend:insiders@sha256:a211568c55c867f78c7ef2070017df1633d2d462dec24cf705f0635cadb9a25a"
      with Frontend.Deployment.Containers.SourcegraphFrontend.resources.limits.cpu = Some
          "8000m"
      with Frontend.Deployment.Containers.SourcegraphFrontend.resources.limits.memory = Some
          "6G"
      with Frontend.Deployment.Containers.SourcegraphFrontend.resources.requests.cpu = Some
          "6000m"
      with Frontend.Deployment.Containers.SourcegraphFrontend.resources.requests.memory = Some
          "4G"
      with Frontend.Deployment.Containers.SourcegraphFrontend.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Frontend.Deployment.Containers.SourcegraphFrontend.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Frontend.Deployment.Containers.SourcegraphFrontend.additionalEnvironmentVariables = Some
        [ Sourcegraph.Configuration.EnvVar::{
          , name = "SENTRY_DSN_BACKEND"
          , value = Some
              "https://cb3bfeb73fb141cf9ed71d06ae1f02b8@sentry.io/1249389"
          }
        , Sourcegraph.Configuration.EnvVar::{
          , name = "SENTRY_DSN_FRONTEND"
          , value = Some
              "https://cb3bfeb73fb141cf9ed71d06ae1f02b8@sentry.io/1249389"
          }
        ]
      with Frontend.Ingress.additionalAnnotations = Some
        [ { mapKey = "certmanager.k8s.io/issuer"
          , mapValue = "letsencrypt-prod"
          }
        , { mapKey = "nginx.ingress.kubernetes.io/proxy-read-timeout"
          , mapValue = "1d"
          }
        , { mapKey = "certmanager.k8s.io/acme-challenge-type"
          , mapValue = "http01"
          }
        ]
      with Frontend.Ingress.tls = Some
        [ { hosts = Some [ "catfood.sgdev.org" ]
          , secretName = Some "sourcegraph-tls"
          }
        ]
      with GithubProxy.Deployment.Containers.GithubProxy.image = Some
          "index.docker.io/sourcegraph/github-proxy:insiders@sha256:5df85aaa1fb332322c4eaf6b6f6fd0bd7ff505dbec0b8b8254c0b30ed2f5d930"
      with GithubProxy.Deployment.Containers.GithubProxy.resources.limits.ephemeralStorage = Some
          "1Gi"
      with GithubProxy.Deployment.Containers.GithubProxy.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Gitserver.StatefulSet.replicas = Some 4
      with Gitserver.StatefulSet.Containers.Gitserver.image = Some
          "index.docker.io/sourcegraph/gitserver:insiders@sha256:4861c686442c66ec5310bb4cac2f88c878c91dbd9f06e42409ddf627d58ca07e"
      with Gitserver.StatefulSet.persistentVolumeSize = Some "4Ti"
      with Gitserver.StatefulSet.sshSecretName = Some "gitserver-ssh"
      with Gitserver.StatefulSet.Containers.Gitserver.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Gitserver.StatefulSet.Containers.Gitserver.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Grafana.StatefulSet.Containers.Grafana.image = Some
          "index.docker.io/sourcegraph/grafana:insiders@sha256:68231a60ffcbfb104573ab5319fb8214b7d59292da39b9e5ad2a6c60a9c0e81b"
      with Grafana.StatefulSet.Containers.Grafana.resources.limits.cpu = Some
          "100m"
      with Grafana.StatefulSet.Containers.Grafana.resources.limits.memory = Some
          "100Mi"
      with Grafana.StatefulSet.Containers.Grafana.resources.requests.memory = Some
          "100Mi"
      with Grafana.StatefulSet.Containers.Grafana.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Grafana.StatefulSet.Containers.Grafana.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Grafana.StatefulSet.Containers.Grafana.additionalEnvironmentVariables = Some
        [ Sourcegraph.Configuration.EnvVar::{
          , name = "GF_SERVER_ROOT_URL"
          , value = Some "https://k8s.sgdev.org/-/debug/grafana"
          }
        ]
      with Postgres.Deployment.Containers.Postgres.image = Some
          "index.docker.io/sourcegraph/postgres-11.4:insiders@sha256:63090799b34b3115a387d96fe2227a37999d432b774a1d9b7966b8c5d81b56ad"
      with Postgres.Deployment.Containers.Postgres.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Postgres.Deployment.Containers.Postgres.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Postgres.Deployment.Containers.Postgres.resources.limits.cpu = Some
          "16"
      with Postgres.Deployment.Containers.Postgres.resources.limits.memory = Some
          "24Gi"
      with Postgres.Deployment.Containers.Postgres.resources.requests.cpu = Some
          "16"
      with Postgres.Deployment.Containers.Postgres.resources.requests.memory = Some
          "24Gi"
      with IndexedSearch.StatefulSet.Containers.ZoektWebServer.image = Some
          "index.docker.io/sourcegraph/indexed-searcher:insiders@sha256:b5547e441474c08ee35e0911d44ac7dd05928f45816999da6b4993e31725a141"
      with IndexedSearch.StatefulSet.Containers.ZoektIndexServer.image = Some
          "index.docker.io/sourcegraph/search-indexer:insiders@sha256:8eeb86684d66349c34185b6cacd54812048856e6a73b917a05912028fe04ed1d"
      with IndexedSearch.StatefulSet.Containers.ZoektWebServer.resources.limits.cpu = Some
          "12"
      with IndexedSearch.StatefulSet.Containers.ZoektWebServer.resources.limits.memory = Some
          "120Gi"
      with IndexedSearch.StatefulSet.Containers.ZoektWebServer.resources.requests.cpu = Some
          "12"
      with IndexedSearch.StatefulSet.Containers.ZoektWebServer.resources.requests.memory = Some
          "120Gi"
      with IndexedSearch.StatefulSet.replicas = Some 2
      with IndexedSearch.StatefulSet.persistentVolumeSize = Some "4Ti"
      with IndexedSearch.StatefulSet.Containers.ZoektWebServer.resources.limits.ephemeralStorage = Some
          "1Gi"
      with IndexedSearch.StatefulSet.Containers.ZoektWebServer.resources.requests.ephemeralStorage = Some
          "1Gi"
      with IndexedSearch.StatefulSet.Containers.ZoektIndexServer.resources.limits.ephemeralStorage = Some
          "1Gi"
      with IndexedSearch.StatefulSet.Containers.ZoektIndexServer.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Jaeger.Deployment.Containers.JaegerAllInOne.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Jaeger.Deployment.Containers.JaegerAllInOne.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Prometheus.Deployment.Containers.Prometheus.resources.limits.memory = Some
          "3G"
      with Prometheus.Deployment.Containers.Prometheus.resources.requests.memory = Some
          "500M"
      with Prometheus.Deployment.Containers.Prometheus.image = Some
          "index.docker.io/sourcegraph/prometheus:insiders@sha256:96a07db09f71f4c110eceea813af48555bfc6efc68900231780816b868232292"
      with Prometheus.Deployment.Containers.Prometheus.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Prometheus.Deployment.Containers.Prometheus.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Prometheus.Deployment.Containers.Blackbox.resources.limits.memory = Some
          "1G"
      with Prometheus.Deployment.Containers.Blackbox.resources.requests.memory = Some
          "500M"
      with Prometheus.Deployment.Containers.Blackbox.resources.limits.cpu = Some
          "1G"
      with Prometheus.Deployment.Containers.Blackbox.resources.requests.cpu = Some
          "500m"
      with QueryRunner.Deployment.Containers.QueryRunner.image = Some
          "index.docker.io/sourcegraph/query-runner:insiders@sha256:e78be29ed758931b60e0e842c949cfe3c9c0f56093e2021928bb258c355f36ee"
      with QueryRunner.Deployment.Containers.QueryRunner.resources.limits.ephemeralStorage = Some
          "1Gi"
      with QueryRunner.Deployment.Containers.QueryRunner.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Replacer.Deployment.Containers.Replacer.image = Some
          "index.docker.io/sourcegraph/replacer:insiders@sha256:1b1af9ac5ce358009b99b9d5f69c248546e386ab456d61f6cd39d2310a749b09"
      with Replacer.Deployment.Containers.Replacer.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Replacer.Deployment.Containers.Replacer.resources.requests.ephemeralStorage = Some
          "1Gi"
      with RepoUpdater.Deployment.Containers.RepoUpdater.image = Some
          "index.docker.io/sourcegraph/repo-updater:insiders@sha256:98ff67fe531efa0794ecbba43d403a2f3df1c60ad65c48d16b02a69e8d01cda7"
      with RepoUpdater.Deployment.Containers.RepoUpdater.resources.limits.ephemeralStorage = Some
          "1Gi"
      with RepoUpdater.Deployment.Containers.RepoUpdater.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Searcher.Deployment.Containers.Searcher.image = Some
          "index.docker.io/sourcegraph/searcher:insiders@sha256:5d4de45c03acb56f22b6f61d922060987b1f5aa5b22e43c9c2ff49a1b3f251c0"
      with Searcher.Deployment.Containers.Searcher.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Searcher.Deployment.Containers.Searcher.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Symbols.Deployment.Containers.Symbols.image = Some
          "index.docker.io/sourcegraph/symbols:insiders@sha256:ea6fd7b5f5b33c563b69f7f014c89caef3e92fb038626b349ab77c7e362d5c82"
      with Symbols.Deployment.Containers.Symbols.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Symbols.Deployment.Containers.Symbols.resources.requests.ephemeralStorage = Some
          "1Gi"
      with SyntaxHighlighter.Deployment.Containers.SyntaxHighlighter.image = Some
          "index.docker.io/sourcegraph/syntax-highlighter:insiders@sha256:aa93514b7bc3aaf7a4e9c92e5ff52ee5052db6fb101255a69f054e5b8cdb46ff"
      with SyntaxHighlighter.Deployment.Containers.SyntaxHighlighter.resources.limits.ephemeralStorage = Some
          "1Gi"
      with SyntaxHighlighter.Deployment.Containers.SyntaxHighlighter.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Cadvisor.DaemonSet.Containers.Cadvisor.image = Some
          "us.gcr.io/sourcegraph-dev/cadvisor:0dc33691105dff7ddacb143e63a4a565ba25803d_69148_candidate"
      with Cadvisor.DaemonSet.Containers.Cadvisor.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Cadvisor.DaemonSet.Containers.Cadvisor.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Redis.Store.Deployment.Containers.Store.image = Some
          "index.docker.io/sourcegraph/redis-store:insiders@sha256:e8467a8279832207559bdfbc4a89b68916ecd5b44ab5cf7620c995461c005168"
      with Redis.Store.Deployment.Containers.Store.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Redis.Store.Deployment.Containers.Store.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Redis.Cache.Deployment.Containers.Cache.image = Some
          "index.docker.io/sourcegraph/redis-cache:insiders@sha256:7820219195ab3e8fdae5875cd690fed1b2a01fd1063bd94210c0e9d529c38e56"
      with Redis.Cache.Deployment.Containers.Cache.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Redis.Cache.Deployment.Containers.Cache.resources.requests.ephemeralStorage = Some
          "1Gi"
      with PreciseCodeIntel.BundleManager.Deployment.Containers.BundleManager.image = Some
          "index.docker.io/sourcegraph/precise-code-intel-bundle-manager:insiders@sha256:5fedf4f0158d56a7cab98fb9a232f17b43e4d4890df5674177b0e358b5ff8a3d"
      with PreciseCodeIntel.BundleManager.Deployment.Containers.BundleManager.resources.limits.ephemeralStorage = Some
          "1Gi"
      with PreciseCodeIntel.BundleManager.Deployment.Containers.BundleManager.resources.requests.ephemeralStorage = Some
          "1Gi"
      with PreciseCodeIntel.Worker.Deployment.Containers.Worker.image = Some
          "index.docker.io/sourcegraph/precise-code-intel-worker:insiders@sha256:f9cda51f68388b0b809c647e954dbc2aa9643efc4beb8e2cb9cbc56b1b9c1675"
      with PreciseCodeIntel.Worker.Deployment.Containers.Worker.resources.limits.ephemeralStorage = Some
          "1Gi"
      with PreciseCodeIntel.Worker.Deployment.Containers.Worker.resources.requests.ephemeralStorage = Some
          "1Gi"
      with StorageClass.CloudProvider =
          Sourcegraph.Configuration.CloudProvider.GCP
      with IngressNginx.Enabled = True
      with IngressNginx.IPAddress = Some "34.66.96.138"

in  Generate c
