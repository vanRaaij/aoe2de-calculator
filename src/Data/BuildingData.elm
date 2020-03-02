module Data.BuildingData exposing
    ( Building(..)
    , buildingName
    )


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
