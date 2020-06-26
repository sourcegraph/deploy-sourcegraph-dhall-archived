{ gateway : Text
, secretRef :
    ./io.k8s.api.core.v1.LocalObjectReference.dhall sha256:30bd7e61dae821a9532f640611a37bbebac3dc2ba02b82298a5c295280f1501f
, system : Text
, fsType : Optional Text
, protectionDomain : Optional Text
, readOnly : Optional Bool
, sslEnabled : Optional Bool
, storageMode : Optional Text
, storagePool : Optional Text
, volumeName : Optional Text
}
