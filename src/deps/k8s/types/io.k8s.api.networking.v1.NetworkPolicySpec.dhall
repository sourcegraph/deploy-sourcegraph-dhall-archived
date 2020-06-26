{ podSelector :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall sha256:42d27b2708fa26aff105ab514c1d2db674891c9f9cdee0850e0d647435aeddb7
, egress :
    Optional
      ( List
          ./io.k8s.api.networking.v1.NetworkPolicyEgressRule.dhall sha256:6a24e465a87e577ef2a193fd54dd7aa711309e6c1fe06772c06d82b27facca0e
      )
, ingress :
    Optional
      ( List
          ./io.k8s.api.networking.v1.NetworkPolicyIngressRule.dhall sha256:722d0c6f53964fe86861d69eb30d9639f3d5b0d3c3c4d4b8caae17d1fd38334b
      )
, policyTypes : Optional (List Text)
}
