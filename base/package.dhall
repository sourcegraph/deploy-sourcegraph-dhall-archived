let List/concatMap = (../imports.dhall).Prelude.List.concatMap

let Postgres/render = (./postgres/package.dhall).Render

let Postgres/toList = (./postgres/package.dhall).ToList

let Gitserver/render = (./gitserver/package.dhall).Render

let Gitserver/toList = (./gitserver/package.dhall).ToList

let Frontend/render = (./frontend/package.dhall).Render

let Frontend/toList = (./frontend/package.dhall).ToList

let Configure/global = ../configuration/global.dhall

let Kubernetes/list = (../util.dhall).kubernetesList

let Kubernetes/typeUnion = (../imports.dhall).KubernetesTypeUnion

let toList =
      λ(c : Configure/global.Type) →
        let allResourceLists =
              [ Postgres/toList (Postgres/render c)
              , Gitserver/toList (Gitserver/render c)
              , Frontend/toList (Frontend/render c)
              ]

        in  Kubernetes/list::{
            , items =
                List/concatMap
                  Kubernetes/list.Type
                  Kubernetes/typeUnion
                  (λ(x : Kubernetes/list.Type) → x.items)
                  allResourceLists
            }

in  toList
