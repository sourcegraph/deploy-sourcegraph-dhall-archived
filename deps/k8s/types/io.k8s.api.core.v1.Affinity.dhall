{ nodeAffinity :
    Optional
      ./io.k8s.api.core.v1.NodeAffinity.dhall sha256:53e856ab4e7f06d4cd0f076c75cd9065c2af8e0d720ac721f44d62b99d5f11a9
, podAffinity :
    Optional
      ./io.k8s.api.core.v1.PodAffinity.dhall sha256:820f3019e862a32dd7b9c222e21ccfeed1ad8da94441be7358be74ccf6be97f5
, podAntiAffinity :
    Optional
      ./io.k8s.api.core.v1.PodAntiAffinity.dhall sha256:820f3019e862a32dd7b9c222e21ccfeed1ad8da94441be7358be74ccf6be97f5
}
