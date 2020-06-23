{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, webhooks :
    Optional
      ( List
          ./io.k8s.api.admissionregistration.v1.ValidatingWebhook.dhall sha256:18715f6e37764232861393eeeb6f327dff26ad4cf3155eef08f3d199d4144acb
      )
}
