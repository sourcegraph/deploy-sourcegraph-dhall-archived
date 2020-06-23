{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    ./io.k8s.api.authorization.v1.SelfSubjectRulesReviewSpec.dhall sha256:61ad808f31d439776dd4e77cca598ed556ffb6217185fb2de1ae7d5ecb37d686
, status :
    Optional
      ./io.k8s.api.authorization.v1.SubjectRulesReviewStatus.dhall sha256:04530d2b081a1f465ba6e969b650c39d68963f5c21811588e8f12c5b89229b2f
}
