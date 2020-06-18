{ maxReplicas : Natural
, scaleTargetRef :
    ./io.k8s.api.autoscaling.v2beta2.CrossVersionObjectReference.dhall sha256:686a8f9a56cb0e403746b5c80b3e8238f51e16138f95e7fd8c3a59f75912fb2d
, metrics :
    Optional
      ( List
          ./io.k8s.api.autoscaling.v2beta2.MetricSpec.dhall sha256:525e022545582db0485dce692cc83c35313a39973e9dcff42312c736b94e2e02
      )
, minReplicas : Optional Natural
}
