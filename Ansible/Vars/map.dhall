{-|
A convenient function to transform a dhall map into a JSON.object
-}
let Map =
      { Type = \(k : Type) -> \(v : Type) -> List { mapKey : k, mapValue : v }
      , map =
          https://prelude.dhall-lang.org/v17.0.0/Map/map sha256:23e09b0b9f08649797dfe1ca39755d5e1c7cad2d0944bdd36c7a0bf804bde8d0
      }

let map
    : forall (valueType : Type) ->
      forall (transformer : valueType -> ./Type.dhall) ->
      forall (map : Map.Type Text valueType) ->
        ./Type.dhall
    = \(valueType : Type) ->
      \(transformer : valueType -> ./Type.dhall) ->
      \(map : Map.Type Text valueType) ->
        ./object.dhall (Map.map Text valueType ./Type.dhall transformer map)

let example0 =
        assert
      :     map Bool ./bool.dhall (toMap { testKey = True })
        ===  ./object.dhall
               [ { mapKey = "testKey", mapValue = ./bool.dhall True } ]

in  map
