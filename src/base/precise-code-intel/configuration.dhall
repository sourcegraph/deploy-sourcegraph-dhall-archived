let Configuration/universal = ../../configuration/universal.dhall

let Configuration/container = ../../configuration/container.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let BundleManager/containers =
      { Type = { BundleManager : Configuration/container.Type }
      , default.BundleManager = Configuration/container.default
      }

let BundleManager/deployment =
      { Type =
          { namespace : Optional Text
          , additionalAnnotations : Optional (List Util/KeyValuePair)
          , additionalLabels : Optional (List Util/KeyValuePair)
          , replicas : Optional Natural
          , Containers : BundleManager/containers.Type
          }
      , default =
        { namespace = None Text
        , additionalAnnotations = None (List Util/KeyValuePair)
        , additionalLabels = None (List Util/KeyValuePair)
        , replicas = None Natural
        , Containers = BundleManager/containers.default
        }
      }

let BundleManager/configuration =
      { Type =
          { Deployment : BundleManager/deployment.Type
          , PersistentVolumeClaim : Configuration/universal.Type
          , Service : Configuration/universal.Type
          }
      , default =
        { Deployment = BundleManager/deployment.default
        , PersistentVolumeClaim = Configuration/universal.default
        , Service = Configuration/universal.default
        }
      }

let Worker/containers =
      { Type = { Worker : Configuration/container.Type }
      , default.Worker = Configuration/container.default
      }

let Worker/deployment =
      { Type =
          { namespace : Optional Text
          , additionalAnnotations : Optional (List Util/KeyValuePair)
          , additionalLabels : Optional (List Util/KeyValuePair)
          , replicas : Optional Natural
          , Containers : Worker/containers.Type
          }
      , default =
        { namespace = None Text
        , additionalAnnotations = None (List Util/KeyValuePair)
        , additionalLabels = None (List Util/KeyValuePair)
        , replicas = None Natural
        , Containers = Worker/containers.default
        }
      }

let Worker/configuration =
      { Type =
          { Deployment : Worker/deployment.Type
          , Service : Configuration/universal.Type
          }
      , default =
        { Deployment = Worker/deployment.default
        , Service = Configuration/universal.default
        }
      }

let configuration =
      { Type =
          { BundleManager : BundleManager/configuration.Type
          , Worker : Worker/configuration.Type
          }
      , default =
        { BundleManager = BundleManager/configuration.default
        , Worker = Worker/configuration.default
        }
      }

in  configuration
