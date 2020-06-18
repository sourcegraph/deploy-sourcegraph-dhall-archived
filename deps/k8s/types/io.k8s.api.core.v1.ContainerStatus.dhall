{ image : Text
, imageID : Text
, name : Text
, ready : Bool
, restartCount : Natural
, containerID : Optional Text
, lastState :
    Optional
      ./io.k8s.api.core.v1.ContainerState.dhall sha256:d22de812fdde0077319a5be9825c70ce05a9149819b2513b77497dcdd70cfd62
, started : Optional Bool
, state :
    Optional
      ./io.k8s.api.core.v1.ContainerState.dhall sha256:d22de812fdde0077319a5be9825c70ce05a9149819b2513b77497dcdd70cfd62
}
