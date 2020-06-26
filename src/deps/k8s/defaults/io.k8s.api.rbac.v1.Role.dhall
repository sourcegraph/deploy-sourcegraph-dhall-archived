{ apiVersion = "rbac.authorization.k8s.io/v1"
, kind = "Role"
, rules =
    None
      ( List
          ./../types/io.k8s.api.rbac.v1.PolicyRule.dhall sha256:17e974989fba49239f59d6f97d135d58e9b99959d84ef24f8361887ce526c246
      )
}
