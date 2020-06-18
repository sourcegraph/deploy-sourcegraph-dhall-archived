{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.kube-aggregator.pkg.apis.apiregistration.v1.APIServiceSpec.dhall sha256:ca6b19e83944739ca2c7f8fefa6efce503fb3186dff921d605804bf98b3b1a3a
, status :
    Optional
      ./io.k8s.kube-aggregator.pkg.apis.apiregistration.v1.APIServiceStatus.dhall sha256:f522d2f4fb2c8fc66549515fbe67192555e8a35b988e323c808ef0ebadf3e0a4
}
