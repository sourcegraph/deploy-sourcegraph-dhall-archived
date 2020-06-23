{ preferredDuringSchedulingIgnoredDuringExecution :
    Optional
      ( List
          ./io.k8s.api.core.v1.WeightedPodAffinityTerm.dhall sha256:d31adc713699f2f3a6b88f5ccdadfd250d458010b678ce12bf87c76075c2e4df
      )
, requiredDuringSchedulingIgnoredDuringExecution :
    Optional
      ( List
          ./io.k8s.api.core.v1.PodAffinityTerm.dhall sha256:c1d3b90fb7c9be025d67529b5d602b3d3bedf368d2eaded64c7277f1bef6f689
      )
}
