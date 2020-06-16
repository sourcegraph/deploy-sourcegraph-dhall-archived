let Frontend/configuration = ../base/frontend/configuration.dhall

let Gitserver/configuration = ../base/gitserver/configuration.dhall

let Postgres/configuration = ../base/postgres/configuration.dhall

let configuration =
      { Type =
          { Frontend : Frontend/configuration.Type
          , Gitserver : Gitserver/configuration.Type
          , Postgres : Postgres/configuration.Type
          }
      , default =
        { Frontend = Frontend/configuration.default
        , Gitserver = Gitserver/configuration.default
        , Postgres = Postgres/configuration.default
        }
      }

in  configuration
