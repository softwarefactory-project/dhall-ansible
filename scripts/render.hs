#!/usr/bin/env nix-shell
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/d4f19a218cbb15a242864a49f8b9f16fb7d48ec8.tar.gz
#! nix-shell --pure -i runghc -p "haskellPackages.ghcWithPackages (p: [ p.aeson p.dhall p.relude ])"

{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}

import Data.Aeson
import Data.Aeson.Types (Parser)
import qualified Data.HashMap.Strict as HM
import qualified Data.List as L
import qualified Data.Map as Map
import qualified Data.Text as Text
import qualified Data.Vector as V
import qualified Dhall.Core as D
import qualified Dhall.Map as D
import qualified Dhall.Pretty as D
import Relude

------------------------------------------------------------------------------------------------------------------------
-- Decode ansible-doc output
------------------------------------------------------------------------------------------------------------------------
newtype CollectionName = CollectionName Text deriving (Eq, Ord, Show)

newtype ModuleName = ModuleName Text deriving (Eq, Ord, Show)

decodeModuleList :: LByteString -> Either String [ModuleName]
decodeModuleList bs = map ModuleName . Map.keys <$> (eitherDecode bs :: Either String (Map Text Text))

data OptionType
  = OText
  | OPath
  | OBool
  | ORaw
  | OChoice [Text]
  deriving (Eq, Ord, Show)

data ModuleOption = ModuleOption
  { optionName :: Text,
    optionRequired :: Bool,
    optionDescription :: Text,
    optionType :: OptionType
  }
  deriving (Eq, Ord, Show)

parseOption :: (Text, Value) -> Parser ModuleOption
parseOption (name, Object v) = ModuleOption name <$> parseRequired <*> parseDescription <*> parseType
  where
    textArray :: [Value] -> [Text]
    textArray [] = []
    textArray (String x : xs) = toText x : textArray xs
    textArray x = error ("Not a text array: " <> show x)
    parseRequired :: Parser Bool
    parseRequired = do
      req <- v .:? "required"
      case req of
        Just True -> pure True
        _ -> pure False
    parseDescription :: Parser Text
    parseDescription = do
      desc <- v .: "description"
      case desc of
        Array t -> pure $ Text.unlines (textArray (V.toList t))
    parseType = do
      t <- v .: "type"
      case t of
        String "str" -> do
          choices <- v .:? "choices"
          case choices of
            Just (Array t) -> pure $ OChoice $ textArray (V.toList t)
            Just x -> fail ("Unknown " <> toString name <> " array: " <> show x)
            Nothing -> pure OText
        String "path" -> pure OPath
        String "bool" -> pure OBool
        String "raw" -> pure ORaw
        _ -> fail ("Unknown " <> toString name <> " type: " <> show t <> " in " <> show v)

newtype ModuleOptions = ModuleOptions [ModuleOption] deriving (Eq, Ord, Show)

parseOptions :: [(Text, Value)] -> Parser ModuleOptions
parseOptions xs = ModuleOptions <$> mapM parseOption xs

instance FromJSON ModuleOptions where
  parseJSON (Object v) = case HM.elems v of
    [v] -> case v of
      Object obj -> do
        doc <- obj .: "doc"
        options <- doc .: "options"
        case options of
          Object options' -> parseOptions (HM.toList options')
          _ -> empty
      _ -> empty
    _ -> empty
  parseJSON _ = empty

decodeModuleOptions :: LByteString -> Either String ModuleOptions
decodeModuleOptions bs = eitherDecode bs

------------------------------------------------------------------------------------------------------------------------
-- Convert to Dhall
------------------------------------------------------------------------------------------------------------------------
dhallType :: ModuleOptions -> D.Expr Void Void
dhallType (ModuleOptions xs) = D.Record $ (fmap D.makeRecordField) $ D.fromList $ L.foldl go [] xs
  where
    go :: [(Text, D.Expr Void Void)] -> ModuleOption -> [(Text, D.Expr Void Void)]
    go acc (ModuleOption name required _desc optionType) =
      let dhallType = case optionType of
            OBool -> D.Bool
            OChoice choices -> D.Union (D.fromList $ map (\choice -> (choice, Nothing)) choices)
            _ -> D.Text
       in (name, if not required then (D.App D.Optional dhallType) else dhallType) : acc

main :: IO ()
main = do
  fileInfo <- readFileLBS "file.json"
  print (D.prettyExpr . dhallType <$> decodeModuleOptions fileInfo)

-- moduleList <- readFileLBS "list.json"
-- print (take 2 <$> (decodeModuleList moduleList))
