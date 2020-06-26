{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    ./io.k8s.api.authentication.v1.TokenRequestSpec.dhall sha256:8dde13394f73102031764366eaf7735de8e932ae70034b0a61233ac34a889d70
, status :
    Optional
      ./io.k8s.api.authentication.v1.TokenRequestStatus.dhall sha256:29da297f2ae7ea2153d0a44c061c91a0750a4ec9db6ae0b6e1a4eb70e564fe96
}
