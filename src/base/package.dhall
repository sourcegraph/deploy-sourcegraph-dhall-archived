let List/concatMap =
      https://prelude.dhall-lang.org/v17.0.0/List/concatMap sha256:3b2167061d11fda1e4f6de0522cbe83e0d5ac4ef5ddf6bb0b2064470c5d3fb64

let Kubernetes/List = ../util/kubernetes-list.dhall

let Kubernetes/TypesUnion = ../deps/k8s/typesUnion.dhall

let Postgres = ./postgres/package.dhall

let Frontend = ./frontend/package.dhall

let Gitserver = ./gitserver/package.dhall

let IndexedSearch = ./indexed-search/package.dhall

let Symbols = ./symbols/package.dhall

let Jaeger = ./jaeger/package.dhall

let SyntaxHighlighter = ./syntax-highlighter/package.dhall

let Searcher = ./searcher/package.dhall

let RepoUpdater = ./repo-updater/package.dhall

let GithubProxy = ./github-proxy/package.dhall

let Cadvisor = ./cadvisor/package.dhall

let PreciseCodeIntel = ./precise-code-intel/package.dhall

let Redis = ./redis/package.dhall

let Replacer = ./replacer/package.dhall

let QueryRunner = ./query-runner/package.dhall

let Prometheus = ./prometheus/package.dhall

let Configure/global = ../configuration/global.dhall

let toList =
      λ(c : Configure/global.Type) →
        let allResourceLists =
              [ Postgres.Render c
              , Gitserver.Render c
              , Frontend.Render c
              , IndexedSearch.Render c
              , Symbols.Render c
              , Jaeger.Render c
              , SyntaxHighlighter.Render c
              , Searcher.Render c
              , RepoUpdater.Render c
              , GithubProxy.Render c
              , Cadvisor.Render c
              , PreciseCodeIntel.Render c
              , Redis.Render c
              , Replacer.Render c
              , QueryRunner.Render c
              , Prometheus.Render c
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
