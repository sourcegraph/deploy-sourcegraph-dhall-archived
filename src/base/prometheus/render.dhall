let Kubernetes/List = ../../util/kubernetes-list.dhall

let Kubernetes/TypesUnion = ../../deps/k8s/typesUnion.dhall

let Configuration/global = ../../configuration/global.dhall

let component = ./component.dhall

let Generate = ./generate.dhall

let shape = ./shape.dhall

let ToList =
        ( λ(c : component) →
            let items =
                  merge
                    { Some =
                        λ(prom : shape) →
                          [ Kubernetes/TypesUnion.Deployment prom.Deployment
                          , Kubernetes/TypesUnion.ClusterRole prom.ClusterRole
                          , Kubernetes/TypesUnion.ConfigMap prom.ConfigMap
                          , Kubernetes/TypesUnion.PersistentVolumeClaim
                              prom.PersistentVolumeClaim
                          , Kubernetes/TypesUnion.ClusterRoleBinding
                              prom.ClusterRoleBinding
                          , Kubernetes/TypesUnion.ServiceAccount
                              prom.ServiceAccount
                          , Kubernetes/TypesUnion.Service prom.Service
                          ]
                    , None = [] : List Kubernetes/TypesUnion
                    }
                    c

            in  Kubernetes/List::{ items }
        )
      : ∀(c : component) → Kubernetes/List.Type

let Render =
        (λ(c : Configuration/global.Type) → ToList (Generate c))
      : ∀(c : Configuration/global.Type) → Kubernetes/List.Type

in  Render
