let component = ./src/base/component.dhall

in    { Cadvisor = ./src/base/cadvisor/simple.dhall
      , Frontend = ./src/base/frontend/simple.dhall
      , GitHubProxy = ./src/base/github-proxy/simple.dhall
      , Gitserver = ./src/base/gitserver/simple.dhall
      , Grafana = ./src/base/grafana/simple.dhall
      , IndexedSearch = ./src/base/indexed-search/simple.dhall
      , Jaeger = ./src/base/jaeger/simple.dhall
      , Postgres = ./src/base/postgres/simple.dhall
      , PreciseCodeIntel = ./src/base/precise-code-intel/simple.dhall
      , Prometheus = ./src/base/prometheus/simple.dhall
      , QueryRunner = ./src/base/query-runner/simple.dhall
      , Redis = ./src/base/redis/simple.dhall
        , Replacer = ./src/base/replacer/simple.dhall
        , RepoUpdater = ./src/base/repo-updater/simple.dhall
        , Searcher = ./src/base/searcher/simple.dhall
      }
    : component
