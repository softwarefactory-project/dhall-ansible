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
import Data.List (sortOn)
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
        Record record -> pack $ (show $ prettyExpr $ process record) <> "\n"
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

mkSchemas :: Text -> Text -> Text
mkSchemas tfn dfn = pack $ (show $ prettyExpr $ go) <> "\n"
  where
    go = case exprFromText "test" ("{ Type = " <> tfn <> " , default = " <> dfn <> " }") of
      Left err -> error $ show err
      Right expr -> expr

main :: IO ()
main = shakeArgs shakeOptions {shakeFiles = "_build"} $ do
  want ["package.dhall"]

  --  TODO: generate package
  --  "package.dhall" %> \out -> do
  phony "package.dhall" $ do
    allFiles <- getDirectoryFiles "" ["types//*.dhall"]
    let files = filter ((/=) "types/map_text.dhall") allFiles
    need (Prelude.map (sub "defaults") files)
    need (Prelude.map (sub "schemas") files)
    schemas <- getDirectoryFiles "" ["schemas//*.dhall"]
    putInfo $ "package.dhall: created from " <> show schemas

  "schemas//*.dhall" %> \dst -> do
    let depth = (length $ splitPath dst) - 1
    let prefix = mconcat $ take depth $ repeat (pack "../")
    let typePath = prefix <> pack (sub "types" dst)
    let defPath = prefix <> pack (sub "defaults" dst)
    putInfo $ dst <> ": updated"
    -- TODO: ensure parent directory exists
    writeFile' dst $ unpack (mkSchemas typePath defPath)

  "defaults//*.dhall" %> \dst -> do
    let src = sub "types" dst
    putInfo $ dst <> ": created from " <> src
    fileContent <- readFile' src
    -- TODO: ensure parent directory exists
    writeFile' dst $ unpack (getDefaults src $ pack fileContent)
  where
    sub dir fn = joinPath ([dir] <> Prelude.drop 1 (splitPath fn))
