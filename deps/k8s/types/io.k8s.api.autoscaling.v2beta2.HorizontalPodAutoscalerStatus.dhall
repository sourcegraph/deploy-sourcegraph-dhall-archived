{ conditions :
    List
      ./io.k8s.api.autoscaling.v2beta2.HorizontalPodAutoscalerCondition.dhall sha256:10de5e5aed3f6e1721f79bd8e2f9ffcecb92658fbe7442e6eaf74c6780b4779d
, currentReplicas : Natural
, desiredReplicas : Natural
, currentMetrics :
    Optional
      ( List
          ./io.k8s.api.autoscaling.v2beta2.MetricStatus.dhall sha256:b0a9e0997252e42b06ccdb81da8da742bc5171ad276415fc7d9d25eaef9f187d
      )
, lastScaleTime :
    Optional
      ./io.k8s.apimachinery.pkg.apis.meta.v1.Time.dhall sha256:b9c75dfe7b1571f8b606d709a1103d67f86f16e04e63aa0de9856cd00904d4a2
, observedGeneration : Optional Natural
}
