let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Kubernetes/ObjectMeta =
      ../../deps/k8s/schemas/io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall

let Kubernetes/PersistentVolumeClaim =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PersistentVolumeClaim.dhall

let Kubernetes/PersistentVolumeClaimSpec =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.PersistentVolumeClaimSpec.dhall

let Kubernetes/ResourceRequirements =
      ../../deps/k8s/schemas/io.k8s.api.core.v1.ResourceRequirements.dhall

let Configuration/global = ../../configuration/global.dhall

let Util/KeyValuePair = ../../util/key-value-pair.dhall

let render =
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

in  render
