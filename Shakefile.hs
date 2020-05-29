#!/usr/bin/env stack
-- stack script --resolver lts-15.3 --package shake --package dhall --package text

--
-- Copyright (C) 2020 Red Hat
--
-- Licensed under the Apache License, Version 2.0 (the "License"); you may
-- not use this file except in compliance with the License. You may obtain
-- a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
-- WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
-- License for the specific language governing permissions and limitations
-- under the License.
--
-- Execute this file to update the dhall-ansible binding
--
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

import Control.Monad (unless)
import Data.Char (toUpper)
import Data.List (sort, sortOn)
import Data.Text (Text, pack, unpack)
import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util
-- import qualified Dhall.Core (Expr (..), denote)
import Dhall.Core
import Dhall.Map (fromList, toList)
import Dhall.Parser (exprFromText)
import Dhall.Pretty (prettyExpr)
import Data.Void (Void)

-- | Convert a dhall type record to a value record using None value for Optional attributes
-- | >>> getDefaults "./types/test.dhall" "{ name : Text, become : Optional Bool, task : Optional ./Task.dhall }"
-- | "{ become = None Bool, task = None ../types/Task.dhall }"
getDefaults :: FilePath -> Text -> Text
getDefaults fn content = decode
  where
    decode :: Text
    decode = case exprFromText fn content of
      Left err -> error $ show err
      Right expr -> case Dhall.Core.denote expr of
        Record record -> expr2Text $ process record
        _ -> error $ fn <> ": is not a record type"
    process record = RecordLit $ fromList $ sortOn fst $ go $ toList record
    -- Process every record element
    go :: [(Text, Expr s Import)] -> [(Text, Expr s Import)]
    go [] = []
    go ((n, App Optional v) : xs) = (n, App None (updateImport v)) : go xs
    go (x : xs) = go xs
    -- Replace import expression with new relative path
    updateImport :: Expr s Import -> Expr s Import
    -- This match List of imports
    updateImport (App e1 e2) = App (updateImport e1) (updateImport e2)
    updateImport (Embed (i@Import {..})) =
      case importType importHashed of
        Local Here j@File {..} -> addTypeToFile i j
        _ -> (Embed i)
    -- TODO: support more nested import?
    updateImport e = e
    -- Add the '../types/' prefix to a local import file
    addTypeToFile :: Import -> File -> Expr s Import
    addTypeToFile imp f =
      ( Embed
          imp
            { importHashed =
                (Dhall.Core.importHashed imp)
                  { importType =
                      Local
                        Parent
                        ( File
                            { directory =
                                Directory
                                  { components = (Dhall.Core.components (Dhall.Core.directory f)) ++ ["types"]
                                  },
                              file = (Dhall.Core.file f)
                            }
                        )
                  }
            }
      )

-- | Create a dhall schema for a type and default
mkSchema :: FilePath -> FilePath -> Text
mkSchema typePath defPath = expr2Text schema
  where
    schema = RecordLit (fromList [("Type", mkImport typePath), ("default", mkImport defPath)])

-- | Create the final dhall package
mkPackage :: [FilePath] -> Text
mkPackage xs = expr2Text package
  where
    package = RecordLit (fromList $ sortOn fst $ map (\f -> (pack $ getName $ '_' :  takeBaseName f, mkImport f)) xs)
    getName :: FilePath -> FilePath
    getName [] = []
    getName ('_':x:xs') = toUpper x: getName xs'
    getName (x:xs') = x : getName xs'

-- | Create a dhall Expr for a FilePath import
mkImport :: FilePath -> Expr Void Import
mkImport path = Embed import'
  where
    import' = Import importHashed Code
    importHashed = ImportHashed Nothing importType
    importType = Local prefix file
    prefix
      | take 3 path == "../" = Parent
      | otherwise = Here
    relPath
      | take 3 path == "../" = drop 3 path
      | take 2 path == "./"  = drop 2 path
      | otherwise = path
    file = File directory (pack $ takeFileName path)
    directory = Directory (map pack $ reverse $ splitDirectories $ takeDirectory relPath)

-- | Pretty format a dhall Expr
expr2Text :: Expr Void Import -> Text
expr2Text e = pack $ (show $ prettyExpr e) <> "\n"

main :: IO ()
main = shakeArgs shakeOptions {shakeFiles = "_build"} $ do
  want ["package.dhall"]

  "package.dhall" %> \out -> do
    allFiles <- getDirectoryFiles "" ["types//*.dhall"]
    let files = filter ((/=) "types/map_text.dhall") allFiles
    let schemas = (Prelude.map (sub "schemas") files)
    need (Prelude.map (sub "defaults") files)
    need schemas
    putInfo $ out <> ": updated"
    writeFile' out $ unpack (mkPackage schemas)

  "schemas//*.dhall" %> \dst -> do
    let depth = (length $ splitPath dst) - 1
    let prefix = mconcat $ take depth $ repeat "../"
    let (typePath, defPath) = (sub "types" dst, sub "defaults" dst)
    let (typeRel, defRel) = (prefix <> typePath, prefix <> defPath)
    need [typePath, defPath]
    putInfo $ dst <> ": updated with " <> typeRel <> " and " <> defRel
    -- TODO: ensure parent directory exists
    writeFile' dst $ unpack (mkSchema typeRel defRel)

  "defaults//*.dhall" %> \dst -> do
    let src = sub "types" dst
    putInfo $ dst <> ": created from " <> src
    fileContent <- readFile' src
    -- TODO: ensure parent directory exists
    writeFile' dst $ unpack (getDefaults src $ pack fileContent)
  where
    sub dir fn = joinPath ([dir] <> Prelude.drop 1 (splitPath fn))
