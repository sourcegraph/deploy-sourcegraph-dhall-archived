{ monitors : List Text
, path : Optional Text
, readOnly : Optional Bool
, secretFile : Optional Text
, secretRef :
    Optional
      ./io.k8s.api.core.v1.SecretReference.dhall sha256:aac2bf127e8931850f04d76f4a3a0eb7deec3b4af46f018d4cd6560167e630df
, user : Optional Text
}
