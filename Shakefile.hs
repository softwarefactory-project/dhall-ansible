-- Interpret using this command:
--    podman run -it --rm -v $(pwd):/data:Z quay.io/software-factory/shake-factory
--
-- Learn more at: https://softwarefactory-project.io/cgit/software-factory/shake-factory/tree/README.md

import Control.Monad
import Data.List (isPrefixOf)
import Development.Shake
import ShakeFactory
import ShakeFactory.Dhall

test :: Rules ()
test = phony "test" $ do
  testCases <- getDirectoryFiles "tests" ["*"]
  mapM_ testLoad testCases
  where
    testLoad :: String -> Action String
    testLoad testCase = do
      Stdout s <- cmd "yaml-to-dhall" ["List (./package.dhall).Play.Type"] "--file" ("tests/" <> testCase)
      pure s

main :: IO ()
main = shakeMain $ do
  want ["README.md", "test", "package.dhall", "Ansible/BaseTask/default.dhall", "Ansible/BasePlay/default.dhall"]
  "README.md" %> dhallReadmeAction
  "package.dhall" %> dhallTopLevelPackageAction "./Ansible/package.dhall"
  -- TODO: fix rules to avoid creating intermediate builtin file.
  -- "//package.dhall" %> \out -> unless ("../" `isPrefixOf` out) (dhallPackageAction out)
  "Ansible/BaseTask/default.dhall" %> dhallDefaultAction
  "Ansible/BasePlay/default.dhall" %> dhallDefaultAction
  dhallDocsRules "dhall-ansible"
  dhallReleaseRules "./Ansible/package.dhall"
  cleanRules
  test
