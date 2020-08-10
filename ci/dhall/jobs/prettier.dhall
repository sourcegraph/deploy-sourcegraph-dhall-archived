let GitHubActions = (../imports.dhall).GitHubActions

let Setup = ../setup.dhall

let SetupSteps = Setup.SetupSteps

let Job = Setup.Job

in  Job::{
    , name = Some "Prettier formatting"
    , steps =
          SetupSteps
        # [ GitHubActions.Step::{
            , name = Some "Check Prettier formatting"
            , run = Some "ci/check-prettier.sh"
            }
          ]
    }
