{ failurePolicy = None Text
, matchPolicy = None Text
, namespaceSelector =
    None
      ./../types/io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall sha256:42d27b2708fa26aff105ab514c1d2db674891c9f9cdee0850e0d647435aeddb7
, objectSelector =
    None
      ./../types/io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall sha256:42d27b2708fa26aff105ab514c1d2db674891c9f9cdee0850e0d647435aeddb7
, reinvocationPolicy = None Text
, rules =
    None
      ( List
          ./../types/io.k8s.api.admissionregistration.v1.RuleWithOperations.dhall sha256:ee46b465a52a8f80e0d085792749aaf74494d084bcd97b5f9a3f656a5bcce700
      )
, timeoutSeconds = None Natural
}
