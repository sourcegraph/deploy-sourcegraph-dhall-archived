{ configMap :
    Optional
      ./io.k8s.api.core.v1.ConfigMapProjection.dhall sha256:b7fb477cfb8d37d20ab7e2de4a08e7f9c5bcf79329791ce33e0834848e27800b
, downwardAPI :
    Optional
      ./io.k8s.api.core.v1.DownwardAPIProjection.dhall sha256:365f0a0488af8087f114948cb7d0353f0240e94d4d3a0d90b3c71aac7048cbe1
, secret :
    Optional
      ./io.k8s.api.core.v1.SecretProjection.dhall sha256:b7fb477cfb8d37d20ab7e2de4a08e7f9c5bcf79329791ce33e0834848e27800b
, serviceAccountToken :
    Optional
      ./io.k8s.api.core.v1.ServiceAccountTokenProjection.dhall sha256:a34c4621eb6be8c65301ebe8b3858a930bbaba922f96d348a4155d42d854fe90
}
