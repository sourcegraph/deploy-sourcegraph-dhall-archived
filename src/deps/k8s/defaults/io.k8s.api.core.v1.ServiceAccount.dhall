{ apiVersion = "v1"
, kind = "ServiceAccount"
, automountServiceAccountToken = None Bool
, imagePullSecrets =
    None
      ( List
          ../types/io.k8s.api.core.v1.LocalObjectReference.dhall sha256:30bd7e61dae821a9532f640611a37bbebac3dc2ba02b82298a5c295280f1501f
      )
, secrets =
    None
      ( List
          ../types/io.k8s.api.core.v1.ObjectReference.dhall sha256:301e65c686131086591aa0b6dd2617527427de49fcc87608a1f4b5f23fcb596c
      )
}
