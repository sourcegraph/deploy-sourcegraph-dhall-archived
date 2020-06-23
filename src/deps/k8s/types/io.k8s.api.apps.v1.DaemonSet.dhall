{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.apps.v1.DaemonSetSpec.dhall sha256:f653e781d6af8a93e56c5134f1a698d9512d74d626acc53d66bfa60895c452cc
, status :
    Optional
      ./io.k8s.api.apps.v1.DaemonSetStatus.dhall sha256:8df7934b5710e2cd7436b009df0b714ede641037aaa5d5757e257f4f285515e8
}
