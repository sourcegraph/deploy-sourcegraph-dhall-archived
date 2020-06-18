{ gateway : Text
, secretRef :
    ./io.k8s.api.core.v1.SecretReference.dhall sha256:aac2bf127e8931850f04d76f4a3a0eb7deec3b4af46f018d4cd6560167e630df
, system : Text
, fsType : Optional Text
, protectionDomain : Optional Text
, readOnly : Optional Bool
, sslEnabled : Optional Bool
, storageMode : Optional Text
, storagePool : Optional Text
, volumeName : Optional Text
}
