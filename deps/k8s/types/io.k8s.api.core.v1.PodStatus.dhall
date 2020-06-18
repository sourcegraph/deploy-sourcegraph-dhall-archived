{ conditions :
    Optional
      ( List
          ./io.k8s.api.core.v1.PodCondition.dhall sha256:253ee70013b7ce83570cd49d6e14c029e6f652e7e70b1fac3b10213619d42f05
      )
, containerStatuses :
    Optional
      ( List
          ./io.k8s.api.core.v1.ContainerStatus.dhall sha256:7706d3f9cc0510a39a00fca92941f41871d710755afe1d6be808895d7500f4ee
      )
, ephemeralContainerStatuses :
    Optional
      ( List
          ./io.k8s.api.core.v1.ContainerStatus.dhall sha256:7706d3f9cc0510a39a00fca92941f41871d710755afe1d6be808895d7500f4ee
      )
, hostIP : Optional Text
, initContainerStatuses :
    Optional
      ( List
          ./io.k8s.api.core.v1.ContainerStatus.dhall sha256:7706d3f9cc0510a39a00fca92941f41871d710755afe1d6be808895d7500f4ee
      )
, message : Optional Text
, nominatedNodeName : Optional Text
, phase : Optional Text
, podIP : Optional Text
, podIPs :
    Optional
      ( List
          ./io.k8s.api.core.v1.PodIP.dhall sha256:690ddd3c7ed236568205794ef055f237828e3463dc1c54637b8133693985bb82
      )
, qosClass : Optional Text
, reason : Optional Text
, startTime :
    Optional
      ./io.k8s.apimachinery.pkg.apis.meta.v1.Time.dhall sha256:b9c75dfe7b1571f8b606d709a1103d67f86f16e04e63aa0de9856cd00904d4a2
}
