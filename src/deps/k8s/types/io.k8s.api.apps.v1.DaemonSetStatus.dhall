{ currentNumberScheduled : Natural
, desiredNumberScheduled : Natural
, numberMisscheduled : Natural
, numberReady : Natural
, collisionCount : Optional Natural
, conditions :
    Optional
      ( List
          ./io.k8s.api.apps.v1.DaemonSetCondition.dhall sha256:10de5e5aed3f6e1721f79bd8e2f9ffcecb92658fbe7442e6eaf74c6780b4779d
      )
, numberAvailable : Optional Natural
, numberUnavailable : Optional Natural
, observedGeneration : Optional Natural
, updatedNumberScheduled : Optional Natural
}
