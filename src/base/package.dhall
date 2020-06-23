let List/concatMap =
      https://prelude.dhall-lang.org/v17.0.0/List/concatMap sha256:3b2167061d11fda1e4f6de0522cbe83e0d5ac4ef5ddf6bb0b2064470c5d3fb64

let Kubernetes/List = ../util/kubernetes-list.dhall

let Kubernetes/TypesUnion = ../deps/k8s/typesUnion.dhall

let Postgres/Render = ./postgres/package.dhall

let Frontend/Render = ./frontend/package.dhall

let Gitserver/Render = ./gitserver/package.dhall

let IndexedSearch/Render = ./indexed-search/package.dhall

let Symbols/Render = ./symbols/package.dhall

let Jaeger/Render = ./jaeger/package.dhall

let SyntaxHighlighter/Render = ./syntax-highlighter/package.dhall

let Searcher/Render = ./searcher/package.dhall

let RepoUpdater/Render = ./repo-updater/package.dhall

let GithubProxy/Render = ./github-proxy/package.dhall

let Cadvisor/Render = ./cadvisor/package.dhall

let Grafana/Render = ./grafana/package.dhall

let Configure/global = ../configuration/global.dhall

let toList =
      λ(c : Configure/global.Type) →
        let allResourceLists =
              [ Postgres/Render c
              , Gitserver/Render c
              , Frontend/Render c
              , IndexedSearch/Render c
              , Symbols/Render c
              , Jaeger/Render c
              , SyntaxHighlighter/Render c
              , Searcher/Render c
              , RepoUpdater/Render c
              , GithubProxy/Render c
              , Cadvisor/Render c
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
