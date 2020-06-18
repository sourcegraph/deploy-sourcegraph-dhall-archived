{ backend :
    Optional
      ./io.k8s.api.networking.v1beta1.IngressBackend.dhall sha256:45106e664aa9c1b3f118eb31b9af70c80df866b3eef9222d7b7dce37995fc957
, rules :
    Optional
      ( List
          ./io.k8s.api.networking.v1beta1.IngressRule.dhall sha256:a27d47357742ab2ebef3a700a9194e64c4318729f0cf8725b742ca42293998a9
      )
, tls :
    Optional
      ( List
          ./io.k8s.api.networking.v1beta1.IngressTLS.dhall sha256:a7f38221e7395a5109afb666e039e205c8b162ed1a74743b4257d65b5103a34b
      )
}
