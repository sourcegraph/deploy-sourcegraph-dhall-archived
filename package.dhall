let Kubernetes/EnvVar =
    -- we should rethink whether or not we want to expose this directly
    -- or create a type with a "nice" interface
      ./src/deps/k8s/schemas/io.k8s.api.core.v1.EnvVar.dhall

let Base/render = ./src/base/render.dhall

let Configuration/global = ./src/configuration/global.dhall

let Configuration/cloudProvider = ./src/configuration/cloud-provider.dhall

in  { Configuration =
      { Global = Configuration/global
      , CloudProvider = Configuration/cloudProvider
      , EnvVar = Kubernetes/EnvVar
      }
    , Render = Base/render
    }
