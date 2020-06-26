{ apiVersion = "rbac.authorization.k8s.io/v1"
, kind = "ClusterRole"
, aggregationRule =
    None
      ../types/io.k8s.api.rbac.v1.AggregationRule.dhall sha256:049fb571b74b1547fa9a27f7a2b67289213a625c217976a582bd1cef7d42c793
, rules =
    None
      ( List
          ../types/io.k8s.api.rbac.v1.PolicyRule.dhall sha256:17e974989fba49239f59d6f97d135d58e9b99959d84ef24f8361887ce526c246
      )
}
