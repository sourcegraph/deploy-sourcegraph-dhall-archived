{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.core.v1.PersistentVolumeSpec.dhall sha256:43cba30af0cb3b230c5f793d2ca750142bce783a002f0205c38b0d10901d0bfe
, status :
    Optional
      ./io.k8s.api.core.v1.PersistentVolumeStatus.dhall sha256:eb89139aad9c36d3e517c26ee3e7013ee91be0ffb6921d2e064625458762e135
}
