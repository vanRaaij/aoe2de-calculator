module Test.Generated.Main1436363166 exposing (main)

import ResourcesTest

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "ResourcesTest" [ResourcesTest.suite] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 259662697645664, processes = 2, paths = ["/home/travis/build/vanRaaij/aoe2de-calculator/tests/ResourcesTest.elm"]}