let List/null = https://prelude.dhall-lang.org/v17.0.0/List/null

let Kubernetes/ResourceRequirements =
      ../../../deps/k8s/types/io.k8s.api.core.v1.ResourceRequirements.dhall

let Configuration = ./configuration.dhall

let Resources = ./resources.dhall

let configurationTransform
    : Configuration.Type → Optional (List { mapKey : Text, mapValue : Text })
    = λ(c : Configuration.Type) →
        let memoryItem =
              merge
                { Some = λ(x : Text) → [ { mapKey = "memory", mapValue = x } ]
                , None = [] : List { mapKey : Text, mapValue : Text }
                }
                c.memory

        let cpuItem =
              merge
                { Some = λ(x : Text) → [ { mapKey = "cpu", mapValue = x } ]
                , None = [] : List { mapKey : Text, mapValue : Text }
                }
                c.cpu

        let ephemeralStorage =
              merge
                { Some =
                    λ(x : Text) →
                      [ { mapKey = "ephemeral-storage", mapValue = x } ]
                , None = [] : List { mapKey : Text, mapValue : Text }
                }
                c.ephemeralStorage

        let all = memoryItem # cpuItem # ephemeralStorage

        in  if    List/null { mapKey : Text, mapValue : Text } all
            then  None (List { mapKey : Text, mapValue : Text })
            else  Some all

let transform
    : Resources.Type → Kubernetes/ResourceRequirements
    = λ(r : Resources.Type) →
        let result =
              { limits = configurationTransform r.limits
              , requests = configurationTransform r.requests
              }

        in  result

in  transform
