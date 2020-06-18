{ iqn : Text
, lun : Natural
, targetPortal : Text
, chapAuthDiscovery : Optional Bool
, chapAuthSession : Optional Bool
, fsType : Optional Text
, initiatorName : Optional Text
, iscsiInterface : Optional Text
, portals : Optional (List Text)
, readOnly : Optional Bool
, secretRef :
    Optional
      ./io.k8s.api.core.v1.SecretReference.dhall sha256:aac2bf127e8931850f04d76f4a3a0eb7deec3b4af46f018d4cd6560167e630df
}
