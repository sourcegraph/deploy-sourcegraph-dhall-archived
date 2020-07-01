let GitHubActions = (../imports.dhall).GitHubActions

let Setup = ../setup.dhall

let SetupSteps = Setup.SetupSteps

let Job = Setup.Job

in  Job::{
    , name = Some "typecheck-dhall-package"
    , steps =
          SetupSteps
        # [ GitHubActions.Step::{
            , name = Some
                "Check that deploy-sourcegraph-dhall typechecks without any errors"
            , run = Some "ci/typecheck-package.sh"
            }
          ]
    }
