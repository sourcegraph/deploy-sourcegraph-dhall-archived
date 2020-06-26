{ addresses : List Text
, conditions :
    Optional
      ./io.k8s.api.discovery.v1beta1.EndpointConditions.dhall sha256:014defe4c7f2af6ea43a33481f748fc54c90c587fbc3c964b010dd8daabc0409
, hostname : Optional Text
, targetRef :
    Optional
      ./io.k8s.api.core.v1.ObjectReference.dhall sha256:301e65c686131086591aa0b6dd2617527427de49fcc87608a1f4b5f23fcb596c
, topology : Optional (List { mapKey : Text, mapValue : Text })
}
