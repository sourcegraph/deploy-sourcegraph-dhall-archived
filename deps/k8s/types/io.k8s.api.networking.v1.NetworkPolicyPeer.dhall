{ ipBlock :
    Optional
      ./io.k8s.api.networking.v1.IPBlock.dhall sha256:2ce02879528378925627f0d3ed82a2fd684ce81b0852ff7738cd8624064bd84e
, namespaceSelector :
    Optional
      ./io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall sha256:42d27b2708fa26aff105ab514c1d2db674891c9f9cdee0850e0d647435aeddb7
, podSelector :
    Optional
      ./io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall sha256:42d27b2708fa26aff105ab514c1d2db674891c9f9cdee0850e0d647435aeddb7
}
