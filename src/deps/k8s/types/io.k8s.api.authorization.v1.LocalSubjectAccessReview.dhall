{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    ./io.k8s.api.authorization.v1.SubjectAccessReviewSpec.dhall sha256:387b5432543fd0ef8b9ae588707615cf94a21912fb4d76f22423071d415b2518
, status :
    Optional
      ./io.k8s.api.authorization.v1.SubjectAccessReviewStatus.dhall sha256:d6afe026d4ec57c4c153a312ab04cede25fdf55eabdbcfc3b530da0a80c1de75
}
