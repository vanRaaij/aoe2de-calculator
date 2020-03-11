module PageElements.Unit exposing
    ( Msg(..)
    , State
    , init
    , show
    , update
    )

import CssExtensions.CssStyles exposing (mainContent)
import Data.BuildingData as BuildingData exposing (Building(..))
import Data.CivilizationData exposing (Civilization, CivilizationData, civilizationData)
import Data.UnitData as UnitData exposing (BaseUnitData, BaseUnitDataContainer, UnitFamily, UnitFamilyType(..), unitData)
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css)
import Maybe.Extra exposing (values)


type alias State =
    UnitStates


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
    { militia = unitStateInit
    , spearman = unitStateInit
    , archer = unitStateInit
    , skirmisher = unitStateInit
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
                    UnitData.zip setHighestTo state civ.baseUnits

                Nothing ->
                    let
                        reset : UnitState -> UnitState
                        reset unitState =
                            { count = unitState.count
                            , selected = unitState.selected
                            , highestAllowed = 0
                            }
                    in
                    UnitData.map reset state


show : State -> Html msg
show state =
    div [ css [ mainContent ] ] <| List.map (showBuilding state) [ Barracks, ArcheryRange ]


showBuilding : State -> Building -> Html msg
showBuilding state building =
    let
        units : List ( UnitFamily, UnitState )
        units =
            List.map
                (\family -> ( unitData family, UnitData.getFromUnit family state ))
                (BuildingData.production building)
    in
    div [] <| values <| List.map showUnit units


showUnit : ( UnitFamily, UnitState ) -> Maybe (Html msg)
showUnit ( unitFamilyType, { highestAllowed, selected } as unitState ) =
    let
        getUnit : Int -> UnitFamily -> Maybe String
        getUnit int unitState_ =
            Maybe.map .name (List.head unitState_.units)
    in
    if highestAllowed < selected || highestAllowed == 0 then
        Nothing

    else
        unitFamilyType
            |> getUnit selected
            |> Maybe.map text
