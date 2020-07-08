let Base/render = ./src/base/render.dhall

let Configuration/global = ./src/configuration/global.dhall

in  { Configuration = Configuration/global, Render = Base/render }
