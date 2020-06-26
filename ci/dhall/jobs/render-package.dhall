let GitHubActions = (../imports.dhall).GitHubActions

let Setup = ../setup.dhall

let SetupSteps = Setup.SetupSteps

let Job = Setup.Job

in  Job::{
    , name = Some "render-package"
    , steps =
          SetupSteps
        # [ GitHubActions.Step::{
            , name = Some
                "Check that deploy-sourcegraph-dhall compiles without any errors"
            , run = Some "ci/render-package.sh"
            }
          ]
    }
