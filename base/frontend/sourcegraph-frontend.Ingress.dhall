let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Kubernetes/Ingress =
      ../../deps/k8s/schemas/io.k8s.api.extensions.v1beta1.Ingress.dhall

let Kubernetes/IngressSpec =
      ../../deps/k8s/schemas/io.k8s.api.extensions.v1beta1.IngressSpec.dhall

let Kubernetes/IngressRule =
      ../../deps/k8s/schemas/io.k8s.api.extensions.v1beta1.IngressRule.dhall

let Kubernetes/HTTPIngressRuleValue =
      ../../deps/k8s/schemas/io.k8s.api.extensions.v1beta1.HTTPIngressRuleValue.dhall

let Kubernetes/HTTPIngressPath =
      ../../deps/k8s/schemas/io.k8s.api.extensions.v1beta1.HTTPIngressPath.dhall

let Kubernetes/IntOrString =
      ../../deps/k8s/types/io.k8s.apimachinery.pkg.util.intstr.IntOrString.dhall

let Kubernetes/ObjectMeta =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall

let Configuration/global = ../../configuration/global.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let render =
      λ(c : Configuration/global.Type) →
        let overrides = c.Frontend.Ingress

        let additionalAnnotations =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalAnnotations

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalLabels

        let ingress =
              Kubernetes/Ingress::{
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some
                    (   [ { mapKey = "Kubernetes/io/ingress.class"
                          , mapValue = "nginx"
                          }
                        , { mapKey =
                              "nginx.ingress.Kubernetes/io/proxy-body-size"
                          , mapValue = "150m"
                          }
                        ]
                      # additionalAnnotations
                    )
                , labels = Some
                    (   [ { mapKey = "app", mapValue = "sourcegraph-frontend" }
                        , { mapKey = "deploy", mapValue = "sourcegraph" }
                        , { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "no-cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "sourcegraph-frontend"
                }
              , spec = Some Kubernetes/IngressSpec::{
                , rules = Some
                  [ Kubernetes/IngressRule::{
                    , http = Some Kubernetes/HTTPIngressRuleValue::{
                      , paths =
                        [ Kubernetes/HTTPIngressPath::{
                          , backend =
                            { serviceName = "sourcegraph-frontend"
                            , servicePort = Kubernetes/IntOrString.Int 30080
                            }
                          , path = Some "/"
                          }
                        ]
                      }
                    }
                  ]
                }
              }

        in  ingress

in  render
