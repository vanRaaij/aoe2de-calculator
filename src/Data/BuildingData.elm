module Data.BuildingData exposing
    ( Building(..)
    , buildingName
    , production
    )

import Data.UnitData exposing (UnitFamilyType(..))


type Building
    = Barracks
    | ArcheryRange
    | Stable
    | Castle
    | TownCenter


buildingName : Building -> String
buildingName building =
    case building of
        Barracks ->
            "Barracks"

        ArcheryRange ->
            "Archery Range"

        Stable ->
            "Stable"

        Castle ->
            "Castle"

        TownCenter ->
            "Town Center"


production : Building -> List UnitFamilyType
production building =
    case building of
        Barracks ->
            [ Militia, Spearman ]

        ArcheryRange ->
            [ Archer, Skirmisher ]

        Stable ->
            []

        Castle ->
            []

        TownCenter ->
            []
