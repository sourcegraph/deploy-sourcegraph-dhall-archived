{ subjects :
    List
      ./io.k8s.api.flowcontrol.v1alpha1.Subject.dhall sha256:81bf2398cf01a10e8a562df4fdf69ee81e18941f010d6ffd43008862ae196b99
, nonResourceRules :
    Optional
      ( List
          ./io.k8s.api.flowcontrol.v1alpha1.NonResourcePolicyRule.dhall sha256:843f653f828353adc01227a57f6b93ef95ea389407b53f6f14e569dd2c25c413
      )
, resourceRules :
    Optional
      ( List
          ./io.k8s.api.flowcontrol.v1alpha1.ResourcePolicyRule.dhall sha256:178636c39de1089a7a0259df4a3844d22d6b2f073ead195c06508438310aa6ab
      )
}
