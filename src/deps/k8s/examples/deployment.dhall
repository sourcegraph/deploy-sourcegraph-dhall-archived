let kubernetes =
      ../package.dhall sha256:7150ac4309a091740321a3a3582e7695ee4b81732ce8f1ed1691c1c52791daa1

let deployment =
      kubernetes.Deployment::{
      , metadata = kubernetes.ObjectMeta::{ name = Some "nginx" }
      , spec = Some kubernetes.DeploymentSpec::{
        , replicas = Some 2
        , revisionHistoryLimit = Some 10
        , selector = kubernetes.LabelSelector::{
          , matchLabels = Some (toMap { app = "nginx" })
          }
        , strategy = Some kubernetes.DeploymentStrategy::{
          , type = Some "RollingUpdate"
          , rollingUpdate = Some
            { maxSurge = Some (kubernetes.IntOrString.Int 5)
            , maxUnavailable = Some (kubernetes.IntOrString.Int 0)
            }
          }
        , template = kubernetes.PodTemplateSpec::{
          , metadata = kubernetes.ObjectMeta::{
            , name = Some "nginx"
            , labels = Some (toMap { app = "nginx" })
            }
          , spec = Some kubernetes.PodSpec::{
            , containers =
              [ kubernetes.Container::{
                , name = "nginx"
                , image = Some "nginx:1.15.3"
                , imagePullPolicy = Some "Always"
                , ports = Some
                  [ kubernetes.ContainerPort::{ containerPort = 80 } ]
                , resources = Some
                  { limits = Some (toMap { cpu = "500m" })
                  , requests = Some (toMap { cpu = "10m" })
                  }
                }
              ]
            }
          }
        }
      }

in  deployment
