let Frontend/configuration = ../base/frontend/configuration.dhall

let Gitserver/configuration = ../base/gitserver/configuration.dhall

let Postgres/configuration = ../base/postgres/configuration.dhall

let IndexedSearch/configuration = ../base/indexed-search/configuration.dhall

let Symbols/configuration = ../base/symbols/configuration.dhall

let Jaeger/configuration = ../base/jaeger/configuration.dhall

let SyntaxHighlighter/configuration =
      ../base/syntax-highlighter/configuration.dhall

let Searcher/configuration = ../base/syntax-highlighter/configuration.dhall

let RepoUpdater/configuration = ../base/repo-updater/configuration.dhall

let Cadvisor/configuration = ../base/cadvisor/configuration.dhall

let configuration =
      { Type =
          { Frontend : Frontend/configuration.Type
          , Gitserver : Gitserver/configuration.Type
          , Postgres : Postgres/configuration.Type
          , IndexedSearch : IndexedSearch/configuration.Type
          , Symbols : Symbols/configuration.Type
          , Jaeger : Jaeger/configuration.Type
          , SyntaxHighlighter : SyntaxHighlighter/configuration.Type
          , Searcher : Searcher/configuration.Type
          , RepoUpdater : RepoUpdater/configuration.Type
          , Cadvisor : Cadvisor/configuration.Type
          }
      , default =
        { Frontend = Frontend/configuration.default
        , Gitserver = Gitserver/configuration.default
        , Postgres = Postgres/configuration.default
        , IndexedSearch = IndexedSearch/configuration.default
        , Symbols = Symbols/configuration.default
        , Jaeger = Jaeger/configuration.default
        , SyntaxHighlighter = SyntaxHighlighter/configuration.default
        , Searcher = Searcher/configuration.default
        , RepoUpdater = RepoUpdater/configuration.default
        , Cadvisor = Cadvisor/configuration.default
        }
      }

in  configuration
