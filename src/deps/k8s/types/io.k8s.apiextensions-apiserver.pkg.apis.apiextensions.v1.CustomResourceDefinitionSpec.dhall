{ group : Text
, names :
    ./io.k8s.apiextensions-apiserver.pkg.apis.apiextensions.v1.CustomResourceDefinitionNames.dhall sha256:bab59ab8c7f548b01b94ffad596ba65c72bd773a3258f9bd0126396fd26308f2
, scope : Text
, versions :
    List
      ./io.k8s.apiextensions-apiserver.pkg.apis.apiextensions.v1.CustomResourceDefinitionVersion.dhall sha256:f0ce72ca1b52f9ea5114689498c8a55c6bb7040d4c11b893ce9bddbe0a4db692
, conversion :
    Optional
      ./io.k8s.apiextensions-apiserver.pkg.apis.apiextensions.v1.CustomResourceConversion.dhall sha256:6c5ee3c680fbd520434ac5d304ed0f49f5a86b0e0e8b875412d7cf59cc14f6b1
, preserveUnknownFields : Optional Bool
}
