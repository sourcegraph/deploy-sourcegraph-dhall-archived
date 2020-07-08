let Frontend/Generate = ./frontend/generate.dhall

let Cadvisor/Generate = ./cadvisor/generate.dhall

let GithubProxy/Generate = ./github-proxy/generate.dhall

let Gitserver/Generate = ./gitserver/generate.dhall

let Grafana/Generate = ./grafana/generate.dhall

let IndexedSearch/Generate = ./indexed-search/generate.dhall

let Jaeger/Generate = ./jaeger/generate.dhall

let Postgres/Generate = ./postgres/generate.dhall

let PreciseCodeIntel/Generate = ./precise-code-intel/generate.dhall

let Prometheus/Generate = ./prometheus/generate.dhall

let QueryRunner/Generate = ./query-runner/generate.dhall

let Redis/Generate = ./redis/generate.dhall

let Replacer/Generate = ./replacer/generate.dhall

let RepoUpdater/Generate = ./repo-updater/generate.dhall

let Searcher/Generate = ./searcher/generate.dhall

let Symbols/Generate = ./symbols/generate.dhall

let SyntaxHighlighter/Generate = ./syntax-highlighter/generate.dhall

let component = ./component.dhall

let Configuration/global = ../configuration/global.dhall

let Generate =
        ( λ(c : Configuration/global.Type) →
            { Frontend = Frontend/Generate c
            , Cadvisor = Cadvisor/Generate c
            , GitHubProxy = GithubProxy/Generate c
            , Gitserver = Gitserver/Generate c
            , Grafana = Grafana/Generate c
            , IndexedSearch = IndexedSearch/Generate c
            , Jaeger = Jaeger/Generate c
            , Postgres = Postgres/Generate c
            , PreciseCodeIntel = PreciseCodeIntel/Generate c
            , Prometheus = Prometheus/Generate c
            , QueryRunner = QueryRunner/Generate c
            , Redis = Redis/Generate c
            , Replacer = Replacer/Generate c
            , RepoUpdater = RepoUpdater/Generate c
            , Searcher = Searcher/Generate c
            , Symbols = Symbols/Generate c
            , SyntaxHighlighter = SyntaxHighlighter/Generate c
            }
        )
      : ∀(c : Configuration/global.Type) → component

in  Generate
