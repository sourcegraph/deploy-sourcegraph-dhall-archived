{ activeDeadlineSeconds = None Natural
, affinity =
    None
      ./../types/io.k8s.api.core.v1.Affinity.dhall sha256:6221fdff507444ae05790364baa0be18eca18f7a8ba826672c66702a5d12e256
, automountServiceAccountToken = None Bool
, dnsConfig =
    None
      ./../types/io.k8s.api.core.v1.PodDNSConfig.dhall sha256:20fbee72ae47d13233a8bc75a5e701f9cb1ba6fbc60ce66378fab02c38f3a05b
, dnsPolicy = None Text
, enableServiceLinks = None Bool
, ephemeralContainers =
    None
      ( List
          ./../types/io.k8s.api.core.v1.EphemeralContainer.dhall sha256:57ef688a24eeb5308aa87b4b3ab3d9a8881afe8748bc8709f232a44f717002cc
      )
, hostAliases =
    None
      ( List
          ./../types/io.k8s.api.core.v1.HostAlias.dhall sha256:c7383b6bdc4212f9b4e47a91944e529a10bdfe8334143944e32bc56c4ccc2e0f
      )
, hostIPC = None Bool
, hostNetwork = None Bool
, hostPID = None Bool
, hostname = None Text
, imagePullSecrets =
    None
      ( List
          ./../types/io.k8s.api.core.v1.LocalObjectReference.dhall sha256:30bd7e61dae821a9532f640611a37bbebac3dc2ba02b82298a5c295280f1501f
      )
, initContainers =
    None
      ( List
          ./../types/io.k8s.api.core.v1.Container.dhall sha256:7874f01efcb5957c49e0e310ede6cf28130ee345f71d14192be78010c526c6b5
      )
, nodeName = None Text
, nodeSelector = None (List { mapKey : Text, mapValue : Text })
, overhead = None (List { mapKey : Text, mapValue : Text })
, preemptionPolicy = None Text
, priority = None Natural
, priorityClassName = None Text
, readinessGates =
    None
      ( List
          ./../types/io.k8s.api.core.v1.PodReadinessGate.dhall sha256:3acaaaae3422906803d0be01f596cf0db6de147d1585268c9e976e30f4250486
      )
, restartPolicy = None Text
, runtimeClassName = None Text
, schedulerName = None Text
, securityContext =
    None
      ./../types/io.k8s.api.core.v1.PodSecurityContext.dhall sha256:266714c96d31957e667882df9886f055d7be546c7296177636acbb291f4556ac
, serviceAccount = None Text
, serviceAccountName = None Text
, shareProcessNamespace = None Bool
, subdomain = None Text
, terminationGracePeriodSeconds = None Natural
, tolerations =
    None
      ( List
          ./../types/io.k8s.api.core.v1.Toleration.dhall sha256:311a6571242358d7b210631d506dc09e89671c2012bee5799c05f0a2c0024d71
      )
, topologySpreadConstraints =
    None
      ( List
          ./../types/io.k8s.api.core.v1.TopologySpreadConstraint.dhall sha256:68376067f0827ac83fc77b3efeb8800aed0b0358703e39b9962976ec7eb07419
      )
, volumes =
    None
      ( List
          ./../types/io.k8s.api.core.v1.Volume.dhall sha256:534bc08f5a965b6f4283150bec676c7eebbb18f5953c21a827dc1097aa1c0178
      )
}
