{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.batch.v1beta1.CronJobSpec.dhall sha256:05300da941e48bb5bd67081bdb3e993528235a1d7f8948ba112ddbd3100b7f33
, status :
    Optional
      ./io.k8s.api.batch.v1beta1.CronJobStatus.dhall sha256:a72616aa1127fdd7dcc66b891dad1550f2830325b7c4d3b88ac1bbfde394a5ea
}
