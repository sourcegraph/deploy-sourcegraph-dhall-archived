let Sourcegraph =
      ./package.dhall sha256:95adf775bb998031ba0c3ff2318386b0eb92a1350b646734d4dcee4a95420dff

let Render = Sourcegraph.Render

let c = Sourcegraph.Configuration::{=}

in  Render c
