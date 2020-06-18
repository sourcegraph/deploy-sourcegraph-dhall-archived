{ apiVersion : Text
, kind : Text
, dryRun : Optional (List Text)
, gracePeriodSeconds : Optional Natural
, orphanDependents : Optional Bool
, preconditions :
    Optional
      ./io.k8s.apimachinery.pkg.apis.meta.v1.Preconditions.dhall sha256:16093ffa5f70af2b58cadacfcb3d30bcb828d1c2df7b602b78b3ffcb0007100e
, propagationPolicy : Optional Text
}
