let Configuration/global = ../../configuration/global.dhall

let Generate = (./package.dhall).Generate

in  Generate Configuration/global::{=}
