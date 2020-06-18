{ groupPriorityMinimum : Natural
, service :
    ./io.k8s.kube-aggregator.pkg.apis.apiregistration.v1.ServiceReference.dhall sha256:a6120fee8a715bb8007f527166643eb5df3f7e527270308c9895748d4ed8dea4
, versionPriority : Natural
, caBundle : Optional Text
, group : Optional Text
, insecureSkipTLSVerify : Optional Bool
, version : Optional Text
}
