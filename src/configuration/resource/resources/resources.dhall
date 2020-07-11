let Configuration = ./configuration.dhall

let resources =
      { Type = { limits : Configuration.Type, requests : Configuration.Type }
      , default =
        { limits = Configuration.default, requests = Configuration.default }
      }

in  resources
