{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.flowcontrol.v1alpha1.PriorityLevelConfigurationSpec.dhall sha256:9d7e3cc7a2802271238dc98f9d13b7f011b9f756ad0ae00c30aee4d18cf61a7a
, status :
    Optional
      ./io.k8s.api.flowcontrol.v1alpha1.PriorityLevelConfigurationStatus.dhall sha256:57148bcd08844e30eb39331c5a11deb1ea3867e920744f236968bc2597babe0e
}
