let configuration =
      { Type =
          { excludeSha256 : Bool
          , registry : Optional Text
          , imagePrefix : Optional Text
          , imageSuffix : Optional Text
          }
      , default =
        { excludeSha256 = False
        , registry = None Text
        , imagePrefix = None Text
        , imageSuffix = None Text
        }
      }

in  configuration
