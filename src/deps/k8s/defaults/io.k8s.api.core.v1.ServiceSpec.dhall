{ clusterIP = None Text
, externalIPs = None (List Text)
, externalName = None Text
, externalTrafficPolicy = None Text
, healthCheckNodePort = None Natural
, ipFamily = None Text
, loadBalancerIP = None Text
, loadBalancerSourceRanges = None (List Text)
, ports =
    None
      ( List
          ./../types/io.k8s.api.core.v1.ServicePort.dhall sha256:23194d9324caff379b686f72e9d7926cf24f6c7f5d287bc97d2b33a90e2a93cf
      )
, publishNotReadyAddresses = None Bool
, selector = None (List { mapKey : Text, mapValue : Text })
, sessionAffinity = None Text
, sessionAffinityConfig =
    None
      ./../types/io.k8s.api.core.v1.SessionAffinityConfig.dhall sha256:c9b776ed8cdbdad776859caac8975294ea0fb4b5e4595ad302824fb432a7f630
, topologyKeys = None (List Text)
, type = None Text
}
