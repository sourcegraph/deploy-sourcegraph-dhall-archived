let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Kubernetes/ConfigMap =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ConfigMap.dhall

let Kubernetes/ConfigMapVolumeSource =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ConfigMapVolumeSource.dhall

let Kubernetes/Container =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.Container.dhall

let Kubernetes/ContainerPort =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ContainerPort.dhall

let Kubernetes/Deployment =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.Deployment.dhall

let Kubernetes/DeploymentSpec =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.DeploymentSpec.dhall

let Kubernetes/DeploymentStrategy =
      ../../deps/k8s/schemas/io.k8s.api.apps.v1.DeploymentStrategy.dhall

let Kubernetes/EnvVar = ../../deps/k8s/schemas/io.k8s.api.core.v1.EnvVar.dhall

let Kubernetes/IntOrString =
      ../../deps/k8s/types/io.k8s.apimachinery.pkg.util.intstr.IntOrString.dhall

let Kubernetes/LabelSelector =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall

let Kubernetes/ObjectMeta =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall

let Kubernetes/PersistentVolumeClaim =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PersistentVolumeClaim.dhall

let Kubernetes/PersistentVolumeClaimSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PersistentVolumeClaimSpec.dhall

let Kubernetes/PodSecurityContext =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PodSecurityContext.dhall

let Kubernetes/PodSpec = ../../deps/k8s/schemas/io.k8s.api.core.v1.PodSpec.dhall

let Kubernetes/PodTemplateSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PodTemplateSpec.dhall

let Kubernetes/Probe = ../../deps/k8s/schemas/io.k8s.api.core.v1.Probe.dhall

let Kubernetes/ResourceRequirements =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ResourceRequirements.dhall

let Kubernetes/SecurityContext =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.SecurityContext.dhall

let Kubernetes/Service = ../../deps/k8s/schemas/io.k8s.api.core.v1.Service.dhall

let Kubernetes/ServicePort =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServicePort.dhall

let Kubernetes/ServiceSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ServiceSpec.dhall

let Kubernetes/Volume = ../../deps/k8s/schemas/io.k8s.api.core.v1.Volume.dhall

let Kubernetes/VolumeMount =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.VolumeMount.dhall

let Configuration/global = ../../configuration/global.dhall

let Util/DeploySourcegraphLabel = ../../util/deploy-sourcegraph-label.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let component = ./component.dhall

let ConfigMap/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Postgres.ConfigMap

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

        let configMap =
              Kubernetes/ConfigMap::{
              , data = Some
                [ { mapKey = "postgresql.conf"
                  , mapValue = ./postgresql.conf as Text
                  }
                ]
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some
                    (   [ { mapKey = "description"
                          , mapValue = "Configuration for PostgreSQL"
                          }
                        ]
                      # additionalAnnotations
                    )
                , labels = Some
                    (   Util/DeploySourcegraphLabel
                      # [ { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "no-cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = overrides.namespace
                , name = Some "pgsql-conf"
                }
              }

        in  configMap

let postgresContainer/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Postgres.Deployment.Containers.Postgres

        let environment = overrides.additionalEnvironmentVariables

        let image =
              Optional/default
                Text
                "index.docker.io/sourcegraph/postgres-11.4:3.16.1@sha256:63090799b34b3115a387d96fe2227a37999d432b774a1d9b7966b8c5d81b56ad"
                overrides.image

        let resources =
              Optional/default
                Kubernetes/ResourceRequirements.Type
                { limits = Some
                  [ { mapKey = "cpu", mapValue = "4" }
                  , { mapKey = "memory", mapValue = "2Gi" }
                  ]
                , requests = Some
                  [ { mapKey = "cpu", mapValue = "4" }
                  , { mapKey = "memory", mapValue = "2Gi" }
                  ]
                }
                overrides.resources

        let container =
              Kubernetes/Container::{
              , image = Some image
              , livenessProbe = Some Kubernetes/Probe::{
                , exec = Some { command = Some [ "/liveness.sh" ] }
                , initialDelaySeconds = Some 15
                }
              , name = "pgsql"
              , ports = Some
                [ Kubernetes/ContainerPort::{
                  , containerPort = 5432
                  , name = Some "pgsql"
                  }
                ]
              , readinessProbe = Some Kubernetes/Probe::{
                , exec = Some { command = Some [ "/ready.sh" ] }
                }
              , env = environment
              , resources = Some resources
              , terminationMessagePolicy = Some "FallbackToLogsOnError"
              , volumeMounts = Some
                [ Kubernetes/VolumeMount::{ mountPath = "/data", name = "disk" }
                , Kubernetes/VolumeMount::{
                  , mountPath = "/conf"
                  , name = "pgsql-conf"
                  }
                ]
              }

        in  container

let postgresExporterContainer/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Postgres.Deployment.Containers.PostgresExporter

        let additionalEnvironmentVariables =
              Optional/default
                (List Kubernetes/EnvVar.Type)
                ([] : List Kubernetes/EnvVar.Type)
                overrides.additionalEnvironmentVariables

        let environment =
                [ Kubernetes/EnvVar::{
                  , name = "DATA_SOURCE_NAME"
                  , value = Some
                      "postgres://sg:@localhost:5432/?sslmode=disable"
                  }
                ]
              # additionalEnvironmentVariables

        let image =
              Optional/default
                Text
                "wrouesnel/postgres_exporter:v0.7.0@sha256:785c919627c06f540d515aac88b7966f352403f73e931e70dc2cbf783146a98b"
                overrides.image

        let resources =
              Optional/default
                Kubernetes/ResourceRequirements.Type
                { limits = Some
                  [ { mapKey = "cpu", mapValue = "10m" }
                  , { mapKey = "memory", mapValue = "50Mi" }
                  ]
                , requests = Some
                  [ { mapKey = "cpu", mapValue = "10m" }
                  , { mapKey = "memory", mapValue = "50Mi" }
                  ]
                }
                overrides.resources

        let container =
              Kubernetes/Container::{
              , env = Some environment
              , image = Some image
              , name = "pgsql-exporter"
              , resources = Some resources
              , terminationMessagePolicy = Some "FallbackToLogsOnError"
              }

        in  container

let initContainer/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Postgres.Deployment.Containers.Init

        let environment = overrides.additionalEnvironmentVariables

        let image =
              Optional/default
                Text
                "sourcegraph/alpine:3.10@sha256:4d05cd5669726fc38823e92320659a6d1ef7879e62268adec5df658a0bacf65c"
                overrides.image

        let resources = overrides.resources

        let container =
              Kubernetes/Container::{
              , command = Some
                [ "sh"
                , "-c"
                , "if [ -d /data/pgdata-11 ]; then chmod 750 /data/pgdata-11; fi"
                ]
              , env = environment
              , image = Some image
              , name = "correct-data-dir-permissions"
              , securityContext = Some Kubernetes/SecurityContext::{
                , runAsUser = Some 0
                }
              , resources
              , volumeMounts = Some
                [ Kubernetes/VolumeMount::{ mountPath = "/data", name = "disk" }
                ]
              }

        in  container

let Deployment/generate =
      λ(c : Configuration/global.Type) →
        let additionalAnnotations =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                c.Postgres.Deployment.additionalAnnotations

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                c.Postgres.Deployment.additionalLabels

        let postgresContainer = postgresContainer/generate c

        let postgresExporterContainer = postgresExporterContainer/generate c

        let initContainer = initContainer/generate c

        let deployment =
              Kubernetes/Deployment::{
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some
                    (   [ { mapKey = "description"
                          , mapValue = "Postgres database for various data."
                          }
                        ]
                      # additionalAnnotations
                    )
                , labels = Some
                    (   Util/DeploySourcegraphLabel
                      # [ { mapKey = "sourcegraph-resource-requires"
                          , mapValue = "no-cluster-admin"
                          }
                        ]
                      # additionalLabels
                    )
                , namespace = c.Postgres.Deployment.namespace
                , name = Some "pgsql"
                }
              , spec = Some Kubernetes/DeploymentSpec::{
                , minReadySeconds = Some 10
                , replicas = Some 1
                , revisionHistoryLimit = Some 10
                , selector = Kubernetes/LabelSelector::{
                  , matchLabels = Some
                    [ { mapKey = "app", mapValue = "pgsql" } ]
                  }
                , strategy = Some Kubernetes/DeploymentStrategy::{
                  , type = Some "Recreate"
                  }
                , template = Kubernetes/PodTemplateSpec::{
                  , metadata = Kubernetes/ObjectMeta::{
                    , labels = Some
                      [ { mapKey = "app", mapValue = "pgsql" }
                      , { mapKey = "deploy", mapValue = "sourcegraph" }
                      , { mapKey = "group", mapValue = "backend" }
                      ]
                    }
                  , spec = Some Kubernetes/PodSpec::{
                    , containers =
                      [ postgresContainer, postgresExporterContainer ]
                    , initContainers = Some [ initContainer ]
                    , securityContext = Some Kubernetes/PodSecurityContext::{
                      , runAsUser = Some 0
                      }
                    , volumes = Some
                      [ Kubernetes/Volume::{
                        , name = "disk"
                        , persistentVolumeClaim = Some
                          { claimName = "pgsql", readOnly = None Bool }
                        }
                      , Kubernetes/Volume::{
                        , configMap = Some Kubernetes/ConfigMapVolumeSource::{
                          , defaultMode = Some 777
                          , name = Some "pgsql-conf"
                          }
                        , name = "pgsql-conf"
                        }
                      ]
                    }
                  }
                }
              }

        in  deployment

let PersistentVolumeClaim/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Postgres.PersistentVolumeClaim

        let annotations = overrides.additionalAnnotations

        let additionalLabels =
              Optional/default
                (List Util/KeyValuePair)
                ([] : List Util/KeyValuePair)
                overrides.additionalLabels

        let labels =
                toMap
                  { sourcegraph-resource-requires = "no-cluster-admin"
                  , deploy = "sourcegraph"
                  }
              # additionalLabels

        let persistentVolumeClaim =
              Kubernetes/PersistentVolumeClaim::{
              , apiVersion = "v1"
              , kind = "PersistentVolumeClaim"
              , metadata = Kubernetes/ObjectMeta::{
                , annotations
                , labels = Some labels
                , namespace = overrides.namespace
                , name = Some "pgsql"
                }
              , spec = Some Kubernetes/PersistentVolumeClaimSpec::{
                , accessModes = Some [ "ReadWriteOnce" ]
                , resources = Some Kubernetes/ResourceRequirements::{
                  , requests = Some (toMap { storage = "200Gi" })
                  }
                , storageClassName = Some "sourcegraph"
                }
              }

        in  persistentVolumeClaim

let Service/generate =
      λ(c : Configuration/global.Type) →
        let overrides = c.Postgres.Service

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

        let annotations =
                toMap
                  { `sourcegraph.prometheus/scrape` = "true"
                  , `prometheus.io/port` = "9187"
                  }
              # additionalAnnotations

        let labels =
                toMap
                  { sourcegraph-resource-requires = "no-cluster-admin"
                  , deploy = "sourcegraph"
                  }
              # additionalLabels

        let service =
              Kubernetes/Service::{
              , apiVersion = "v1"
              , kind = "Service"
              , metadata = Kubernetes/ObjectMeta::{
                , annotations = Some annotations
                , labels = Some labels
                , namespace = overrides.namespace
                , name = Some "pgsql"
                }
              , spec = Some Kubernetes/ServiceSpec::{
                , ports = Some
                  [ Kubernetes/ServicePort::{
                    , name = Some "pgsql"
                    , port = 5432
                    , targetPort = Some (Kubernetes/IntOrString.String "pgsql")
                    }
                  ]
                , selector = Some (toMap { app = "pgsql" })
                , type = Some "ClusterIP"
                }
              }

        in  service

let Generate =
        ( λ(c : Configuration/global.Type) →
            { Deployment = Deployment/generate c
            , Service = Service/generate c
            , PersistentVolumeClaim = PersistentVolumeClaim/generate c
            , ConfigMap = ConfigMap/generate c
            }
        )
      : ∀(c : Configuration/global.Type) → component

in  Generate
