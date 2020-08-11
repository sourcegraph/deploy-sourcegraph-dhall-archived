let configuration =
    -- Note. I did this very quickly for the demo and I'm
    -- actually not sure whether or not we should bundle this at all.
    -- for right now, I'm going to only allow just
      { Type = { Enabled : Bool, IPAddress : Optional Text }
      , default = { Enabled = False, IPAddress = None Text }
      }

in  configuration
