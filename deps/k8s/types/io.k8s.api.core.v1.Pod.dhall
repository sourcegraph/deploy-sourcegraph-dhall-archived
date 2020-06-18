{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.core.v1.PodSpec.dhall sha256:e149755ea935e46989a7a1f11d91e4c2f03896268f9e0a4a5aa5a2ebbc0c809f
, status :
    Optional
      ./io.k8s.api.core.v1.PodStatus.dhall sha256:76800003e551406fea214c10166149b231668764a166a11579a1dcb8eac94d81
}
