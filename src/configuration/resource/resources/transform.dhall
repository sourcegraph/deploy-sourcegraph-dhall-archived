let List/null = https://prelude.dhall-lang.org/v17.0.0/List/null

let Kubernetes/ResourceRequirements =
      ../../../deps/k8s/types/io.k8s.api.core.v1.ResourceRequirements.dhall

let Util/KeyValuePair = ../../../util/key-value-pair.dhall

let Configuration = ./configuration.dhall

let Resources = ./resources.dhall

let configurationTransform
    : Configuration.Type → Optional (List Util/KeyValuePair)
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

let transform
    : Resources.Type → Kubernetes/ResourceRequirements
    = λ(r : Resources.Type) →
        let result =
              { limits = configurationTransform r.limits
              , requests = configurationTransform r.requests
              }

        in  result

in  transform
