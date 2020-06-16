let Base/toList = ./base/package.dhall

let Configuration/global = ./configuration/global.dhall

let c = Configuration/global::{=}

in  Base/toList c
