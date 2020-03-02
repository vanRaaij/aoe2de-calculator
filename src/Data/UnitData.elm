module Data.UnitData exposing
    ( BaseUnitData
    , UnitFamily
    , UnitFamilyType(..)
    , baseUnits
    , militiaLine
    , produces
    , spearmanLine
    )

import Data.BuildingData exposing (Building(..))
import Resources exposing (Cost, food, gold, time, withCostOf, wood)


type alias UnitFamily =
    { unitFamilyType : UnitFamilyType
    , units : List Unit
    , building : Building
    }


type alias Unit =
    { name : String
    , cost : Cost
    }


type alias BaseUnitData =
    { militia : Int
    , spearman : Int
    }


type UnitFamilyType
    = Militia
    | Spearman


take : Int -> UnitFamily -> UnitFamily
take n { unitFamilyType, units, building } =
    { unitFamilyType = unitFamilyType
    , units = List.take n units
    , building = building
    }


produces : Building -> UnitFamily -> Bool
produces building unitFamily =
    unitFamily.building == building


baseUnits : BaseUnitData -> List UnitFamily
baseUnits bud =
    [ take bud.militia militiaLine
    , take bud.spearman spearmanLine
    ]


militiaLine : UnitFamily
militiaLine =
    let
        militiaCost =
            withCostOf |> food 60 |> gold 20 |> time 21
    in
    { unitFamilyType = Militia
    , units =
        [ Unit "Militia" militiaCost
        , Unit "Man-at-arms" militiaCost
        , Unit "Long Swordsman" militiaCost
        , Unit "Two-handed Swordsman" militiaCost
        , Unit "Champion" militiaCost
        ]
    , building = Barracks
    }


spearmanLine : UnitFamily
spearmanLine =
    let
        spearmanCost =
            withCostOf |> food 35 |> wood 25 |> time 22
    in
    { unitFamilyType = Spearman
    , units =
        [ Unit "Spearman" spearmanCost
        , Unit "Pikeman" spearmanCost
        , Unit "Halbedier" spearmanCost
        ]
    , building = Barracks
    }
