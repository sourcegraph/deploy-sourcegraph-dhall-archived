let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let Deployment/render = ./sourcegraph-frontend.Deployment.dhall

let Ingress/render = ./sourcegraph-frontend.Ingress.dhall

let Role/render = ./sourcegraph-frontend.Role.dhall

let RoleBinding/render = ./sourcegraph-frontend.RoleBinding.dhall

let Service/render = ./sourcegraph-frontend.Service.dhall

let ServiceAccount/render = ./sourcegraph-frontend.ServiceAccount.dhall

let ServiceInternal/render = ./sourcegraph-frontend-internal.Service.dhall

let component = ./component.dhall

let Configuration/global = ../../configuration/global.dhall

let render =
        ( λ(c : Configuration/global.Type) →
            { Deployment = Deployment/render c
            , Ingress = Ingress/render c
            , Role = Role/render c
            , RoleBinding = RoleBinding/render c
            , Service = Service/render c
            , ServiceAccount = ServiceAccount/render c
            , ServiceInternal = ServiceInternal/render c
            }
        )
      : ∀(c : Configuration/global.Type) → component

let toList =
        ( λ(c : component) →
            Kubernetes/List::{
            , items =
              [ Kubernetes/TypesUnion.Deployment c.Deployment
              , Kubernetes/TypesUnion.Ingress c.Ingress
              , Kubernetes/TypesUnion.Role c.Role
              , Kubernetes/TypesUnion.RoleBinding c.RoleBinding
              , Kubernetes/TypesUnion.Service c.Service
              , Kubernetes/TypesUnion.ServiceAccount c.ServiceAccount
              , Kubernetes/TypesUnion.Service c.ServiceInternal
              ]
            }
        )
      : ∀(c : component) → Kubernetes/List.Type

in  { Render = render, ToList = toList }
