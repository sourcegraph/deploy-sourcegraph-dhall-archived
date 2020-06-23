let Base/toList = ./src/base/package.dhall

let Configuration/global = ./src/configuration/global.dhall

in  { Configuration = Configuration/global, ToList = Base/toList }
