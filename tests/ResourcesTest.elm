module ResourcesTest exposing (..)

import Expect exposing (Expectation, FloatingPointTolerance(..))
import Fuzz exposing (Fuzzer, float, int, list, string, tuple)
import Resources exposing (Cost, food, gold, stone, time, withCostOf, wood)
import Test exposing (..)


suite : Test
suite =
    describe "Resources"
        [ fuzz int
            "withCostOf food stores food cost"
            (\n ->
                let
                    cost =
                        withCostOf |> food n
                in
                cost.resources.food |> Expect.equal n
            )
        , fuzz int
            "withCostOf wood stores wood cost"
            (\n ->
                let
                    cost =
                        withCostOf |> wood n
                in
                cost.resources.wood |> Expect.equal n
            )
        , fuzz int
            "withCostOf stone stores stone cost"
            (\n ->
                let
                    cost =
                        withCostOf |> stone n
                in
                cost.resources.stone |> Expect.equal n
            )
        , fuzz int
            "withCostOf gold stores gold cost"
            (\n ->
                let
                    cost =
                        withCostOf |> gold n
                in
                cost.resources.gold |> Expect.equal n
            )
        , fuzz float
            "withCostOf time stores time cost"
            (\n ->
                let
                    cost =
                        withCostOf |> time n
                in
                cost.buildTime |> Expect.within (Relative 0.0001) n
            )
        , fuzz3 (tuple ( int, int ))
            (tuple ( int, int ))
            float
            "withCostOf everything stores everything"
            (\( f, w ) ( s, g ) t ->
                let
                    cost =
                        withCostOf |> food f |> wood w |> stone s |> gold g |> time t
                in
                Expect.all
                    [ \c -> Expect.equal f c.resources.food
                    , \c -> Expect.equal w c.resources.wood
                    , \c -> Expect.equal s c.resources.stone
                    , \c -> Expect.equal g c.resources.gold
                    , \c -> Expect.within (Relative 0.0001) t c.buildTime
                    ]
                    cost
            )
        ]
