let Frontend/Component = ./frontend/component.dhall

let Cadvisor/Component = ./cadvisor/component.dhall

let GithubProxy/Component = ./github-proxy/component.dhall

let Gitserver/Component = ./gitserver/component.dhall

let Grafana/Component = ./grafana/component.dhall

let IndexedSearch/Component = ./indexed-search/component.dhall

let Jaeger/Component = ./jaeger/component.dhall

let Postgres/Component = ./postgres/component.dhall

let PreciseCodeIntel/Component = ./precise-code-intel/component.dhall

let Prometheus/Component = ./prometheus/component.dhall

let QueryRunner/Component = ./query-runner/component.dhall

let Redis/Component = ./redis/component.dhall

let Replacer/Component = ./replacer/component.dhall

let RepoUpdater/Component = ./repo-updater/component.dhall

let Searcher/Component = ./searcher/component.dhall

let Symbols/Component = ./symbols/component.dhall

let SyntaxHighlighter/Component = ./syntax-highlighter/component.dhall

let component =
      { Frontend : Frontend/Component
      , Cadvisor : Cadvisor/Component
      , GitHubProxy : GithubProxy/Component
      , GitServer : Gitserver/Component
      , Grafana : Grafana/Component
      , IndexedSearch : IndexedSearch/Component
      , Jaeger : Jaeger/Component
      , Postgres : Postgres/Component
      , PreciseCodeIntel : PreciseCodeIntel/Component
      , Prometheus : Prometheus/Component
      , QueryRunner : QueryRunner/Component
      , Redis : Redis/Component
      , RepoUpdater : RepoUpdater/Component
      , Replacer : Replacer/Component
      , Searcher : Searcher/Component
      , Symbols : Symbols/Component
      , SyntaxHighlighter : SyntaxHighlighter/Component
      }

in  component
