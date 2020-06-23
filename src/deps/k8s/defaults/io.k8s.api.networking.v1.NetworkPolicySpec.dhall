{ egress =
    None
      ( List
          ./../types/io.k8s.api.networking.v1.NetworkPolicyEgressRule.dhall sha256:6a24e465a87e577ef2a193fd54dd7aa711309e6c1fe06772c06d82b27facca0e
      )
, ingress =
    None
      ( List
          ./../types/io.k8s.api.networking.v1.NetworkPolicyIngressRule.dhall sha256:722d0c6f53964fe86861d69eb30d9639f3d5b0d3c3c4d4b8caae17d1fd38334b
      )
, policyTypes = None (List Text)
}
