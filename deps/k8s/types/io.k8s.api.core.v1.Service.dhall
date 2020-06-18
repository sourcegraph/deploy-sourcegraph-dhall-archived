{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.core.v1.ServiceSpec.dhall sha256:15c26885a596f5cfa4d137afa37ee92a844e6eee06f942c52bf3c3b255ba9ba5
, status :
    Optional
      ./io.k8s.api.core.v1.ServiceStatus.dhall sha256:90c576fb3ddb9e973bcf91246d9f2a196ae0237cba9622cd767a628fcfcd93cc
}
