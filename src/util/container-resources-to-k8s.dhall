let List/null = https://prelude.dhall-lang.org/v17.0.0/List/null

let Util/KeyValuePair = ./key-value-pair.dhall

let Kubernetes/ResourceRequirements =
      ../deps/k8s/types/io.k8s.api.core.v1.ResourceRequirements.dhall

let Resources = ../configuration/container-resources.dhall

let Configuration = Resources.Configuration

let configurationToK8s
    : Configuration.Type → Optional (List { mapKey : Text, mapValue : Text })
    = λ(c : Configuration.Type) →
        let memoryItem =
              merge
                { Some = λ(x : Text) → [ { mapKey = "memory", mapValue = x } ]
                , None = [] : List Util/KeyValuePair
                }
                c.memory

        let cpuItem =
              merge
                { Some = λ(x : Text) → [ { mapKey = "cpu", mapValue = x } ]
                , None = [] : List Util/KeyValuePair
                }
                c.cpu

        let ephemeralStorage =
              merge
                { Some =
                    λ(x : Text) →
                      [ { mapKey = "ephemeral-storage", mapValue = x } ]
                , None = [] : List Util/KeyValuePair
                }
                c.ephemeralStorage

        let all = memoryItem # cpuItem # ephemeralStorage

        in  if    List/null Util/KeyValuePair all
            then  None (List Util/KeyValuePair)
            else  Some all

let tok8s
    : Resources.Type → Kubernetes/ResourceRequirements
    = λ(r : Resources.Type) →
        let result =
              { limits = configurationToK8s r.limits
              , requests = configurationToK8s r.requests
              }

        in  result

in  tok8s
