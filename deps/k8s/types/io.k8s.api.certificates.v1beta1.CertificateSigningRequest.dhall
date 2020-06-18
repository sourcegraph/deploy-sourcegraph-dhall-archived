{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.certificates.v1beta1.CertificateSigningRequestSpec.dhall sha256:398af19d83b6f13f5dc197dd76901e17d8c50bfcf6ce6509ce5187885eae8d83
, status :
    Optional
      ./io.k8s.api.certificates.v1beta1.CertificateSigningRequestStatus.dhall sha256:49acdd68d4d78ae81a08d4cc77f6dd4a3a5809a1c8911ce65067cc4d6cc9bdab
}
