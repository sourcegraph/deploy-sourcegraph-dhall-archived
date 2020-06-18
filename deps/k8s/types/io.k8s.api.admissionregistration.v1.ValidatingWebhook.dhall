{ admissionReviewVersions : List Text
, clientConfig :
    ./io.k8s.api.admissionregistration.v1.WebhookClientConfig.dhall sha256:e65d81831ebd9f944992c1654a3b4bb83579ed4286759e18db4c83dc5613a9ce
, name : Text
, sideEffects : Text
, failurePolicy : Optional Text
, matchPolicy : Optional Text
, namespaceSelector :
    Optional
      ./io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall sha256:42d27b2708fa26aff105ab514c1d2db674891c9f9cdee0850e0d647435aeddb7
, objectSelector :
    Optional
      ./io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall sha256:42d27b2708fa26aff105ab514c1d2db674891c9f9cdee0850e0d647435aeddb7
, rules :
    Optional
      ( List
          ./io.k8s.api.admissionregistration.v1.RuleWithOperations.dhall sha256:ee46b465a52a8f80e0d085792749aaf74494d084bcd97b5f9a3f656a5bcce700
      )
, timeoutSeconds : Optional Natural
}
