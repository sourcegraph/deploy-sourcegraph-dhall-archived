{ replicas : Natural
, collisionCount : Optional Natural
, conditions :
    Optional
      ( List
          ./io.k8s.api.apps.v1.StatefulSetCondition.dhall sha256:10de5e5aed3f6e1721f79bd8e2f9ffcecb92658fbe7442e6eaf74c6780b4779d
      )
, currentReplicas : Optional Natural
, currentRevision : Optional Text
, observedGeneration : Optional Natural
, readyReplicas : Optional Natural
, updateRevision : Optional Text
, updatedReplicas : Optional Natural
}
