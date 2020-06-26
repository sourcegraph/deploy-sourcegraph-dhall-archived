let GitHubActions = (../imports.dhall).GitHubActions

let Setup = ../setup.dhall

let SetupSteps = Setup.SetupSteps

let Job = Setup.Job

in  Job::{
    , name = Some "dhall-lint"
    , steps =
          SetupSteps
        # [ GitHubActions.Step::{
            , name = Some "Check that dhall files are linted properly"
            , run = Some "scripts/lint.sh"
            , env = Some (toMap { CHECK = "true" })
            }
          ]
    }
