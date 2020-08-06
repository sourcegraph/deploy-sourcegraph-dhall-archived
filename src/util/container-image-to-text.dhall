let Optional/default =
      https://prelude.dhall-lang.org/v17.0.0/Optional/default sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let imageConfiguration = ../cofiguration/container-image.dhall

let ImageSpec =
      { registry : Text
      , orgName : Text
      , imageName : Text
      , version : Text
      , sha256 : Optional Text
      }

let prependToOptionalText =
      λ(prefix : Text) →
        (maybeText : Optional Text) →
          merge
            { Some = λ(t : Text) → Some prefix ++ t, None = None Text }
            maybeText

let toText
    : ImageSpec → imageConfiguration.Type → Text
    = λ(base : ImageSpec) →
      λ(overlay : imageConfiguration.Type) →
        let overlayedSha256 =
              if    overlay.excludeSha256
              then  None Text
              else  prependToOptionalText "@" base.sha256

        let sha256Part = Optional/default Text "" overlayedSha256

        let registryPart = Optional/default Text base.registry overlay.registry

        let prefixedImageName =
              merge
                { Some = λ(t : Text) → t ++ base.imageName
                , None = base.imageName
                }
                overlay.imagePrefix

        let imagePart =
              merge
                { Some = λ(t : Text) → prefixedImageName ++ t
                , None = prefixedImageName
                }
                overlay.imageSuffix

        let return =
                  registryPart
              ++  "/"
              ++  base.orgName
              ++  "/"
              ++  imagePart
              ++  ":"
              ++  base.version
              ++  sha256Part

        in  return

in  toText
