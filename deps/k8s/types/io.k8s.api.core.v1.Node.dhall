{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.core.v1.NodeSpec.dhall sha256:3209864c4cd9db679f22f6bef7637d53de62ce7aa887ad5d8681ac2cf4fb049d
, status :
    Optional
      ./io.k8s.api.core.v1.NodeStatus.dhall sha256:f06b137d95bd1f53fdafe8a4496bef15794d1695e2132c85e36bef4ca8ea6705
}
