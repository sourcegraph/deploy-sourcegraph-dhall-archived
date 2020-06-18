{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, conditions :
    Optional
      ( List
          ./io.k8s.api.core.v1.ComponentCondition.dhall sha256:391c0a7fda55e3249c6abb2e38eec0b10fa0a6edfa9440da2ce47e494f6a6373
      )
}
