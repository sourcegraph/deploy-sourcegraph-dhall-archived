let GitHubActions = (./imports.dhall).GitHubActions

let shellcheck = ./jobs/shellcheck.dhall

let shfmt = ./jobs/shfmt.dhall

let checkPipeline = ./jobs/check-rendered-pipeline-up-to-date.dhall

let dhallFormat = ./jobs/dhall-format.dhall

let dhallLint = ./jobs/dhall-lint.dhall

in  GitHubActions.Workflow::{
    , name = "CI"
    , on = GitHubActions.On::{
      , push = Some GitHubActions.Push::{ branches = Some [ "master" ] }
      , pull_request = Some GitHubActions.PullRequest::{=}
      }
    , jobs = toMap { shellcheck, shfmt, dhallFormat, dhallLint, checkPipeline }
    }
