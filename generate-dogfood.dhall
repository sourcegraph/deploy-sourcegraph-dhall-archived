let Kubernetes/EnvVar = ./src/deps/k8s/schemas/io.k8s.api.core.v1.EnvVar.dhall

let Generate = ./src/base/generate.dhall

let Configuration/global = ./src/configuration/global.dhall

let c =
      Configuration/global::{=}
      with Frontend.Deployment.Containers.SourcegraphFrontend.image = Some
          "index.docker.io/sourcegraph/frontend:insiders@sha256:5819cf7e6fb01ad0775a32d4e3c4c40a3f1f5793cf907fa74d7c530d91de8d7f"
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
        [ Kubernetes/EnvVar::{
          , name = "SENTRY_DSN_BACKEND"
          , value = Some
              "https://cb3bfeb73fb141cf9ed71d06ae1f02b8@sentry.io/1249389"
          }
        , Kubernetes/EnvVar::{
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
        [ { hosts = Some [ "k8s.sgdev.org" ]
          , secretName = Some "sourcegraph-tls"
          }
        ]
      with GithubProxy.Deployment.Containers.GithubProxy.image = Some
          "index.docker.io/sourcegraph/github-proxy:insiders@sha256:9bc0fab1ef7cddd6a09d45d47fe81314be60a7a42ca5b48b4fd3c33b45527dda"
      with GithubProxy.Deployment.Containers.GithubProxy.resources.limits.ephemeralStorage = Some
          "1Gi"
      with GithubProxy.Deployment.Containers.GithubProxy.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Gitserver.StatefulSet.replicas = Some 4
      with Gitserver.StatefulSet.Containers.Gitserver.image = Some
          "index.docker.io/sourcegraph/gitserver:insiders@sha256:337685e6b581e0c3f86a824b3d767a2e5d8416427630601be54fae1e5c8f656a"
      with Gitserver.StatefulSet.persistentVolumeSize = Some "4Ti"
      with Gitserver.StatefulSet.sshSecretName = Some "gitserver-ssh"
      with Gitserver.StatefulSet.Containers.Gitserver.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Gitserver.StatefulSet.Containers.Gitserver.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Grafana.StatefulSet.Containers.Grafana.image = Some
          "index.docker.io/sourcegraph/grafana:insiders@sha256:3a9f472109f9ab1ab992574e5e55b067a34537a38a0872db093cd877823ac42e"
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
        [ Kubernetes/EnvVar::{
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
          "index.docker.io/sourcegraph/indexed-searcher:insiders@sha256:6b304abe2d84b31357051ae78fd3e1facd57fed9a9fd84e2cce6a96b84de93e1"
      with IndexedSearch.StatefulSet.Containers.ZoektIndexServer.image = Some
          "index.docker.io/sourcegraph/search-indexer:insiders@sha256:0b129a124674b821651d26b40edd1f861a75a2ed65e3e9af9c108d721348a666"
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
          "index.docker.io/sourcegraph/prometheus:insiders@sha256:8906de7028ec7ecfcfecb63335dc47fe70dbf50d8741699eaaa17ea2ddfa857e"
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
          "index.docker.io/sourcegraph/query-runner:insiders@sha256:0732ac488f67afa6bdb3333d3b39fcbeffdcce300d83a52052f89cddca7cf264"
      with QueryRunner.Deployment.Containers.QueryRunner.resources.limits.ephemeralStorage = Some
          "1Gi"
      with QueryRunner.Deployment.Containers.QueryRunner.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Replacer.Deployment.Containers.Replacer.image = Some
          "index.docker.io/sourcegraph/replacer:insiders@sha256:1eb8c6daa5d2b5bc3db1f7aed41297346b271332dea481db532c61803d67fcdf"
      with Replacer.Deployment.Containers.Replacer.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Replacer.Deployment.Containers.Replacer.resources.requests.ephemeralStorage = Some
          "1Gi"
      with RepoUpdater.Deployment.Containers.RepoUpdater.image = Some
          "index.docker.io/sourcegraph/repo-updater:insiders@sha256:13184df2e431fc7678ca59de9128301562a897acd241268c6d8ac069c14d5d09"
      with RepoUpdater.Deployment.Containers.RepoUpdater.resources.limits.ephemeralStorage = Some
          "1Gi"
      with RepoUpdater.Deployment.Containers.RepoUpdater.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Searcher.Deployment.Containers.Searcher.image = Some
          "index.docker.io/sourcegraph/searcher:insiders@sha256:3c7690062c79949cd0a4af1cfdfd22a177d11d22684057b17a2502d97596da49"
      with Searcher.Deployment.Containers.Searcher.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Searcher.Deployment.Containers.Searcher.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Symbols.Deployment.Containers.Symbols.image = Some
          "index.docker.io/sourcegraph/symbols:insiders@sha256:30ea02d6106d1deb8fdcda719a500e666b0ba7921897ffafb5cbd4f7be3ecd52"
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
          "index.docker.io/sourcegraph/precise-code-intel-bundle-manager:insiders@sha256:abbd9418d424955e6e5236efd5b8b551128f2bcd25490a2ffe911bbc4bc87598"
      with PreciseCodeIntel.BundleManager.Deployment.Containers.BundleManager.resources.limits.ephemeralStorage = Some
          "1Gi"
      with PreciseCodeIntel.BundleManager.Deployment.Containers.BundleManager.resources.requests.ephemeralStorage = Some
          "1Gi"
      with PreciseCodeIntel.Worker.Deployment.Containers.Worker.image = Some
          "index.docker.io/sourcegraph/precise-code-intel-worker:insiders@sha256:579a3d5df83c0c771e9f8b18ce6344bfbe3b636d6f1d101b3cec8ac3b266d2a2"
      with PreciseCodeIntel.Worker.Deployment.Containers.Worker.resources.limits.ephemeralStorage = Some
          "1Gi"
      with PreciseCodeIntel.Worker.Deployment.Containers.Worker.resources.requests.ephemeralStorage = Some
          "1Gi"

in  Generate c
