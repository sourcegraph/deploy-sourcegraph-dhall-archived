{ fsGroup :
    ./io.k8s.api.policy.v1beta1.FSGroupStrategyOptions.dhall sha256:5cb38e52d0922f8eafee891c8dbff68cc6a1ddfdc0e9c53bf7c420b6d2d2c5f3
, runAsUser :
    ./io.k8s.api.policy.v1beta1.RunAsUserStrategyOptions.dhall sha256:05309183af586715c3b04251ff3e8fd483c4bf168972b25197f132bf1c7e4395
, seLinux :
    ./io.k8s.api.policy.v1beta1.SELinuxStrategyOptions.dhall sha256:49de5b49055b57d456b69c6997d1e23a6ec7683d687190fd81b19b00674dc391
, supplementalGroups :
    ./io.k8s.api.policy.v1beta1.SupplementalGroupsStrategyOptions.dhall sha256:5cb38e52d0922f8eafee891c8dbff68cc6a1ddfdc0e9c53bf7c420b6d2d2c5f3
, allowPrivilegeEscalation : Optional Bool
, allowedCSIDrivers :
    Optional
      ( List
          ./io.k8s.api.policy.v1beta1.AllowedCSIDriver.dhall sha256:c9078ba25443af62d7179d609dd2b291fad7c2bfb66fbb35b6c79b439ea269aa
      )
, allowedCapabilities : Optional (List Text)
, allowedFlexVolumes :
    Optional
      ( List
          ./io.k8s.api.policy.v1beta1.AllowedFlexVolume.dhall sha256:caa2b98af766703b8f5fecce47f6efa498b7dd14d49a0323a90b2f82c22b63c3
      )
, allowedHostPaths :
    Optional
      ( List
          ./io.k8s.api.policy.v1beta1.AllowedHostPath.dhall sha256:a53af202dd09fd0759372039d2023cf82e34e3fa702d3a7e8eb8151b740af877
      )
, allowedProcMountTypes : Optional (List Text)
, allowedUnsafeSysctls : Optional (List Text)
, defaultAddCapabilities : Optional (List Text)
, defaultAllowPrivilegeEscalation : Optional Bool
, forbiddenSysctls : Optional (List Text)
, hostIPC : Optional Bool
, hostNetwork : Optional Bool
, hostPID : Optional Bool
, hostPorts :
    Optional
      ( List
          ./io.k8s.api.policy.v1beta1.HostPortRange.dhall sha256:179073df1d50b91df18d6ef21e42af1e3f8bbf4479495c7d2eb057a987e79a32
      )
, privileged : Optional Bool
, readOnlyRootFilesystem : Optional Bool
, requiredDropCapabilities : Optional (List Text)
, runAsGroup :
    Optional
      ./io.k8s.api.policy.v1beta1.RunAsGroupStrategyOptions.dhall sha256:05309183af586715c3b04251ff3e8fd483c4bf168972b25197f132bf1c7e4395
, runtimeClass :
    Optional
      ./io.k8s.api.policy.v1beta1.RuntimeClassStrategyOptions.dhall sha256:84e3fb0c0fbdc37bbb410a74bf5fa4ab3e42843ccf5f4aedd1df361e55abdae6
, volumes : Optional (List Text)
}
