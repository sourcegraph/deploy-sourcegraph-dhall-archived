{ apiVersion = "storage.k8s.io/v1"
, kind = "StorageClass"
, allowVolumeExpansion = None Bool
, allowedTopologies =
    None
      ( List
          ./../types/io.k8s.api.core.v1.TopologySelectorTerm.dhall sha256:f2ce6c67804c388a2ff1d032b7d02a920b2bf446189c5507576204c64fdd2daf
      )
, mountOptions = None (List Text)
, parameters = None (List { mapKey : Text, mapValue : Text })
, reclaimPolicy = None Text
, volumeBindingMode = None Text
}
