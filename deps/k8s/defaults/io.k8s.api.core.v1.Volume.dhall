{ awsElasticBlockStore =
    None
      ./../types/io.k8s.api.core.v1.AWSElasticBlockStoreVolumeSource.dhall sha256:fadc3f391adf37625bbb9c99a1a5ab56a9e1ed7466caf6aa9086ff23446e933b
, azureDisk =
    None
      ./../types/io.k8s.api.core.v1.AzureDiskVolumeSource.dhall sha256:31cc060ed13975431b6430b3151d25cd014f6dd5a04ebdfb819ebe55ddd346b4
, azureFile =
    None
      ./../types/io.k8s.api.core.v1.AzureFileVolumeSource.dhall sha256:724a33a261976d751c7800bb019395bc1dc0c2d4c332e4efc2f88c442b056d3d
, cephfs =
    None
      ./../types/io.k8s.api.core.v1.CephFSVolumeSource.dhall sha256:2f9a10d7c93b7d10c742e0f10798dc8ae261f60600fdfa31dad2fdbb94d695d4
, cinder =
    None
      ./../types/io.k8s.api.core.v1.CinderVolumeSource.dhall sha256:dce52c5faed6a7d575bc5f9ed7990d8f2ccac962c817ac8d1ce9264bc7084835
, configMap =
    None
      ./../types/io.k8s.api.core.v1.ConfigMapVolumeSource.dhall sha256:ca17a0474608f919001f642901c11d3e60324a4245879c0bf540eca0ed22357d
, csi =
    None
      ./../types/io.k8s.api.core.v1.CSIVolumeSource.dhall sha256:ea2b6f4f0c57878ea1e05f239df124c6bf56990db080216a4e45cc31a9bef890
, downwardAPI =
    None
      ./../types/io.k8s.api.core.v1.DownwardAPIVolumeSource.dhall sha256:fc9c281a4dd41484f742cf9aba616a15e7be1742ec05ba5b90ef2fce6c78df53
, emptyDir =
    None
      ./../types/io.k8s.api.core.v1.EmptyDirVolumeSource.dhall sha256:46361385b85996dc46983a9c78d87ecc2e592ce4fc2f3df0bcc6f621bdd9d43d
, fc =
    None
      ./../types/io.k8s.api.core.v1.FCVolumeSource.dhall sha256:65b87f0356c47f5ff45ebefda4964c91b02ada5e4c6ab4628b430656601510fd
, flexVolume =
    None
      ./../types/io.k8s.api.core.v1.FlexVolumeSource.dhall sha256:3a8e0362114f613982511a62961a90e770ec164fe64c9dcacff9e82950881fc9
, flocker =
    None
      ./../types/io.k8s.api.core.v1.FlockerVolumeSource.dhall sha256:eca720c21b58ee5c4493939e2dde0144d9d8f7169d4e3e98f3df5b181e3f3fde
, gcePersistentDisk =
    None
      ./../types/io.k8s.api.core.v1.GCEPersistentDiskVolumeSource.dhall sha256:94a2182f57e588addf8319a3360303ee37a2d65fef7b0b922d6a9caad709bd2a
, gitRepo =
    None
      ./../types/io.k8s.api.core.v1.GitRepoVolumeSource.dhall sha256:eb92aad636e2a57b000294a67f9bae219ea8db3bb63a389041d4c005da48ae8e
, glusterfs =
    None
      ./../types/io.k8s.api.core.v1.GlusterfsVolumeSource.dhall sha256:1436b3d8c0b9d5d832cfaf22d06c8c2cf09238e39a08a418ebe41c07ed7e87c6
, hostPath =
    None
      ./../types/io.k8s.api.core.v1.HostPathVolumeSource.dhall sha256:2cf8e0999c951ba311fa708e1a563f4dbb710772de58485e2e839a499698fa16
, iscsi =
    None
      ./../types/io.k8s.api.core.v1.ISCSIVolumeSource.dhall sha256:c97368d2f80d33cd17e0aaff1bb74cd67279f1df91e2d96065fd52dc52e550ef
, nfs =
    None
      ./../types/io.k8s.api.core.v1.NFSVolumeSource.dhall sha256:3dcf0038a371a4bb310aac92b7560a427d662f11a5b5d879bbf76962af3d8cac
, persistentVolumeClaim =
    None
      ./../types/io.k8s.api.core.v1.PersistentVolumeClaimVolumeSource.dhall sha256:75dacb0ac46271e23d219cb37e8a215033a5f8dfa4acfa30196caa561348853a
, photonPersistentDisk =
    None
      ./../types/io.k8s.api.core.v1.PhotonPersistentDiskVolumeSource.dhall sha256:4786a2549b98aca430620201a7cee2c505470a70bd1722a7019a4aa163e07ec7
, portworxVolume =
    None
      ./../types/io.k8s.api.core.v1.PortworxVolumeSource.dhall sha256:6c20c2018deb04b8276fbbb6bde16225beca3e2d4d40120729a3c854ae9a8483
, projected =
    None
      ./../types/io.k8s.api.core.v1.ProjectedVolumeSource.dhall sha256:266ae1679620c829f7dc8d846b05e1873e93119b96dd4ce100d2d199f180a4b6
, quobyte =
    None
      ./../types/io.k8s.api.core.v1.QuobyteVolumeSource.dhall sha256:cffd560bc5ba397c90959b6a804cc11b9df45f245c148d23fb434b763a4bb8d8
, rbd =
    None
      ./../types/io.k8s.api.core.v1.RBDVolumeSource.dhall sha256:a3c3dbc95b50cb4e5438e48b4e583cf8cbec5f6b3daf694335f1b1b1b0f80972
, scaleIO =
    None
      ./../types/io.k8s.api.core.v1.ScaleIOVolumeSource.dhall sha256:16d55a4871714458cfc2ece52c852d4edbda6c14fdadd258bd76b96b4083dd57
, secret =
    None
      ./../types/io.k8s.api.core.v1.SecretVolumeSource.dhall sha256:e6c0e211be14b9d7339669546a704b14dfdf27fb0985921ee3378ac014db0831
, storageos =
    None
      ./../types/io.k8s.api.core.v1.StorageOSVolumeSource.dhall sha256:9b18f601ba5896751c8ac1e1b928919697136c1a0d30e19394c43a3051ea169b
, vsphereVolume =
    None
      ./../types/io.k8s.api.core.v1.VsphereVirtualDiskVolumeSource.dhall sha256:4dff124d7400ab0495931fee2209a82c36f1819cb40a44994f97604affc67fde
}
