{ addressType : Text
, apiVersion : Text
, endpoints :
    List
      ./io.k8s.api.discovery.v1beta1.Endpoint.dhall sha256:e360c41d25b8ac8b26d8f5ce9c14a1ef1d320df5313d4abe4f20d9addfe5500d
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, ports :
    Optional
      ( List
          ./io.k8s.api.discovery.v1beta1.EndpointPort.dhall sha256:c05797a8573fb4d82d3eb6ced9c089d11c4bb1b4d3143ee765377bd9bca2d93e
      )
}
