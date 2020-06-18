{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, roleRef :
    ./io.k8s.api.rbac.v1.RoleRef.dhall sha256:e8f584f3fc058dfea4a3ffc977f421d3f5ba9abc2c7c3d5efa688e3687d91256
, subjects :
    Optional
      ( List
          ./io.k8s.api.rbac.v1.Subject.dhall sha256:d1fc22ae76a7fd25f8b0dd643142c35ccc77e6972a2762f36cc9e92d3b739883
      )
}
