let Kubernetes/TypesUnion = ../deps/k8s/typesUnion.dhall

in  { Type =
          { apiVersion : Text, kind : Text, items : List Kubernetes/TypesUnion }
        : Type
    , default =
      { apiVersion = "v1"
      , kind = "List"
      , items = [] : List Kubernetes/TypesUnion
      }
    }
