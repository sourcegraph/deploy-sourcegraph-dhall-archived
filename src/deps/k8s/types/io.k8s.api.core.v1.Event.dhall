{ apiVersion : Text
, involvedObject :
    ./io.k8s.api.core.v1.ObjectReference.dhall sha256:301e65c686131086591aa0b6dd2617527427de49fcc87608a1f4b5f23fcb596c
, kind : Text
, metadata :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta.dhall sha256:f9bd9acb6fbfb26b6484870f1d07fa85535bd6e55e790181e89dcc64d63e7bfe
, action : Optional Text
, count : Optional Natural
, eventTime :
    Optional
      ./io.k8s.apimachinery.pkg.apis.meta.v1.MicroTime.dhall sha256:b9c75dfe7b1571f8b606d709a1103d67f86f16e04e63aa0de9856cd00904d4a2
, firstTimestamp :
    Optional
      ./io.k8s.apimachinery.pkg.apis.meta.v1.Time.dhall sha256:b9c75dfe7b1571f8b606d709a1103d67f86f16e04e63aa0de9856cd00904d4a2
, lastTimestamp :
    Optional
      ./io.k8s.apimachinery.pkg.apis.meta.v1.Time.dhall sha256:b9c75dfe7b1571f8b606d709a1103d67f86f16e04e63aa0de9856cd00904d4a2
, message : Optional Text
, reason : Optional Text
, related :
    Optional
      ./io.k8s.api.core.v1.ObjectReference.dhall sha256:301e65c686131086591aa0b6dd2617527427de49fcc87608a1f4b5f23fcb596c
, reportingComponent : Optional Text
, reportingInstance : Optional Text
, series :
    Optional
      ./io.k8s.api.core.v1.EventSeries.dhall sha256:01d9add81f56871966455aac7f54b889732380ddc245e9db4c2d85f17f0ef8a8
, source :
    Optional
      ./io.k8s.api.core.v1.EventSource.dhall sha256:7171ed731db8ce8602b50ab8c53574946d578bd10137e37fe01d6fb79dbdf143
, type : Optional Text
}
