{ configSource =
    None
      ./../types/io.k8s.api.core.v1.NodeConfigSource.dhall sha256:82ccdb5f057d1aea079e1cbd50f3d08e25dfb5546c6c92569aecca8ce909ceca
, externalID = None Text
, podCIDR = None Text
, podCIDRs = None (List Text)
, providerID = None Text
, taints =
    None
      ( List
          ./../types/io.k8s.api.core.v1.Taint.dhall sha256:9acf25f6b6dfcc3fec40a88e6c9c01f511c4f30ada42992b2a63dfd3010598e8
      )
, unschedulable = None Bool
}
