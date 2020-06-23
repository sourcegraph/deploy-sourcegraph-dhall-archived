{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.batch.v1.JobSpec.dhall sha256:889c6603b392cdbcf252a97889b14807dc1bc7b320fc71ca1a1ab1dcf76a7a12
, status :
    Optional
      ./io.k8s.api.batch.v1.JobStatus.dhall sha256:359a0ae893c3951a17a95b44bd5c11707217055b227d331b71cd890db3ac201d
}
