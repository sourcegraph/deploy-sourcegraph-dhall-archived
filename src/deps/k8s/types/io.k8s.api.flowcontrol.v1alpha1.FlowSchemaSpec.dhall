{ priorityLevelConfiguration :
    ./io.k8s.api.flowcontrol.v1alpha1.PriorityLevelConfigurationReference.dhall sha256:c9078ba25443af62d7179d609dd2b291fad7c2bfb66fbb35b6c79b439ea269aa
, distinguisherMethod :
    Optional
      ./io.k8s.api.flowcontrol.v1alpha1.FlowDistinguisherMethod.dhall sha256:63cbc0be4db47903f615f19674a26cca5c45c8267243f9d08c76e3704d5d939d
, matchingPrecedence : Optional Natural
, rules :
    Optional
      ( List
          ./io.k8s.api.flowcontrol.v1alpha1.PolicyRulesWithSubjects.dhall sha256:13f12ba7d80dad27a39830ec871997a4154ab425b4bd4a49c5050045860a3430
      )
}
