let Generate = ./src/base/generate.dhall

let Configuration/global = ./src/configuration/global.dhall

let Configuration/Prometheus = ./src/base/prometheus/configuration.dhall

let Configuration/container = ./src/configuration/container.dhall

let containerResources = ./src/configuration/container-resources.dhall

let c =
      Configuration/global::{
      , Prometheus = Configuration/Prometheus::{
        , Deployment =
              Configuration/Prometheus.default.Deployment
            ⫽ { Containers.Prometheus = Configuration/container::{
                , resources =
                  { limits = containerResources.Configuration::{
                    , memory = Some "2G"
                    , ephemeralStorage = Some "1Gi"
                    }
                  , requests = containerResources.Configuration::{
                    , memory = Some "500M"
                    , ephemeralStorage = Some "1Gi"
                    }
                  }
                , image = Some
                    "index.docker.io/sourcegraph/prometheus:insiders@sha256:8906de7028ec7ecfcfecb63335dc47fe70dbf50d8741699eaaa17ea2ddfa857e"
                }
              }
        }
      }

in  Generate c
