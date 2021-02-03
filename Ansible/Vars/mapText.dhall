{-|
A convenient function to transform a text map into a JSON.object
-}
let Map
    : Type -> Type -> Type
    = \(k : Type) -> \(v : Type) -> List { mapKey : k, mapValue : v }

let mapText
    : Map Text Text -> ./Type.dhall
    = ./map.dhall Text ./string.dhall

let example0 =
        assert
      :     mapText (toMap { testKey = "value" })
        ===  ./object.dhall
               [ { mapKey = "testKey", mapValue = ./string.dhall "value" } ]

in  mapText
