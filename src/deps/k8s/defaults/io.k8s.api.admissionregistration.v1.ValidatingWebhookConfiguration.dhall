{ apiVersion = "admissionregistration.k8s.io/v1"
, kind = "ValidatingWebhookConfiguration"
, webhooks =
    None
      ( List
          ./../types/io.k8s.api.admissionregistration.v1.ValidatingWebhook.dhall sha256:18715f6e37764232861393eeeb6f327dff26ad4cf3155eef08f3d199d4144acb
      )
}
