{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.core.v1.PersistentVolumeClaimSpec.dhall sha256:21005ba2eea7e5a8172fba37e1bb64623aa1fbef02f6dfff2f891d00584d2a61
, status :
    Optional
      ./io.k8s.api.core.v1.PersistentVolumeClaimStatus.dhall sha256:bdf93cb952d83de9ee668bee81d06d1fce235c4179f66303c4ca8f146bc403d4
}
