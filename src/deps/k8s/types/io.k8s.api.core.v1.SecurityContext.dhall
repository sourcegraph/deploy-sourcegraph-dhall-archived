{ allowPrivilegeEscalation : Optional Bool
, capabilities :
    Optional
      ./io.k8s.api.core.v1.Capabilities.dhall sha256:6b42501a688551a1d480b2d006eb968b827874c0807764062d10529ab2f24d66
, privileged : Optional Bool
, procMount : Optional Text
, readOnlyRootFilesystem : Optional Bool
, runAsGroup : Optional Natural
, runAsNonRoot : Optional Bool
, runAsUser : Optional Natural
, seLinuxOptions :
    Optional
      ./io.k8s.api.core.v1.SELinuxOptions.dhall sha256:0d7767ca8fb43a84f1301ecce981d48f09d6d8891ef56f5342709e79e2b62064
, windowsOptions :
    Optional
      ./io.k8s.api.core.v1.WindowsSecurityContextOptions.dhall sha256:66cf1d4d7ca34b6481d9501c84f26fda8a01e58b1d09ab32c686902de830c408
}
