{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.autoscaling.v1.ScaleSpec.dhall sha256:7dc1170369dcc8e6fa340047e95c4660e405fac1b7f7da3a0d6edf01ac06f75a
, status :
    Optional
      ./io.k8s.api.autoscaling.v1.ScaleStatus.dhall sha256:d76d78afa568044a4282306ada81504a5d800bc79be897cef1d388fc40903cdb
}
