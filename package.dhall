let Base = ./src/base/package.dhall

let Configuration/global = ./src/configuration/global.dhall

in  { Configuration = Configuration/global
    , Render = Base.Render
    , Generate = Base.Generate
    }
