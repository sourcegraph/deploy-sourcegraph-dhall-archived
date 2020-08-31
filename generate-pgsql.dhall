let Kubernetes/EnvVar = ./src/deps/k8s/schemas/io.k8s.api.core.v1.EnvVar.dhall

let Generate = ./src/base/generate.dhall

let Configuration/global = ./src/configuration/global.dhall

let c =
      Configuration/global::{=}
      with Frontend.Deployment.Containers.SourcegraphFrontend.image = Some
          "index.docker.io/sourcegraph/frontend:insiders@sha256:5819cf7e6fb01ad0775a32d4e3c4c40a3f1f5793cf907fa74d7c530d91de8d7f"
      with Frontend.Deployment.Containers.SourcegraphFrontend.pgsqlEnvironmentVariables = Some
          [ Kubernetes/EnvVar::{
            , name = "PGHOST"
            , value = Some
                "pghost.test"
          }
        ]
in  Generate c
