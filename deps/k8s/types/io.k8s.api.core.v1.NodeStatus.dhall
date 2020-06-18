{ addresses :
    Optional
      ( List
          ./io.k8s.api.core.v1.NodeAddress.dhall sha256:045445ce246644f1bf31fbec139c87ab705b0d87660545a9ef6a7934083ddc3d
      )
, allocatable : Optional (List { mapKey : Text, mapValue : Text })
, capacity : Optional (List { mapKey : Text, mapValue : Text })
, conditions :
    Optional
      ( List
          ./io.k8s.api.core.v1.NodeCondition.dhall sha256:3eb423c67682c0325e8088190f07549c6a5aa02ac576e4095a3b7fcf369d3d22
      )
, config :
    Optional
      ./io.k8s.api.core.v1.NodeConfigStatus.dhall sha256:ab712af81ceed1fc9c2570d8ca9173c925526d32fd466802f27e288064df7e5f
, daemonEndpoints :
    Optional
      ./io.k8s.api.core.v1.NodeDaemonEndpoints.dhall sha256:e1a6539f47f5776511200c12d2f80148ee6db9cc00d6c7b8b80af6c3dc705357
, images :
    Optional
      ( List
          ./io.k8s.api.core.v1.ContainerImage.dhall sha256:48998e9b43b9d1c5b27bf20fb906ca4707f5de51298f8f2ebbc7671aca0eaa37
      )
, nodeInfo :
    Optional
      ./io.k8s.api.core.v1.NodeSystemInfo.dhall sha256:571dff0d34a9fc1ac3f2b2e8e2d0a3180e0b0d7870a85eccc71e581566fa4059
, phase : Optional Text
, volumesAttached :
    Optional
      ( List
          ./io.k8s.api.core.v1.AttachedVolume.dhall sha256:41d225bedf28907d18bcf746b630ad52788af8ae1a1d1236798fdf439727ad32
      )
, volumesInUse : Optional (List Text)
}
