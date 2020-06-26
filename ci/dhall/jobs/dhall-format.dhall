let GitHubActions = (../imports.dhall).GitHubActions

let Setup = ../setup.dhall

let SetupSteps = Setup.SetupSteps

let Job = Setup.Job

in  Job::{
    , name = Some "dhall-format"
    , steps =
          SetupSteps
        # [ GitHubActions.Step::{
            , name = Some "Check that dhall files are formatted"
            , run = Some "scripts/format.sh"
            , env = Some (toMap { CHECK = "true" })
            }
          ]
    }
