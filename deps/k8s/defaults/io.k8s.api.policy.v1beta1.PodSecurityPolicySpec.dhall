{ allowPrivilegeEscalation = None Bool
, allowedCSIDrivers =
    None
      ( List
          ./../types/io.k8s.api.policy.v1beta1.AllowedCSIDriver.dhall sha256:c9078ba25443af62d7179d609dd2b291fad7c2bfb66fbb35b6c79b439ea269aa
      )
, allowedCapabilities = None (List Text)
, allowedFlexVolumes =
    None
      ( List
          ./../types/io.k8s.api.policy.v1beta1.AllowedFlexVolume.dhall sha256:caa2b98af766703b8f5fecce47f6efa498b7dd14d49a0323a90b2f82c22b63c3
      )
, allowedHostPaths =
    None
      ( List
          ./../types/io.k8s.api.policy.v1beta1.AllowedHostPath.dhall sha256:a53af202dd09fd0759372039d2023cf82e34e3fa702d3a7e8eb8151b740af877
      )
, allowedProcMountTypes = None (List Text)
, allowedUnsafeSysctls = None (List Text)
, defaultAddCapabilities = None (List Text)
, defaultAllowPrivilegeEscalation = None Bool
, forbiddenSysctls = None (List Text)
, hostIPC = None Bool
, hostNetwork = None Bool
, hostPID = None Bool
, hostPorts =
    None
      ( List
          ./../types/io.k8s.api.policy.v1beta1.HostPortRange.dhall sha256:179073df1d50b91df18d6ef21e42af1e3f8bbf4479495c7d2eb057a987e79a32
      )
, privileged = None Bool
, readOnlyRootFilesystem = None Bool
, requiredDropCapabilities = None (List Text)
, runAsGroup =
    None
      ./../types/io.k8s.api.policy.v1beta1.RunAsGroupStrategyOptions.dhall sha256:05309183af586715c3b04251ff3e8fd483c4bf168972b25197f132bf1c7e4395
, runtimeClass =
    None
      ./../types/io.k8s.api.policy.v1beta1.RuntimeClassStrategyOptions.dhall sha256:84e3fb0c0fbdc37bbb410a74bf5fa4ab3e42843ccf5f4aedd1df361e55abdae6
, volumes = None (List Text)
}
