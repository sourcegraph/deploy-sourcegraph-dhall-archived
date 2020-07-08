let Sourcegraph =
      ./package.dhall sha256:46bc5e0bacf209d52ab01b0a94b26c0343e7471dbdf1db66ad8af115ed76ffc6

let Render = Sourcegraph.Render

let c = Sourcegraph.Configuration::{=}

in  Render c
