{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.apps.v1.StatefulSetSpec.dhall sha256:798c7225b11a973523a7e771e3389b452389bd8c24af84533ced50b717ae1daf
, status :
    Optional
      ./io.k8s.api.apps.v1.StatefulSetStatus.dhall sha256:d5a3a33833911b1885d22dd9d5a8a90cb93d106d31b0690c81159288005a7c06
}
