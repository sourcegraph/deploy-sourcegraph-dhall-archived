let Generate = ./src/base/generate.dhall

let Configuration/global = ./src/configuration/global.dhall

let c =
      Configuration/global::{=}
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

in  Generate c
