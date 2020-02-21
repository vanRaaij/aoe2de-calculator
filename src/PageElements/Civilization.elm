module PageElements.Civilization exposing
    ( CivState
    , Msg
    , init
    , show
    , update
    )

import Css exposing (display, fixed, fontSize, hidden, inlineBlock, left, overflowX, padding, pct, position, px, small, textAlign, top, width, zero)
import Data.CivilizationData exposing (Civilization)
import Dict exposing (Dict)
import Html.Styled exposing (Html, datalist, div, h1, input, option, text)
import Html.Styled.Attributes exposing (css, id, list, placeholder, size, type_, value)
import Html.Styled.Events exposing (onInput)
import PageElements.Unit exposing (UnitStateUpdateData, baseUnitUpdateData)


type alias CivState =
    { selectedCiv : Maybe String
    }


init : CivState
init =
    { selectedCiv = Nothing
    }


civs : Dict String Civilization
civs =
    toCivDict Data.CivilizationData.all


toCivDict : List Civilization -> Dict String Civilization
toCivDict list =
    list
        |> List.map (\c -> ( c.name, c ))
        |> Dict.fromList


type Msg
    = SelectCiv String


show : CivState -> Html Msg
show { selectedCiv } =
    let
        s =
            case selectedCiv of
                Nothing ->
                    ""

                Just a ->
                    case Dict.get a civs of
                        Just v ->
                            v.description

                        Nothing ->
                            "Error"
    in
    div
        [ css
            [ display inlineBlock
            , position fixed
            , width (pct 20)
            , padding (px 10)
            , top zero
            , left zero
            , overflowX hidden
            , textAlign left
            ]
        ]
        [ h1 [] [ text "Civilisation" ]
        , Dict.keys civs |> civSelector "Please select a civilisation"
        , div
            [ css
                [ fontSize small ]
            ]
            [ text s ]
        ]


civSelector : String -> List String -> Html Msg
civSelector p options =
    div []
        [ input [ type_ "text", size 28, placeholder p, onInput SelectCiv, list "civs" ] []
        , options
            |> List.map toOption
            |> datalist [ id "civs" ]
        ]


toOption : String -> Html Msg
toOption s =
    option [ value s ] [ text s ]


update : Msg -> CivState -> ( CivState, UnitStateUpdateData, Cmd Msg )
update msg civState =
    case msg of
        SelectCiv selectedCiv ->
            let
                civ =
                    Dict.get selectedCiv civs

                newSelectedCiv =
                    if String.isEmpty selectedCiv then
                        Nothing

                    else
                        case civ of
                            Just c ->
                                Just c.name

                            Nothing ->
                                civState.selectedCiv

                adjustmentData =
                    case civ of
                        Just c ->
                            c.baseUnits

                        Nothing ->
                            baseUnitUpdateData
            in
            ( { civState
                | selectedCiv = newSelectedCiv
              }
            , { baseUnits = adjustmentData }
            , Cmd.none
            )
