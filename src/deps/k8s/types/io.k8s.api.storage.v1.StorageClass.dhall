{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, provisioner : Text
, allowVolumeExpansion : Optional Bool
, allowedTopologies :
    Optional
      ( List
          ./io.k8s.api.core.v1.TopologySelectorTerm.dhall sha256:f2ce6c67804c388a2ff1d032b7d02a920b2bf446189c5507576204c64fdd2daf
      )
, mountOptions : Optional (List Text)
, parameters : Optional (List { mapKey : Text, mapValue : Text })
, reclaimPolicy : Optional Text
, volumeBindingMode : Optional Text
}
