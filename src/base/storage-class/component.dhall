let Kubernetes/StorageClass =
      ../../deps/k8s/schemas/io.k8s.api.storage.v1.StorageClass.dhall

let component = Optional Kubernetes/StorageClass.Type

in  component
