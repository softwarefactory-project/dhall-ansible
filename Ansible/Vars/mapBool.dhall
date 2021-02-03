{-|
A convenient function to transform a text bool into a JSON.object
-}
let Map
    : Type -> Type -> Type
    = \(k : Type) -> \(v : Type) -> List { mapKey : k, mapValue : v }

let mapBool
    : Map Text Bool -> ./Type.dhall
    = ./map.dhall Bool ./bool.dhall

let example0 =
        assert
      :     mapBool (toMap { testKey = True })
        ===  ./object.dhall
               [ { mapKey = "testKey", mapValue = ./bool.dhall True } ]

in  mapBool
