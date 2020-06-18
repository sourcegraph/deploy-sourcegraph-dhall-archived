{ fsGroup : Optional Natural
, runAsGroup : Optional Natural
, runAsNonRoot : Optional Bool
, runAsUser : Optional Natural
, seLinuxOptions :
    Optional
      ./io.k8s.api.core.v1.SELinuxOptions.dhall sha256:0d7767ca8fb43a84f1301ecce981d48f09d6d8891ef56f5342709e79e2b62064
, supplementalGroups : Optional (List Natural)
, sysctls :
    Optional
      ( List
          ./io.k8s.api.core.v1.Sysctl.dhall sha256:b8c3c0c4ceb36ba4e6674df5de20ad1d97e120b93b9ce9914a41d0036770dcc4
      )
, windowsOptions :
    Optional
      ./io.k8s.api.core.v1.WindowsSecurityContextOptions.dhall sha256:66cf1d4d7ca34b6481d9501c84f26fda8a01e58b1d09ab32c686902de830c408
}
