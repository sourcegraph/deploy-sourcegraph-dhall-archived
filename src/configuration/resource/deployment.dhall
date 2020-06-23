let Kubernetes/envVar = ../../deps/k8s/schemas/io.k8s.api.core.v1.EnvVar.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let configuration =
      { Type =
          { namespace : Optional Text
          , additionalAnnotations : Optional (List Util/KeyValuePair)
          , additionalLabels : Optional (List Util/KeyValuePair)
          , additionalEnvironmentVariables :
              Optional (List Kubernetes/envVar.Type)
          , image : Optional Text
          , replicas : Optional Natural
          }
      , default =
        { namespace = None Text
        , additionalAnnotations = None (List Util/KeyValuePair)
        , additionalLabels = None (List Util/KeyValuePair)
        , image = None Text
        , additionalEnvironmentVariables = None (List Kubernetes/envVar.Type)
        , replicas = None Natural
        }
      }

in  configuration
