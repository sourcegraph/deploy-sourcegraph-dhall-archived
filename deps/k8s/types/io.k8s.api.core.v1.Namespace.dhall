{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.core.v1.NamespaceSpec.dhall sha256:4bb22a01e6a709a7d47f148b3364a486a252b33067c2c117f7d123387b880063
, status :
    Optional
      ./io.k8s.api.core.v1.NamespaceStatus.dhall sha256:fd295a424680a66bb56402bcb29aa351d6df906b96e4066726d9c22b2a63e722
}
