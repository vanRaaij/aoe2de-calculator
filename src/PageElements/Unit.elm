module PageElements.Unit exposing
    ( Msg(..)
    , State
    , init
    , update
    )

import Data.CivilizationData exposing (Civilization, CivilizationData, civilizationData)
import Data.UnitData as UnitData exposing (BaseUnitData, BaseUnitDataContainer, UnitFamily, UnitFamilyType(..))


type alias State =
    { baseUnits : UnitStates }


type alias UnitStates =
    BaseUnitDataContainer UnitState


type alias UnitState =
    { count : Int
    , selected : Int
    , highestAllowed : Int
    }


type Msg
    = NewCiv (Maybe Civilization)


init : State
init =
    let
        unitStateInit : UnitState
        unitStateInit =
            { count = 0, selected = 0, highestAllowed = 0 }
    in
    { baseUnits =
        { militia = unitStateInit
        , spearman = unitStateInit
        , archer = unitStateInit
        }
    }


update : Msg -> State -> State
update msg state =
    case msg of
        NewCiv maybeCivilization ->
            case maybeCivilization of
                Just c ->
                    let
                        civ : CivilizationData
                        civ =
                            civilizationData c

                        setHighestTo : UnitState -> Int -> UnitState
                        setHighestTo unitState int =
                            { count = unitState.count
                            , selected = clamp 0 int unitState.selected
                            , highestAllowed = int
                            }
                    in
                    { baseUnits = UnitData.zip setHighestTo state.baseUnits civ.baseUnits }

                Nothing ->
                    let
                        reset : UnitState -> UnitState
                        reset unitState =
                            { count = unitState.count
                            , selected = unitState.selected
                            , highestAllowed = 0
                            }
                    in
                    { baseUnits = UnitData.map reset state.baseUnits }
