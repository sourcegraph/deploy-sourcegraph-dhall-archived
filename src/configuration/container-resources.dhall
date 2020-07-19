let Configuration =
      { Type =
          { memory : Optional Text
          , cpu : Optional Text
          , ephemeralStorage : Optional Text
          }
      , default =
        { memory = None Text, cpu = None Text, ephemeralStorage = None Text }
      }

let overlayConfig
    : Configuration.Type → Configuration.Type → Configuration.Type
    = λ(base : Configuration.Type) →
      λ(overlay : Configuration.Type) →
        let overlayedMemory =
              merge
                { Some = λ(x : Text) → Some x, None = base.memory }
                overlay.memory

        let overlayedCPU =
              merge { Some = λ(x : Text) → Some x, None = base.cpu } overlay.cpu

        let overlayedEphemeralStorage =
              merge
                { Some = λ(x : Text) → Some x, None = base.ephemeralStorage }
                overlay.ephemeralStorage

        let result =
              { memory = overlayedMemory
              , cpu = overlayedCPU
              , ephemeralStorage = overlayedEphemeralStorage
              }

        in  result

let resources =
      { Type = { limits : Configuration.Type, requests : Configuration.Type }
      , default =
        { limits = Configuration.default, requests = Configuration.default }
      , Configuration
      , overlay = overlayConfig
      }

in  resources
