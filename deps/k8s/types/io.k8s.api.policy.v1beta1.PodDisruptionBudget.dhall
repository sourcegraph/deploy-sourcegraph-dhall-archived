{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.policy.v1beta1.PodDisruptionBudgetSpec.dhall sha256:f07f2c32e97e6c986514a645cbbbe5985f025debdda6f5ba3d4bd78c3d112b26
, status :
    Optional
      ./io.k8s.api.policy.v1beta1.PodDisruptionBudgetStatus.dhall sha256:f41d614e38f6c1ff78ecc7a17f32d3346120af17843fb0b5a3fd8787f709852e
}
