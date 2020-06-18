{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.core.v1.ReplicationControllerSpec.dhall sha256:996ac4204e547f4db3c40644affa7fc436f6ee84666012e316e40036b166129b
, status :
    Optional
      ./io.k8s.api.core.v1.ReplicationControllerStatus.dhall sha256:079fb913272c088967f80c8404e28b1b15756edf6ad3de056947f268ff4303da
}
