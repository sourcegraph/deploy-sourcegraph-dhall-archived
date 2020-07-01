let GitHubActions = (../imports.dhall).GitHubActions

let Setup = ../setup.dhall

let SetupSteps = Setup.SetupSteps

let Job = Setup.Job

in  Job::{
    , name = Some "render-CI-pipeline"
    , steps =
          SetupSteps
        # [ GitHubActions.Step::{
            , name = Some
                "Check that the CI pipeline definition is up-to-date with the dhall configuration"
            , run = Some "ci/check-rendered-pipeline-up-to-date.sh"
            }
          ]
    }
