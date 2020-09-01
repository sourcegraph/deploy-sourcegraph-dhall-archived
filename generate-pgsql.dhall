let Kubernetes/EnvVar = ./src/deps/k8s/schemas/io.k8s.api.core.v1.EnvVar.dhall

let Generate = ./src/base/generate.dhall

let Configuration/global = ./src/configuration/global.dhall

let c =
      Configuration/global::{=}
      with Frontend.Deployment.Containers.SourcegraphFrontend.pgsqlEnvironmentVariables = Some
          [ Kubernetes/EnvVar::{
            , name = "PGHOST"
            , value = Some
                "pghost.test"
          }
        ]
in  Generate c
