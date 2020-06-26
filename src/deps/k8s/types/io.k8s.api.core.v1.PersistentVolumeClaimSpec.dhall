{ accessModes : Optional (List Text)
, dataSource :
    Optional
      ./io.k8s.api.core.v1.TypedLocalObjectReference.dhall sha256:ce043c1c8d01dc969702685befe954309a133412feb072957743c6d250b132be
, resources :
    Optional
      ./io.k8s.api.core.v1.ResourceRequirements.dhall sha256:e6a52f46fab854b0ba0f7267cbea09584e22585481acfc0959e205dd5f1cb30a
, selector :
    Optional
      ./io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall sha256:42d27b2708fa26aff105ab514c1d2db674891c9f9cdee0850e0d647435aeddb7
, storageClassName : Optional Text
, volumeMode : Optional Text
, volumeName : Optional Text
}
