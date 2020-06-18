{ replicas : Natural
, availableReplicas : Optional Natural
, conditions :
    Optional
      ( List
          ./io.k8s.api.core.v1.ReplicationControllerCondition.dhall sha256:10de5e5aed3f6e1721f79bd8e2f9ffcecb92658fbe7442e6eaf74c6780b4779d
      )
, fullyLabeledReplicas : Optional Natural
, observedGeneration : Optional Natural
, readyReplicas : Optional Natural
}
