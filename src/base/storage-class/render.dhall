let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let Kubernetes/StorageClass =
      ../../deps/k8s/schemas/io.k8s.api.storage.v1.StorageClass.dhall

let Configuration/global = ../../configuration/global.dhall

let Generate = ./generate.dhall

let component = ./component.dhall

let ToList =
        ( λ(c : component) →
            let items =
                  merge
                    { Some =
                        λ(sc : Kubernetes/StorageClass.Type) →
                          [ Kubernetes/TypesUnion.StorageClass sc ]
                    , None = [] : List Kubernetes/TypesUnion
                    }
                    c

            in  Kubernetes/List::{ items }
        )
      : ∀(c : component) → Kubernetes/List.Type

let Render =
        (λ(c : Configuration/global.Type) → ToList (Generate c))
      : ∀(c : Configuration/global.Type) → Kubernetes/List.Type

in  Render
