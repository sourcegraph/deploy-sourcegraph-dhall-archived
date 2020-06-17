let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let ConfigMap/render = ./pgsql.ConfigMap.dhall

let Deployment/render = ./pgsql.Deployment.dhall

let PersistentVolumeClaim/render = ./pgsql.PersistentVolumeClaim.dhall

let Service/render = ./pgsql.Service.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let render =
        ( λ(c : Configuration/global.Type) →
            { Deployment = Deployment/render c
            , Service = Service/render c
            , PersistentVolumeClaim = PersistentVolumeClaim/render c
            , ConfigMap = ConfigMap/render c
            }
        )
      : ∀(c : Configuration/global.Type) → component

let toList =
        ( λ(c : component) →
            Kubernetes/List::{
            , items =
              [ Kubernetes/TypesUnion.Deployment c.Deployment
              , Kubernetes/TypesUnion.Service c.Service
              , Kubernetes/TypesUnion.PersistentVolumeClaim
                  c.PersistentVolumeClaim
              , Kubernetes/TypesUnion.ConfigMap c.ConfigMap
              ]
            }
        )
      : ∀(c : component) → Kubernetes/List.Type

in  { Render = render, ToList = toList }
