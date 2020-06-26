{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, template :
    Optional
      ./io.k8s.api.core.v1.PodTemplateSpec.dhall sha256:8eea21c0ace52dd3f671f41d6de30abdfb10ba05bf0b44f571472a6a6d689b1f
}
