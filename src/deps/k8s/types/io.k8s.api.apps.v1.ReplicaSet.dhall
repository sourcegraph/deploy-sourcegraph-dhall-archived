{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.apps.v1.ReplicaSetSpec.dhall sha256:61175713ff8861c718e5ae9f4c548ec9e820438f25b1cf197bc80196ae73cfed
, status :
    Optional
      ./io.k8s.api.apps.v1.ReplicaSetStatus.dhall sha256:079fb913272c088967f80c8404e28b1b15756edf6ad3de056947f268ff4303da
}
