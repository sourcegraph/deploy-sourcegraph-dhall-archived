{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    ./io.k8s.api.storage.v1.VolumeAttachmentSpec.dhall sha256:99822a1a350d49a62f72b4bd0ebe7ce33c64d2048f735654ebbb80d84f3f3b58
, status :
    Optional
      ./io.k8s.api.storage.v1.VolumeAttachmentStatus.dhall sha256:1547a40467a71f9daa556d9fa6b247c56f63c2219b34d369c960034f7b9da5ec
}
