let GitHubActions = (../imports.dhall).GitHubActions

let Setup = ../setup.dhall

let SetupSteps = Setup.SetupSteps

let Job = Setup.Job

in  Job::{
    , name = Some "shfmt"
    , steps =
          SetupSteps
        # [ GitHubActions.Step::{
            , name = Some "Check that scripts are formatted consistently"
            , run = Some "scripts/ci/shfmt.sh"
            }
          ]
    }
