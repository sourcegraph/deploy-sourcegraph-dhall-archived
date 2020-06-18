{ accessModes : Optional (List Text)
, awsElasticBlockStore :
    Optional
      ./io.k8s.api.core.v1.AWSElasticBlockStoreVolumeSource.dhall sha256:fadc3f391adf37625bbb9c99a1a5ab56a9e1ed7466caf6aa9086ff23446e933b
, azureDisk :
    Optional
      ./io.k8s.api.core.v1.AzureDiskVolumeSource.dhall sha256:31cc060ed13975431b6430b3151d25cd014f6dd5a04ebdfb819ebe55ddd346b4
, azureFile :
    Optional
      ./io.k8s.api.core.v1.AzureFilePersistentVolumeSource.dhall sha256:6bb0c0fa4ba7dc961613e8d3494359685c41735e247072af333d710641b0e2f6
, capacity : Optional (List { mapKey : Text, mapValue : Text })
, cephfs :
    Optional
      ./io.k8s.api.core.v1.CephFSPersistentVolumeSource.dhall sha256:e1cc5ceaa09aee882c782436d427ea41f77736f8474904728aba34fe934f9505
, cinder :
    Optional
      ./io.k8s.api.core.v1.CinderPersistentVolumeSource.dhall sha256:e5ad580edcf2e27d3c7b1a8387185b5a1ebca7c78264a2e9f78d23a3e2b324d0
, claimRef :
    Optional
      ./io.k8s.api.core.v1.ObjectReference.dhall sha256:301e65c686131086591aa0b6dd2617527427de49fcc87608a1f4b5f23fcb596c
, csi :
    Optional
      ./io.k8s.api.core.v1.CSIPersistentVolumeSource.dhall sha256:d5957623218fe9f1f7085e551ccac8652f2a331b093eaae5584bac5a9d375a9b
, fc :
    Optional
      ./io.k8s.api.core.v1.FCVolumeSource.dhall sha256:65b87f0356c47f5ff45ebefda4964c91b02ada5e4c6ab4628b430656601510fd
, flexVolume :
    Optional
      ./io.k8s.api.core.v1.FlexPersistentVolumeSource.dhall sha256:bcc8ab4e80cd9282874273c23eaf7f009e63c7d1770fe67e0db7553fa3afef48
, flocker :
    Optional
      ./io.k8s.api.core.v1.FlockerVolumeSource.dhall sha256:eca720c21b58ee5c4493939e2dde0144d9d8f7169d4e3e98f3df5b181e3f3fde
, gcePersistentDisk :
    Optional
      ./io.k8s.api.core.v1.GCEPersistentDiskVolumeSource.dhall sha256:94a2182f57e588addf8319a3360303ee37a2d65fef7b0b922d6a9caad709bd2a
, glusterfs :
    Optional
      ./io.k8s.api.core.v1.GlusterfsPersistentVolumeSource.dhall sha256:a8d225c035bf0d29a8aef3904f0ddd10bed3922b9e0650e49f5814e62b9db5bc
, hostPath :
    Optional
      ./io.k8s.api.core.v1.HostPathVolumeSource.dhall sha256:2cf8e0999c951ba311fa708e1a563f4dbb710772de58485e2e839a499698fa16
, iscsi :
    Optional
      ./io.k8s.api.core.v1.ISCSIPersistentVolumeSource.dhall sha256:cd43070448ec39477f28d9e5de2c4e9b15977f0e00bb2bd7b20712a2c83ea25d
, local :
    Optional
      ./io.k8s.api.core.v1.LocalVolumeSource.dhall sha256:28dce32602ff1be8ef6ffa6d7371909f40fb3dde2ad1cfcbd020c7568cf7f565
, mountOptions : Optional (List Text)
, nfs :
    Optional
      ./io.k8s.api.core.v1.NFSVolumeSource.dhall sha256:3dcf0038a371a4bb310aac92b7560a427d662f11a5b5d879bbf76962af3d8cac
, nodeAffinity :
    Optional
      ./io.k8s.api.core.v1.VolumeNodeAffinity.dhall sha256:d5f5796d6ac40b32b32382223b6a6a828bf6145cddfe8c32d4535a10392e8311
, persistentVolumeReclaimPolicy : Optional Text
, photonPersistentDisk :
    Optional
      ./io.k8s.api.core.v1.PhotonPersistentDiskVolumeSource.dhall sha256:4786a2549b98aca430620201a7cee2c505470a70bd1722a7019a4aa163e07ec7
, portworxVolume :
    Optional
      ./io.k8s.api.core.v1.PortworxVolumeSource.dhall sha256:6c20c2018deb04b8276fbbb6bde16225beca3e2d4d40120729a3c854ae9a8483
, quobyte :
    Optional
      ./io.k8s.api.core.v1.QuobyteVolumeSource.dhall sha256:cffd560bc5ba397c90959b6a804cc11b9df45f245c148d23fb434b763a4bb8d8
, rbd :
    Optional
      ./io.k8s.api.core.v1.RBDPersistentVolumeSource.dhall sha256:2d08c1167ac4b0d551ecf7bbd15914e3c81abdaabe18e4369e57ae5774760306
, scaleIO :
    Optional
      ./io.k8s.api.core.v1.ScaleIOPersistentVolumeSource.dhall sha256:7f56e32de51f78a2ea1efc005993d92ff622a589a9d416eec84e021f9081bf93
, storageClassName : Optional Text
, storageos :
    Optional
      ./io.k8s.api.core.v1.StorageOSPersistentVolumeSource.dhall sha256:b9809cff9cdf97b2ec9eb2671b68b2b47727008f8b6cf58652c7cc8da1611532
, volumeMode : Optional Text
, vsphereVolume :
    Optional
      ./io.k8s.api.core.v1.VsphereVirtualDiskVolumeSource.dhall sha256:4dff124d7400ab0495931fee2209a82c36f1819cb40a44994f97604affc67fde
}
