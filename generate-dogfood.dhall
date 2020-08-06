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

in  Generate c
