{ accessModes = None (List Text)
, capacity = None (List { mapKey : Text, mapValue : Text })
, conditions =
    None
      ( List
          ./../types/io.k8s.api.core.v1.PersistentVolumeClaimCondition.dhall sha256:253ee70013b7ce83570cd49d6e14c029e6f652e7e70b1fac3b10213619d42f05
      )
, phase = None Text
}
