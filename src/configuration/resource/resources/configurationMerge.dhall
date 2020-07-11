let Configuration = ./configuration.dhall

let configurationMerge
    : Configuration.Type → Configuration.Type → Configuration.Type
    = λ(a : Configuration.Type) →
      λ(b : Configuration.Type) →
        let mergedMemory =
              merge { Some = λ(x : Text) → Some x, None = a.memory } b.memory

        let mergedCPU =
              merge { Some = λ(x : Text) → Some x, None = a.cpu } b.cpu

        let mergedEphemeralStorage =
              merge
                { Some = λ(x : Text) → Some x, None = a.ephemeralStorage }
                b.ephemeralStorage

        let result =
              { memory = mergedMemory
              , cpu = mergedCPU
              , ephemeralStorage = mergedEphemeralStorage
              }

        in  result

in  configurationMerge
