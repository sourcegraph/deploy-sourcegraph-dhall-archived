let Sourcegraph = ./package.dhall

let ToList = Sourcegraph.ToList

let c = Sourcegraph.Configuration::{=}

in  ToList c
