{ `$ref` : Optional Text
, `$schema` : Optional Text
, default :
    Optional
      ./io.k8s.apiextensions-apiserver.pkg.apis.apiextensions.v1.JSON.dhall sha256:0912602a19e01dcff30f351958d2d9b69519c9be61b57b1b32a2a569bf8bf5f9
, definitions : Optional (List { mapKey : Text, mapValue : Text })
, dependencies : Optional (List { mapKey : Text, mapValue : Text })
, description : Optional Text
, enum :
    Optional
      ( List
          ./io.k8s.apiextensions-apiserver.pkg.apis.apiextensions.v1.JSON.dhall sha256:0912602a19e01dcff30f351958d2d9b69519c9be61b57b1b32a2a569bf8bf5f9
      )
, example :
    Optional
      ./io.k8s.apiextensions-apiserver.pkg.apis.apiextensions.v1.JSON.dhall sha256:0912602a19e01dcff30f351958d2d9b69519c9be61b57b1b32a2a569bf8bf5f9
, exclusiveMaximum : Optional Bool
, exclusiveMinimum : Optional Bool
, externalDocs :
    Optional
      ./io.k8s.apiextensions-apiserver.pkg.apis.apiextensions.v1.ExternalDocumentation.dhall sha256:75a79c871f43a432b402f8a5d52f277bb827f5170ecfed101ed356a91ccbce91
, format : Optional Text
, id : Optional Text
, maxItems : Optional Natural
, maxLength : Optional Natural
, maxProperties : Optional Natural
, maximum : Optional Double
, minItems : Optional Natural
, minLength : Optional Natural
, minProperties : Optional Natural
, minimum : Optional Double
, multipleOf : Optional Double
, nullable : Optional Bool
, pattern : Optional Text
, patternProperties : Optional (List { mapKey : Text, mapValue : Text })
, properties : Optional (List { mapKey : Text, mapValue : Text })
, required : Optional (List Text)
, title : Optional Text
, type : Optional Text
, uniqueItems : Optional Bool
, x-kubernetes-embedded-resource : Optional Bool
, x-kubernetes-int-or-string : Optional Bool
, x-kubernetes-list-map-keys : Optional (List Text)
, x-kubernetes-list-type : Optional Text
, x-kubernetes-map-type : Optional Text
, x-kubernetes-preserve-unknown-fields : Optional Bool
}
