{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.core.v1.ResourceQuotaSpec.dhall sha256:fafb1be38cfedbfaabdfa173bd9df9e873f44679201ad847bfa6c36528c3fda4
, status :
    Optional
      ./io.k8s.api.core.v1.ResourceQuotaStatus.dhall sha256:ce3caad70b051fa74f23173148cfece94f1a7359fd0b4799ce8608f111ac1dd5
}
