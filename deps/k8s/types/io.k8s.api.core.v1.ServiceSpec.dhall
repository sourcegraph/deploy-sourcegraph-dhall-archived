{ clusterIP : Optional Text
, externalIPs : Optional (List Text)
, externalName : Optional Text
, externalTrafficPolicy : Optional Text
, healthCheckNodePort : Optional Natural
, ipFamily : Optional Text
, loadBalancerIP : Optional Text
, loadBalancerSourceRanges : Optional (List Text)
, ports :
    Optional
      ( List
          ./io.k8s.api.core.v1.ServicePort.dhall sha256:23194d9324caff379b686f72e9d7926cf24f6c7f5d287bc97d2b33a90e2a93cf
      )
, publishNotReadyAddresses : Optional Bool
, selector : Optional (List { mapKey : Text, mapValue : Text })
, sessionAffinity : Optional Text
, sessionAffinityConfig :
    Optional
      ./io.k8s.api.core.v1.SessionAffinityConfig.dhall sha256:c9b776ed8cdbdad776859caac8975294ea0fb4b5e4595ad302824fb432a7f630
, topologyKeys : Optional (List Text)
, type : Optional Text
}
