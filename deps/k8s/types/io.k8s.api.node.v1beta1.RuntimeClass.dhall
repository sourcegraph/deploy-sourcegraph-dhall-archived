{ apiVersion : Text
, handler : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, overhead :
    Optional
      ./io.k8s.api.node.v1beta1.Overhead.dhall sha256:393de94dca7cf7d676b07d0b52901cf6810f8cb54a47d32efe73d8b0fe528f9e
, scheduling :
    Optional
      ./io.k8s.api.node.v1beta1.Scheduling.dhall sha256:110604e0f9e7f1cb8948cf321f0b336fc61aef6e3524ce9d77e8f0e35b1047de
}
