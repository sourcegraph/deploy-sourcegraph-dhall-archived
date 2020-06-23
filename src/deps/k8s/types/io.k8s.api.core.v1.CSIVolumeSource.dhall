{ driver : Text
, fsType : Optional Text
, nodePublishSecretRef :
    Optional
      ./io.k8s.api.core.v1.LocalObjectReference.dhall sha256:30bd7e61dae821a9532f640611a37bbebac3dc2ba02b82298a5c295280f1501f
, readOnly : Optional Bool
, volumeAttributes : Optional (List { mapKey : Text, mapValue : Text })
}
