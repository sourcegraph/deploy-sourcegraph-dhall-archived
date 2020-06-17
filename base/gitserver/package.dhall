let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let StatefulSet/render = ./gitserver.Statefulset.dhall

let Service/render = ./gitserver.Service.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let render =
        ( λ(c : Configuration/global.Type) →
            { StatefulSet = StatefulSet/render c, Service = Service/render c }
        )
      : ∀(c : Configuration/global.Type) → component

let toList =
        ( λ(c : component) →
            Kubernetes/List::{
            , items =
              [ Kubernetes/TypesUnion.StatefulSet c.StatefulSet
              , Kubernetes/TypesUnion.Service c.Service
              ]
            }
        )
      : ∀(c : component) → Kubernetes/List.Type

in  { Render = render, ToList = toList }
