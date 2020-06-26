{ apiVersion : Text
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, subsets :
    Optional
      ( List
          ./io.k8s.api.core.v1.EndpointSubset.dhall sha256:9b53f7fbe032d98c67f7b2ab21559cb688c7de367233e8482d4a4944a1463156
      )
}
