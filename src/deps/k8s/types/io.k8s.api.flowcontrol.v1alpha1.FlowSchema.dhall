{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.flowcontrol.v1alpha1.FlowSchemaSpec.dhall sha256:4252ff6c8421c1623a1d88e26957d64e06e2c9b3884d752fe377ff7f590cb06b
, status :
    Optional
      ./io.k8s.api.flowcontrol.v1alpha1.FlowSchemaStatus.dhall sha256:57148bcd08844e30eb39331c5a11deb1ea3867e920744f236968bc2597babe0e
}
