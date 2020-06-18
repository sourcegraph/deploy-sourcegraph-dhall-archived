{ apiVersion = "admissionregistration.k8s.io/v1"
, kind = "MutatingWebhookConfiguration"
, webhooks =
    None
      ( List
          ./../types/io.k8s.api.admissionregistration.v1.MutatingWebhook.dhall sha256:efd9982e7e8a60db4df6ba7347a877073fa6efaed429e99569978d4d0b1cc630
      )
}
