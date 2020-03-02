module PageElements.Unit exposing
    ( UnitState
    , UnitStateUpdateData
    , baseUnitUpdateData
    , init
    , update
    )

import Array exposing (Array)
import Data.BuildingData exposing (Building, buildingName)
import Data.CivilizationData exposing (CivilizationData)
import Data.UnitData exposing (BaseUnitData, UnitFamily, UnitFamilyType(..), baseUnits, produces)
import Html.Styled exposing (Html, div, h3, text)
import Html.Styled.Keyed as Keyed


type alias UnitState =
    { unit : UnitFamilyType
    , count : Int
    , selected : Int
    , highestAllowed : Int
    }


type alias UnitStateUpdateData =
    { baseUnits :
        BaseUnitData
    }


getBaseUnitMax : BaseUnitData -> UnitFamilyType -> Int
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


baseUnitUpdateData : BaseUnitData
baseUnitUpdateData =
    { militia = 0
    , spearman = 0
    }


update : Array UnitState -> Maybe CivilizationData -> Array UnitState
update unitStates civ =
    let
        apply : CivilizationData -> UnitState -> UnitState
        apply civ_ unitState =
            { unitState
                | highestAllowed = getBaseUnitMax civ_.baseUnits unitState.unit
                , selected = clamp 0 (getBaseUnitMax civ_.baseUnits unitState.unit) unitState.selected
            }
    in
    case civ of
        Just c ->
            Array.map (apply c) unitStates

        Nothing ->
            unitStates


view : Array UnitState -> List UnitFamily -> Building -> Html msg
view unitStates unitFamilies building =
    let
        units : List UnitFamily
        units =
            List.filter (produces building) unitFamilies

        pairs : List (UnitState, UnitFamily)
        pairs =
            units |>
            List.map (\u -> (getFromArray unitStates u.unitFamilyType, u))

        getFromArray : Array UnitState -> UnitFamilyType -> UnitState
        getFromArray array unitFamilyType =
            array.


    in
    Keyed.node (buildingName building) []
        (List.map viewUnit)


viewUnit : ( UnitState, UnitFamily ) -> ( String, Html msg )
viewUnit ( unitState, unitFamily ) =
    ( "Hello", div [] [] )
