let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let Generate = ./generate.dhall

let shape = ./shape.dhall

let ToList =
        ( λ(c : component) →
            let items =
                  merge
                    { Some =
                        λ(pgsql : shape) →
                          [ Kubernetes/TypesUnion.Deployment pgsql.Deployment
                          , Kubernetes/TypesUnion.Service pgsql.Service
                          , Kubernetes/TypesUnion.PersistentVolumeClaim
                              pgsql.PersistentVolumeClaim
                          , Kubernetes/TypesUnion.ConfigMap pgsql.ConfigMap
                          ]
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
