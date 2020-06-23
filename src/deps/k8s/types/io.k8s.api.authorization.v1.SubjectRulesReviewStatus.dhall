{ incomplete : Bool
, nonResourceRules :
    List
      ./io.k8s.api.authorization.v1.NonResourceRule.dhall sha256:b51a6afe38ae0045550472760a4c76ce880d34a181916ea8fe591cc6d1b947bd
, resourceRules :
    List
      ./io.k8s.api.authorization.v1.ResourceRule.dhall sha256:68e1f515646e0a0f67371555ab94b3eb338cbe5f05e2c9dfcd666908c776380a
, evaluationError : Optional Text
}
