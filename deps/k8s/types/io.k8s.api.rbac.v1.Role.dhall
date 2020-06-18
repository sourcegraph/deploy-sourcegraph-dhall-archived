{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, rules :
    Optional
      ( List
          ./io.k8s.api.rbac.v1.PolicyRule.dhall sha256:17e974989fba49239f59d6f97d135d58e9b99959d84ef24f8361887ce526c246
      )
}
