module PageElements.Unit exposing
    ( BaseUnitUpdateData
    , UnitState
    , UnitStateUpdateData
    , baseUnitUpdateData
    , init
    , update
    )

import Array exposing (Array)
import Data.UnitData exposing (UnitFamilyType(..))


type alias UnitState =
    { unit : UnitFamilyType
    , count : Int
    , selected : Int
    , highestAllowed : Int
    }


type alias UnitStateUpdateData =
    { baseUnits :
        BaseUnitUpdateData
    }


type alias BaseUnitUpdateData =
    { militia : Int
    , spearman : Int
    }


getBaseUnitMax : BaseUnitUpdateData -> UnitFamilyType -> Int
getBaseUnitMax data unitFamilyType =
    case unitFamilyType of
        Militia ->
            data.militia

        Spearman ->
            data.spearman


init : Array UnitState
init =
    let
        initHelper family =
            { unit = family
            , count = 0
            , selected = 0
            , highestAllowed = 0
            }
    in
    List.map initHelper basicUnits |> Array.fromList


basicUnits : List UnitFamilyType
basicUnits =
    [ Militia, Spearman ]


baseUnitUpdateData : BaseUnitUpdateData
baseUnitUpdateData =
    { militia = 0
    , spearman = 0
    }


update : Array UnitState -> UnitStateUpdateData -> Array UnitState
update unitStates { baseUnits } =
    let
        apply : UnitState -> UnitState
        apply unitState =
            { unitState | highestAllowed = getBaseUnitMax baseUnits unitState.unit }
    in
    Array.map apply unitStates
