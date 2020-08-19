let GitHubActions = (../imports.dhall).GitHubActions

let Setup = ../setup.dhall

let SetupSteps = Setup.SetupSteps

let Job = Setup.Job

in  Job::{
    , name = Some "dhall-diff"
    , steps =
          SetupSteps
        # [ GitHubActions.Step::{
            , name = Some "Performs a diff between the base and feature branch"
            , run = Some "ci/dhall-diff.sh"
            }
          ]
    }
