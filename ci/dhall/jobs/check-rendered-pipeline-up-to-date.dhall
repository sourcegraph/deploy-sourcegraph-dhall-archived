let GitHubActions = (../imports.dhall).GitHubActions

let Setup = ../setup.dhall

let SetupSteps = Setup.SetupSteps

let Job = Setup.Job

in  Job::{
    , name = Some "Rendered CI pipeline is up to date"
    , steps =
          SetupSteps
        # [ GitHubActions.Step::{
            , name = Some
                "Check that the CI pipeline definition is up-to-date with the dhall configuration"
            , run = Some "scripts/ci/check-rendered-pipeline-up-to-date.sh"
            }
          ]
    }
