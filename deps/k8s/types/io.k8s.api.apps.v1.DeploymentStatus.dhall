{ availableReplicas : Optional Natural
, collisionCount : Optional Natural
, conditions :
    Optional
      ( List
          ./io.k8s.api.apps.v1.DeploymentCondition.dhall sha256:7454a3ace769a8acf66bee0a25a9558dee6ff2dc7343d87e38524e7d3f1c8baa
      )
, observedGeneration : Optional Natural
, readyReplicas : Optional Natural
, replicas : Optional Natural
, unavailableReplicas : Optional Natural
, updatedReplicas : Optional Natural
}
