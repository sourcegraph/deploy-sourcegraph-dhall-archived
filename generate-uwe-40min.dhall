let Generate = ./src/base/generate.dhall

let Configuration/global = ./src/configuration/global.dhall

let c =
      Configuration/global::{=}
      with GithubProxy.Deployment.Containers.GithubProxy.image = Some
          "index.docker.io/sourcegraph/github-proxy:insiders@sha256:9bc0fab1ef7cddd6a09d45d47fe81314be60a7a42ca5b48b4fd3c33b45527dda"
      with Prometheus.Deployment.Containers.Prometheus.resources.limits.memory = Some
          "2G"
      with Prometheus.Deployment.Containers.Prometheus.resources.requests.memory = Some
          "500M"
      with Prometheus.Deployment.Containers.Prometheus.image = Some
          "index.docker.io/sourcegraph/prometheus:insiders@sha256:8906de7028ec7ecfcfecb63335dc47fe70dbf50d8741699eaaa17ea2ddfa857e"
      with Prometheus.Deployment.Containers.Prometheus.resources.requests.ephemeralStorage = Some
          "1Gi"
      with Prometheus.Deployment.Containers.Prometheus.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Gitserver.StatefulSet.persistentVolumeSize = Some "4Ti"
      with Gitserver.StatefulSet.sshSecretName = Some "gitserver-ssh"
      with Grafana.StatefulSet.Containers.Grafana.image = Some
          "index.docker.io/sourcegraph/grafana:insiders@sha256:3a9f472109f9ab1ab992574e5e55b067a34537a38a0872db093cd877823ac42e"
      with Grafana.StatefulSet.Containers.Grafana.resources.limits.memory = Some
          "100Mi"
      with Grafana.StatefulSet.Containers.Grafana.resources.requests.memory = Some
          "100Mi"
      with Grafana.StatefulSet.Containers.Grafana.resources.limits.ephemeralStorage = Some
          "1Gi"
      with Grafana.StatefulSet.Containers.Grafana.resources.requests.ephemeralStorage = Some
          "1Gi"

in  Generate c
