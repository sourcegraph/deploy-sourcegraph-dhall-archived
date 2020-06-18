{ driver : Text
, volumeHandle : Text
, controllerExpandSecretRef :
    Optional
      ./io.k8s.api.core.v1.SecretReference.dhall sha256:aac2bf127e8931850f04d76f4a3a0eb7deec3b4af46f018d4cd6560167e630df
, controllerPublishSecretRef :
    Optional
      ./io.k8s.api.core.v1.SecretReference.dhall sha256:aac2bf127e8931850f04d76f4a3a0eb7deec3b4af46f018d4cd6560167e630df
, fsType : Optional Text
, nodePublishSecretRef :
    Optional
      ./io.k8s.api.core.v1.SecretReference.dhall sha256:aac2bf127e8931850f04d76f4a3a0eb7deec3b4af46f018d4cd6560167e630df
, nodeStageSecretRef :
    Optional
      ./io.k8s.api.core.v1.SecretReference.dhall sha256:aac2bf127e8931850f04d76f4a3a0eb7deec3b4af46f018d4cd6560167e630df
, readOnly : Optional Bool
, volumeAttributes : Optional (List { mapKey : Text, mapValue : Text })
}
