{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, webhooks :
    Optional
      ( List
          ./io.k8s.api.admissionregistration.v1.MutatingWebhook.dhall sha256:efd9982e7e8a60db4df6ba7347a877073fa6efaed429e99569978d4d0b1cc630
      )
}
