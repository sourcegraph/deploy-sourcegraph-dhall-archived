{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    ./io.k8s.api.authentication.v1.TokenReviewSpec.dhall sha256:0a6ae7ca05b54f347422693980d8d4bd1c82d0161869f33eabffd40df97029e2
, status :
    Optional
      ./io.k8s.api.authentication.v1.TokenReviewStatus.dhall sha256:3249ebb51cedc1034a036e010798fdabce41ee963bac691f5b884de7d05fae79
}
