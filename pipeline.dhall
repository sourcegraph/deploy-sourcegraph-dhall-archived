let Sourcegraph = ./package.dhall

let Render = Sourcegraph.Render

let c = Sourcegraph.Configuration::{=}

in  Render c
