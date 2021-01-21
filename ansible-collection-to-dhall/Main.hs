#!/usr/bin/env nix-shell
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/d4f19a218cbb15a242864a49f8b9f16fb7d48ec8.tar.gz
#! nix-shell --pure -i runghc -p  -p "haskellPackages.ghcWithPackages (p: [ p.aeson p.dhall p.relude p.casing p.directory p.filepath p.typed-process p.optparse-generic ])"

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE TypeOperators #-}
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
import Options.Generic
import Relude
import System.Directory (createDirectoryIfMissing, doesFileExist)
import System.FilePath.Posix (splitDirectories, (</>))
import System.Process.Typed
import Text.Casing (pascal)
import qualified Prelude

----------------------------------------------------------------------------------------------------
-- Work arounds
----------------------------------------------------------------------------------------------------
skipModule :: [ModuleName]
skipModule =
  map
    ModuleName
    [ -- No documentation
      "cisco.intersight.intersight_local_user_policy",
      "fortinet.fortios.fortios_configuration_fact",
      "netapp_eseries.santricity.na_santricity_discover",
      "netapp_eseries.santricity.na_santricity_facts",
      -- Unknown doc fragments
      "community.okd.k8s",
      "community.okd.openshift_process",
      "community.okd.openshift_route",
      -- Provided by base task
      "set_fact"
    ]

-- | A list of collection to skip for the main collections package
hardwareCollections :: [Text]
hardwareCollections =
  map
    (<> ".")
    [ "arista",
      "check_point",
      "cisco",
      "community.routeros",
      "community.hrobot",
      "community.network",
      "community.routeros",
      "cyberark.pas",
      "dellemc",
      "f5networks",
      "fortinet",
      "ffr",
      "infinidat",
      "junipernetworks",
      "mellanox",
      "netapp",
      "netapp_eseries",
      "netbox",
      "ngine_io",
      "purestorage",
      "vyos",
      "wti.remote"
    ]

----------------------------------------------------------------------------------------------------
-- Decode ansible-doc output
----------------------------------------------------------------------------------------------------
newtype ModuleName = ModuleName Text deriving (Eq, Ord, Show)

decodeModuleList :: LByteString -> Either String [ModuleName]
decodeModuleList bs = map ModuleName . Map.keys <$> (eitherDecode bs :: Either String (Map Text Text))

data OptionType
  = OText
  | OPath
  | OBool
  | ORaw
  | OList
  | ODict
  | OInt
  | OJson
  | ODouble
  | OChoice [Text]
  deriving (Eq, Ord, Show)

data ModuleOption = ModuleOption
  { optionName :: Text,
    optionRequired :: Bool,
    optionDescription :: Text,
    optionType :: OptionType
  }
  deriving (Eq, Ord, Show)

-- | Parse a module option from the documentation json
parseOption :: (Text, Value) -> Parser ModuleOption
parseOption (name, Object v) = ModuleOption name <$> parseRequired <*> parseDescription <*> parseType
  where
    textArray :: [Value] -> [Text]
    textArray [] = []
    textArray (String x : xs) = toText x : textArray xs
    textArray _x = [""] -- error ("Not a text array: " <> show x)
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
        String s -> pure $ toText s
        _ -> error ("Invalid desc: " <> show desc)
    parseType = do
      t <- v .:? "type"
      case t of
        Nothing -> parseChoice
        Just (String "str") -> parseChoice
        -- jsonarg is either a dict or a json string
        Just (String "jsonarg") -> pure ODict
        Just (String "sid") -> pure OText
        Just (String "list") -> pure OList
        Just (String "path") -> pure OPath
        Just (String "bool") -> pure OBool
        Just (String "raw") -> pure ORaw
        Just (String "dict") -> pure ODict
        Just (String "int") -> pure OInt
        Just (String "json") -> pure OJson
        Just (String "float") -> pure ODouble
        _ -> fail ("Unknown " <> toString name <> " type: " <> show t <> " in " <> show v)
    parseChoice = do
      choices <- v .:? "choices"
      case choices of
        Just (Array t) -> pure $ OChoice $ textArray (V.toList t)
        Just x -> fail ("Unknown " <> toString name <> " array: " <> show x)
        Nothing -> pure OText
parseOption _ = error "Invalid option type"

newtype ModuleOptions = ModuleOptions [ModuleOption] deriving (Eq, Ord, Show)

-- | FromJSON instance to decode a module options from the documentation json
instance FromJSON ModuleOptions where
  parseJSON (Object v) = case HM.elems v of
    [v'] -> case v' of
      Object obj -> do
        doc <- obj .: "doc"
        options <- doc .:? "options"
        case options of
          Just (Object options') -> ModuleOptions <$> mapM parseOption (HM.toList options')
          Nothing -> pure (ModuleOptions [])
          _ -> empty
      _ -> empty
    _ -> empty
  parseJSON _ = empty

----------------------------------------------------------------------------------------------------
-- Convert to Dhall
----------------------------------------------------------------------------------------------------

-- | Convert a module options to a Dhall record type
dhallType :: ModuleOptions -> D.Expr Void D.Import
dhallType (ModuleOptions xs) = D.Record $ fmap D.makeRecordField $ D.fromList $ L.foldl go [] xs
  where
    go :: [(Text, D.Expr Void D.Import)] -> ModuleOption -> [(Text, D.Expr Void D.Import)]
    go acc (ModuleOption name required _desc optionType') =
      let dhallType' = case optionType' of
            OBool -> D.Bool
            OList -> D.App D.List D.Text
            ODict -> mkImport D.Parent [] "JSON.dhall"
            OChoice choices -> D.Union (D.fromList $ map (,Nothing) choices)
            OInt -> D.Natural
            OText -> D.Text
            OPath -> D.Text
            ORaw -> D.Text
            ODouble -> D.Double
            -- json type seems to indicate `json as a string`
            OJson -> D.Text
       in (name, if not required then D.App D.Optional dhallType' else dhallType') : acc

-- | Helper function to create an import path expression
mkImport :: D.FilePrefix -> [Text] -> Text -> D.Expr Void D.Import
mkImport loc dirs fp =
  let importType = D.Local loc (D.File (D.Directory dirs) fp)
   in D.Embed (D.Import (D.ImportHashed Nothing importType) D.Code)

-- | Create a Dhall schema from a module record type
dhallModulePackage :: D.Expr Void D.Import -> [(FilePath, D.Expr Void D.Import)]
dhallModulePackage (D.Record kvm) =
  [ ("Type.dhall", D.Record . D.fromList $ type_),
    ("default.dhall", D.RecordLit . D.fromList $ default_)
  ]
    <> unions
  where
    kv = D.toList kvm
    type_ = L.foldl replaceUnion [] kv
    unions = L.foldl getUnion [] kv
    default_ = L.foldl makeOptional [] type_
    makeOptional acc (n, D.RecordField _ v _ _) =
      case v of
        (D.App D.Optional x) -> (n, D.makeRecordField $ D.App D.None x) : acc
        _ -> acc
    unionFileName fp = fp <> ".dhall"
    mkImport' fp = mkImport D.Here [] (unionFileName fp)
    getUnion acc (n, D.RecordField _ v _ _) =
      case v of
        (D.App D.Optional x@(D.Union _)) -> (toString $ unionFileName n, x) : acc
        x@(D.Union _) -> (toString $ unionFileName n, x) : acc
        _ -> acc
    replaceUnion acc (n, D.RecordField _ v _ _) =
      let v' = case v of
            D.Union _ -> mkImport' n
            (D.App D.Optional (D.Union _)) -> D.App D.Optional (mkImport' n)
            x -> x
       in (n, D.makeRecordField v') : acc
dhallModulePackage _ = error "Invalid dhall expression"

-- | Create a Dhall schema for a collection task type extension
dhallCollectionPackage :: [(ModuleName, FilePath, ModuleOptions)] -> [(FilePath, D.Expr Void D.Import)]
dhallCollectionPackage xs =
  [ ("Type.dhall", D.Record . D.fromList $ L.foldl goType [] xs),
    ("default.dhall", D.RecordLit . D.fromList $ L.foldl goDefault [] xs)
  ]
  where
    goType acc (ModuleName name, fp, _) = (name, attr D.Optional fp) : acc
    goDefault acc (ModuleName name, fp, _) = (name, attr D.None fp) : acc
    attr func fp = D.makeRecordField $ D.App func (mkImport D.Parent [toText fp] "Type.dhall")

----------------------------------------------------------------------------------------------------
-- dhall-ansible structure
----------------------------------------------------------------------------------------------------

-- | Group module into collection based on their name
mergeModules :: [(ModuleName, ModuleOptions)] -> [Collection]
mergeModules = Map.toList . go mempty
  where
    go :: Map Text [(ModuleName, FilePath, ModuleOptions)] -> [(ModuleName, ModuleOptions)] -> Map Text [(ModuleName, FilePath, ModuleOptions)]
    go acc [] = acc
    go acc ((ModuleName name, opts) : xs) =
      let newModule = (ModuleName name, toString moduleName, opts)
          newAcc = case Map.lookup collectionName acc of
            Just val -> Map.insert collectionName (newModule : val) acc
            Nothing -> Map.insert collectionName [newModule] acc
       in go newAcc xs
      where
        toPascal = toText . pascal . toString
        (collectionName, moduleName) = (toPascal collectionName', toPascal moduleName')
        (collectionName', moduleName') = case Text.split (== '.') name of
          [a, b, c] | a == b -> (Text.toTitle a, c)
          [a, b, c] -> (Text.toTitle a <> Text.toTitle b, c)
          [a] -> ("Builtin", a)
          _ -> error ("Unknown module name:" <> name)

type Collection = (Text, [(ModuleName, FilePath, ModuleOptions)])

doCollection :: FilePath -> Collection -> IO ()
doCollection root (name, modules) = do
  touchPackage collectionDir
  unless (name == "Builtin") writeTemplates
  writeCollection
  mapM_ writeModule modules
  when needJson writeJsonType
  putText "Done."
  where
    writeJsonType = writeFileText (collectionDir </> "JSON.dhall") jsonImportText
    jsonImportText =
      ( "https://prelude.dhall-lang.org/v17.0.0/JSON/Type "
          <> "sha256:40edbc9371979426df63e064333b02689b969c4cfbbccfa481216d2d1a6e9759\n"
      )
    isJson :: ModuleOption -> Bool
    isJson (ModuleOption _ _ _ optionType') = case optionType' of
      ODict -> True
      _ -> False
    rootName = toText $ Prelude.last (splitDirectories root)
    colName = Prelude.last (Text.split (== '-') (toText rootName))
    colUrl = Text.replace "." "/" colName
    write fp txt = do
      writeFileText (root </> fp) (Text.unlines txt)
    writeTemplates = do
      write
        "README.md"
        [ "# " <> toText rootName,
          "",
          "This project contains [Dhall][dhall-lang] bindings to the [Ansible][ansible] "
            <> "["
            <> colName
            <> "](https://docs.ansible.com/ansible/latest/collections/"
            <> colUrl
            <> "/) collection.",
          "See the main [dhall-ansible][dhall-ansible] bindings documentation.",
          "",
          "## Changes",
          "",
          "Frozen packages are available in the tag commit.",
          "",
          "### 0.1.0",
          "",
          "- Initial release using ansible-2.10.5",
          "",
          "[dhall-ansible]: https://github.com/softwarefactory-project/dhall-ansible#readme",
          "[dhall-lang]: https://dhall-lang.org",
          "[ansible]: https://ansible.com"
        ]
      write
        ".zuul.yaml"
        [ "- project:",
          "    check: &ci",
          "      jobs:",
          "        - shake-factory-test",
          "        - shake-factory-docs",
          "    gate: *ci",
          "    post:",
          "      jobs:",
          "        - shake-factory-publish-docs"
        ]
      write
        "Shakefile.hs"
        [ "-- Interpret using this command:",
          "--    podman run -it --rm -v $(pwd):/data:Z quay.io/software-factory/shake-factory",
          "--",
          "-- Learn more at: https://softwarefactory-project.io/cgit/software-factory/shake-factory/tree/README.md",
          "",
          "import Development.Shake",
          "import ShakeFactory",
          "import ShakeFactory.Dhall",
          "",
          "root = \"./" <> name <> "/package.dhall\"",
          "",
          "main = shakeMain $ do",
          "  want [\"package.dhall\"]",
          "  \"package.dhall\" %> dhallTopLevelPackageAction root",
          "  \"//package.dhall\" %> dhallPackageAction",
          "  dhallDocsRules \"" <> rootName <> "\"",
          "  dhallReleaseRules root",
          "  cleanRules"
        ]
    needJson = any (\(_, _, ModuleOptions opts) -> any isJson opts) modules
    doModule :: ModuleOptions -> [(FilePath, Text)]
    doModule = (fmap . fmap) D.pretty . dhallModulePackage . dhallType
    doTask :: [(ModuleName, FilePath, ModuleOptions)] -> [(FilePath, Text)]
    doTask = (fmap . fmap) D.pretty . dhallCollectionPackage
    touchPackage dirPath = do
      createDirectoryIfMissing True dirPath
      let packagePath = dirPath </> "package.dhall"
      packageExists <- doesFileExist packagePath
      unless packageExists $ writeFileText (dirPath </> "package.dhall") "-- to be filled by shake\n"
    collectionDir = root </> toString name
    collectionTaskDir = collectionDir </> "Task"
    writeCollection = do
      putTextLn ("* " <> name)
      touchPackage collectionTaskDir
      mapM_ (go collectionTaskDir) $ doTask modules
    writeModule (_, moduleDir, moduleOption) = do
      let dirPath = collectionDir </> moduleDir
      putTextLn ("  - " <> toText dirPath)
      touchPackage dirPath
      mapM_ (go dirPath) $ doModule moduleOption
    go dirPath (fp, content) = writeFileText (dirPath </> fp) content

----------------------------------------------------------------------------------------------------
-- CLI
----------------------------------------------------------------------------------------------------
data RenderCli w = RenderCli
  { ansible_doc :: w ::: FilePath <?> "The path to the ansible-log command",
    collection :: w ::: Maybe Text <?> "The collection name x.y",
    builtin :: w ::: Bool <?> "Render the builtin",
    hardware_collections :: w ::: Bool <?> "Render the hardware collections",
    output :: w ::: FilePath <?> "The output directory"
  }
  deriving (Generic)

filterModules :: Maybe Text -> Bool -> Bool -> [ModuleName] -> [ModuleName]
filterModules prefix onlyBuiltin onlyHardware = L.foldl go []
  where
    isHardware :: Text -> Text -> Bool
    isHardware = flip Text.isPrefixOf
    isBuiltin :: Text -> Bool
    isBuiltin name = case Text.find ('.' ==) name of
      Just _ -> False
      Nothing -> True
    go :: [ModuleName] -> ModuleName -> [ModuleName]
    go acc (ModuleName name) =
      let keep = case (prefix, onlyBuiltin, onlyHardware) of
            (Just "all", False, True) -> not (isBuiltin name)
            (Just "all", False, False) -> not (isBuiltin name) && not (any (isHardware name) hardwareCollections)
            (Just prefix', _, _) -> Text.isPrefixOf prefix' name
            (_, True, _) -> isBuiltin name
            (_, _, True) -> any (isHardware name) hardwareCollections
            _ -> error "--collection_prefix prefix or --builtin must be set"
       in if keep then ModuleName name : acc else acc

instance ParseRecord (RenderCli Wrapped)

deriving instance Show (RenderCli Unwrapped)

main :: IO ()
main = do
  args <- unwrapRecord "Ansible Collection to Dhall Schemas"
  createDirectoryIfMissing True ".cache"
  modulesList <-
    filterModules
      (collection args)
      (builtin args)
      (hardware_collections args)
      <$> getModuleList (ansible_doc args)
  moduleOptions <- mapM (getModuleOptions (ansible_doc args)) modulesList
  case mergeModules (zip modulesList moduleOptions) of
    [collection'] -> doCollection (output args) collection'
    [] -> error "No collection found!"
    xs | collection args == Just "all" -> mapM_ (doCollection (output args)) xs
    xs -> error ("More than one collection was found: " <> show xs)
  where
    getModuleList :: FilePath -> IO [ModuleName]
    getModuleList ansibleDoc = do
      cached <- doesFileExist ".cache/list.json"
      list <- if cached then readFileLBS ".cache/list.json" else readProcessStdout_ (proc ansibleDoc ["--list", "--json"])
      unless cached (writeFileLBS ".cache/list.json" list)
      case decodeModuleList list of
        Left _err -> error "Couldn't get module list"
        Right moduleList -> pure $ filter (not . flip elem skipModule) moduleList

    getModuleOptions :: FilePath -> ModuleName -> IO ModuleOptions
    getModuleOptions ansibleDoc name@(ModuleName mname) = do
      let cacheName = ".cache/" <> toString mname <> ".json"
      cached <- doesFileExist cacheName
      options <- if cached then readFileLBS cacheName else readProcessStdout_ (proc ansibleDoc ["--json", toString mname])
      unless cached (writeFileLBS cacheName options)
      case eitherDecode options of
        Left err -> error ("Couldn't decode " <> show name <> ":" <> show err)
        Right x -> pure x
