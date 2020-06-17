let Kubernetes/ResourceRequirements =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ResourceRequirements.dhall

let Kubernetes/EnvVar = ../../deps/k8s/schemas/io.k8s.api.core.v1.EnvVar.dhall

let configuration =
      { Type =
          { image : Optional Text
          , resources : Optional Kubernetes/ResourceRequirements.Type
          , additionalEnvironmentVariables :
              Optional (List Kubernetes/EnvVar.Type)
          }
      , default =
        { image = None Text
        , resources = None Kubernetes/ResourceRequirements.Type
        , additionalEnvironmentVariables = None (List Kubernetes/EnvVar.Type)
        }
      }

in  configuration
