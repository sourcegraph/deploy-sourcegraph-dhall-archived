let Generate = ./src/base/generate.dhall

let Configuration/global = ./src/configuration/global.dhall

in  Generate Configuration/global::{=}
