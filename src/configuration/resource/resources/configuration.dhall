let configuration =
      { Type =
          { memory : Optional Text
          , cpu : Optional Text
          , ephemeralStorage : Optional Text
          }
      , default =
        { memory = None Text, cpu = None Text, ephemeralStorage = None Text }
      }

in  configuration
