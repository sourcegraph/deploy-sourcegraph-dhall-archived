{ podManagementPolicy = None Text
, replicas = None Natural
, revisionHistoryLimit = None Natural
, updateStrategy =
    None
      ./../types/io.k8s.api.apps.v1.StatefulSetUpdateStrategy.dhall sha256:25688a09d7c35ed914ab9d83d0e757a756352e48e266f960d04d143739959d71
, volumeClaimTemplates =
    None
      ( List
          ./../types/io.k8s.api.core.v1.PersistentVolumeClaim.dhall sha256:8871db06b6afbd573730f5a093c4df5df7d9c418a2a7b3d0b4ecbe7e77aca10f
      )
}
