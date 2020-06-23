{ annotations = None (List { mapKey : Text, mapValue : Text })
, clusterName = None Text
, creationTimestamp =
    None
      ./../types/io.k8s.apimachinery.pkg.apis.meta.v1.Time.dhall sha256:b9c75dfe7b1571f8b606d709a1103d67f86f16e04e63aa0de9856cd00904d4a2
, deletionGracePeriodSeconds = None Natural
, deletionTimestamp =
    None
      ./../types/io.k8s.apimachinery.pkg.apis.meta.v1.Time.dhall sha256:b9c75dfe7b1571f8b606d709a1103d67f86f16e04e63aa0de9856cd00904d4a2
, finalizers = None (List Text)
, generateName = None Text
, generation = None Natural
, labels = None (List { mapKey : Text, mapValue : Text })
, managedFields =
    None
      ( List
          ./../types/io.k8s.apimachinery.pkg.apis.meta.v1.ManagedFieldsEntry.dhall sha256:fa7bb7fd50692df5fa4f6aa689b2fdf4b9cbbbd6dcdd44cd59860fdf729e6ad5
      )
, name = None Text
, namespace = None Text
, ownerReferences =
    None
      ( List
          ./../types/io.k8s.apimachinery.pkg.apis.meta.v1.OwnerReference.dhall sha256:839b14d1d8b9fde26a7af1ae095b66f8844e1b150d7cae51ed68bf4b3e267fc8
      )
, resourceVersion = None Text
, selfLink = None Text
, uid = None Text
}
