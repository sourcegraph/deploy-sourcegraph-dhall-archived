{ configMapRef :
    Optional
      ./io.k8s.api.core.v1.ConfigMapEnvSource.dhall sha256:4680cbf427a543cffdaa5d69240e3b8c4d6c462b66a37f8820d6b669b6bc83fe
, prefix : Optional Text
, secretRef :
    Optional
      ./io.k8s.api.core.v1.SecretEnvSource.dhall sha256:4680cbf427a543cffdaa5d69240e3b8c4d6c462b66a37f8820d6b669b6bc83fe
}
