let Configuration/universal = ../../configuration/universal.dhall

let Configuration/container = ../../configuration/container.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let containers =
      { Type = { Gitserver : Configuration/container.Type }
      , default.Gitserver = Configuration/container.default
      }

let statefulset =
      { Type =
          { namespace : Optional Text
          , additionalAnnotations : Optional (List Util/KeyValuePair)
          , additionalLabels : Optional (List Util/KeyValuePair)
          , replicas : Optional Natural
          , Containers : containers.Type
          }
      , default =
        { namespace = None Text
        , additionalAnnotations = None (List Util/KeyValuePair)
        , additionalLabels = None (List Util/KeyValuePair)
        , replicas = None Natural
        , Containers = containers.default
        }
      }

let configuration =
      { Type =
          { StatefulSet : statefulset.Type
          , Service : Configuration/universal.Type
          }
      , default =
        { StatefulSet = statefulset.default
        , Service = Configuration/universal.default
        }
      }

in  configuration
