{ selector :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall sha256:42d27b2708fa26aff105ab514c1d2db674891c9f9cdee0850e0d647435aeddb7
, serviceName : Text
, template :
    ./io.k8s.api.core.v1.PodTemplateSpec.dhall sha256:8eea21c0ace52dd3f671f41d6de30abdfb10ba05bf0b44f571472a6a6d689b1f
, podManagementPolicy : Optional Text
, replicas : Optional Natural
, revisionHistoryLimit : Optional Natural
, updateStrategy :
    Optional
      ./io.k8s.api.apps.v1.StatefulSetUpdateStrategy.dhall sha256:25688a09d7c35ed914ab9d83d0e757a756352e48e266f960d04d143739959d71
, volumeClaimTemplates :
    Optional
      ( List
          ./io.k8s.api.core.v1.PersistentVolumeClaim.dhall sha256:8871db06b6afbd573730f5a093c4df5df7d9c418a2a7b3d0b4ecbe7e77aca10f
      )
}
