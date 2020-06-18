{ containers :
    List
      ./io.k8s.api.core.v1.Container.dhall sha256:7874f01efcb5957c49e0e310ede6cf28130ee345f71d14192be78010c526c6b5
, activeDeadlineSeconds : Optional Natural
, affinity :
    Optional
      ./io.k8s.api.core.v1.Affinity.dhall sha256:6221fdff507444ae05790364baa0be18eca18f7a8ba826672c66702a5d12e256
, automountServiceAccountToken : Optional Bool
, dnsConfig :
    Optional
      ./io.k8s.api.core.v1.PodDNSConfig.dhall sha256:20fbee72ae47d13233a8bc75a5e701f9cb1ba6fbc60ce66378fab02c38f3a05b
, dnsPolicy : Optional Text
, enableServiceLinks : Optional Bool
, ephemeralContainers :
    Optional
      ( List
          ./io.k8s.api.core.v1.EphemeralContainer.dhall sha256:57ef688a24eeb5308aa87b4b3ab3d9a8881afe8748bc8709f232a44f717002cc
      )
, hostAliases :
    Optional
      ( List
          ./io.k8s.api.core.v1.HostAlias.dhall sha256:c7383b6bdc4212f9b4e47a91944e529a10bdfe8334143944e32bc56c4ccc2e0f
      )
, hostIPC : Optional Bool
, hostNetwork : Optional Bool
, hostPID : Optional Bool
, hostname : Optional Text
, imagePullSecrets :
    Optional
      ( List
          ./io.k8s.api.core.v1.LocalObjectReference.dhall sha256:30bd7e61dae821a9532f640611a37bbebac3dc2ba02b82298a5c295280f1501f
      )
, initContainers :
    Optional
      ( List
          ./io.k8s.api.core.v1.Container.dhall sha256:7874f01efcb5957c49e0e310ede6cf28130ee345f71d14192be78010c526c6b5
      )
, nodeName : Optional Text
, nodeSelector : Optional (List { mapKey : Text, mapValue : Text })
, overhead : Optional (List { mapKey : Text, mapValue : Text })
, preemptionPolicy : Optional Text
, priority : Optional Natural
, priorityClassName : Optional Text
, readinessGates :
    Optional
      ( List
          ./io.k8s.api.core.v1.PodReadinessGate.dhall sha256:3acaaaae3422906803d0be01f596cf0db6de147d1585268c9e976e30f4250486
      )
, restartPolicy : Optional Text
, runtimeClassName : Optional Text
, schedulerName : Optional Text
, securityContext :
    Optional
      ./io.k8s.api.core.v1.PodSecurityContext.dhall sha256:266714c96d31957e667882df9886f055d7be546c7296177636acbb291f4556ac
, serviceAccount : Optional Text
, serviceAccountName : Optional Text
, shareProcessNamespace : Optional Bool
, subdomain : Optional Text
, terminationGracePeriodSeconds : Optional Natural
, tolerations :
    Optional
      ( List
          ./io.k8s.api.core.v1.Toleration.dhall sha256:311a6571242358d7b210631d506dc09e89671c2012bee5799c05f0a2c0024d71
      )
, topologySpreadConstraints :
    Optional
      ( List
          ./io.k8s.api.core.v1.TopologySpreadConstraint.dhall sha256:68376067f0827ac83fc77b3efeb8800aed0b0358703e39b9962976ec7eb07419
      )
, volumes :
    Optional
      ( List
          ./io.k8s.api.core.v1.Volume.dhall sha256:534bc08f5a965b6f4283150bec676c7eebbb18f5953c21a827dc1097aa1c0178
      )
}
