{ port :
    ./io.k8s.apimachinery.pkg.util.intstr.IntOrString.dhall sha256:04a91539533a52bf0bf114690cceee43b656915bd83c2731ce26ad31f516d47f
, host : Optional Text
, httpHeaders :
    Optional
      ( List
          ./io.k8s.api.core.v1.HTTPHeader.dhall sha256:b8c3c0c4ceb36ba4e6674df5de20ad1d97e120b93b9ce9914a41d0036770dcc4
      )
, path : Optional Text
, scheme : Optional Text
}
