{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, spec :
    Optional
      ./io.k8s.api.apps.v1.DeploymentSpec.dhall sha256:1aa0e0d14a7b2932a29529a2297f245555fe68e9131cdbc5e19be401c34eb19d
, status :
    Optional
      ./io.k8s.api.apps.v1.DeploymentStatus.dhall sha256:9c3ae8b25a14bc2fdfe3bbfe292ee0c4b2ed3023dda4515d6c815e8ff41363ed
}
