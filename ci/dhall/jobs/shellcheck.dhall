let GitHubActions = (../imports.dhall).GitHubActions

let Setup = ../setup.dhall

let SetupSteps = Setup.SetupSteps

let Job = Setup.Job

in  Job::{
    , name = Some "shellcheck"
    , steps =
          SetupSteps
        # [ GitHubActions.Step::{
            , name = Some "Lint shell scripts"
            , run = Some "scripts/ci/shellcheck.sh"
            }
          ]
    }
