module Data.UnitData exposing
    ( BaseUnitData
    , BaseUnitDataContainer
    , UnitFamily
    , UnitFamilyType(..)
    , baseUnits
    , getFromUnit
    , map
    , unitData
    , zip
    )

import Resources exposing (Cost, food, gold, time, withCostOf, wood)


type alias UnitFamily =
    { unitFamilyType : UnitFamilyType
    , units : List Unit
    }


type alias Unit =
    { name : String
    , cost : Cost
    }


type UnitFamilyType
    = Militia
    | Spearman
    | Archer
    | Skirmisher


unitData : UnitFamilyType -> UnitFamily
unitData unitFamilyType =
    case unitFamilyType of
        Militia ->
            militiaLine

        Spearman ->
            spearmanLine

        Archer ->
            archerLine

        Skirmisher ->
            skirmisherLine


type alias BaseUnitDataContainer a =
    { militia : a
    , spearman : a
    , archer : a
    , skirmisher : a
    }


getFromUnit : UnitFamilyType -> BaseUnitDataContainer a -> a
getFromUnit unitFamilyType =
    case unitFamilyType of
        Militia ->
            .militia

        Spearman ->
            .spearman

        Archer ->
            .archer

        Skirmisher ->
            .skirmisher


zip : (a -> b -> c) -> BaseUnitDataContainer a -> BaseUnitDataContainer b -> BaseUnitDataContainer c
zip f buc1 buc2 =
    { militia = f buc1.militia buc2.militia
    , spearman = f buc1.spearman buc2.spearman
    , archer = f buc1.archer buc2.archer
    , skirmisher = f buc1.skirmisher buc2.skirmisher
    }


map : (a -> b) -> BaseUnitDataContainer a -> BaseUnitDataContainer b
map f buc =
    { militia = f buc.militia
    , spearman = f buc.spearman
    , archer = f buc.archer
    , skirmisher = f buc.skirmisher
    }


type alias BaseUnitData =
    BaseUnitDataContainer Int


type alias BaseUnits =
    BaseUnitDataContainer UnitFamily


baseUnits : BaseUnitData -> BaseUnits
baseUnits bud =
    { militia = take bud.militia militiaLine
    , spearman = take bud.spearman spearmanLine
    , archer = take bud.archer archerLine
    , skirmisher = take bud.skirmisher skirmisherLine
    }


take : Int -> UnitFamily -> UnitFamily
take n { unitFamilyType, units } =
    { unitFamilyType = unitFamilyType
    , units = List.take n units
    }


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
    }


archerLine : UnitFamily
archerLine =
    let
        archerCost =
            withCostOf |> wood 25 |> food 45
    in
    { unitFamilyType = Archer
    , units =
        [ Unit "Archer" (archerCost |> time 35)
        , Unit "Crossbowman" (archerCost |> time 27)
        , Unit "Arbalester" (archerCost |> time 27)
        ]
    }


skirmisherLine : UnitFamily
skirmisherLine =
    let
        skirmisherCost =
            withCostOf |> food 25 |> wood 35 |> time 22
    in
    { unitFamilyType = Skirmisher
    , units =
        [ Unit "Skirmisher" skirmisherCost
        , Unit "Elite Skirmisher" skirmisherCost
        , Unit "Imperial Skirmisher" skirmisherCost
        ]
    }
