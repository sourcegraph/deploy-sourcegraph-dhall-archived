{ exec :
    Optional
      ./io.k8s.api.core.v1.ExecAction.dhall sha256:396f4b2d0f31f3358a31fee0939537d689c98b599e7c3b14e4df23a3476db259
, failureThreshold : Optional Natural
, httpGet :
    Optional
      ./io.k8s.api.core.v1.HTTPGetAction.dhall sha256:caa7c037aa58c694d6af00731d57e90a8950c2cf7325be8a969be858fc89924f
, initialDelaySeconds : Optional Natural
, periodSeconds : Optional Natural
, successThreshold : Optional Natural
, tcpSocket :
    Optional
      ./io.k8s.api.core.v1.TCPSocketAction.dhall sha256:c97ec77fe8d5a5b2811a6c8e9dfefaf0d6d1693a171c82cb3cedbccfca72280e
, timeoutSeconds : Optional Natural
}
