{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    ./io.k8s.api.authorization.v1.SelfSubjectAccessReviewSpec.dhall sha256:e36b52c0eb50658166e3a32f4fe8796df1240c3581cd56b4d70ce76e9f66d1c5
, status :
    Optional
      ./io.k8s.api.authorization.v1.SubjectAccessReviewStatus.dhall sha256:d6afe026d4ec57c4c153a312ab04cede25fdf55eabdbcfc3b530da0a80c1de75
}
