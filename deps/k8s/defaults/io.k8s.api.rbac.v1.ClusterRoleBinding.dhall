{ apiVersion = "rbac.authorization.k8s.io/v1"
, kind = "ClusterRoleBinding"
, subjects =
    None
      ( List
          ./../types/io.k8s.api.rbac.v1.Subject.dhall sha256:d1fc22ae76a7fd25f8b0dd643142c35ccc77e6972a2762f36cc9e92d3b739883
      )
}
