let List/concatMap =
      https://prelude.dhall-lang.org/v17.0.0/List/concatMap sha256:3b2167061d11fda1e4f6de0522cbe83e0d5ac4ef5ddf6bb0b2064470c5d3fb64

let Kubernetes/List = ../util/kubernetes-list.dhall

let Kubernetes/TypesUnion = ../deps/k8s/typesUnion.dhall

let Postgres/render = (./postgres/package.dhall).Render

let Postgres/toList = (./postgres/package.dhall).ToList

let Gitserver/render = (./gitserver/package.dhall).Render

let Gitserver/toList = (./gitserver/package.dhall).ToList

let Frontend/render = (./frontend/package.dhall).Render

let Frontend/toList = (./frontend/package.dhall).ToList

let Configure/global = ../configuration/global.dhall

let toList =
      λ(c : Configure/global.Type) →
        let allResourceLists =
              [ Postgres/toList (Postgres/render c)
              , Gitserver/toList (Gitserver/render c)
              , Frontend/toList (Frontend/render c)
              ]

        in  Kubernetes/List::{
            , items =
                List/concatMap
                  Kubernetes/List.Type
                  Kubernetes/TypesUnion
                  (λ(x : Kubernetes/List.Type) → x.items)
                  allResourceLists
            }

in  toList
