module PageElements.Civilization exposing
    ( Msg
    , State
    , init
    , show
    , update
    )

import Css exposing (display, fixed, fontSize, hidden, inlineBlock, left, overflowX, padding, pct, position, px, small, textAlign, top, width, zero)
import Css.CssStyles as CssStyles
import Data.CivilizationData as CivilizationData exposing (Civilization, CivilizationData, civilizationData)
import Html.Styled exposing (Html, datalist, div, h1, h2, h3, input, option, text)
import Html.Styled.Attributes exposing (css, id, list, placeholder, size, type_, value)
import Html.Styled.Events exposing (onInput)
import Maybe.Extra


type alias State =
    Maybe Civilization


type Msg
    = SelectCiv String


init : State
init =
    Nothing


show : State -> Html Msg
show selectedCiv =
    let
        civ : Maybe CivilizationData
        civ =
            Maybe.map civilizationData selectedCiv

        description : String
        description =
            Maybe.withDefault "" <|
                Maybe.map .description civ
    in
    div
        [ css [ CssStyles.sidebar ] ]
    <|
        Maybe.Extra.values
            [ Just <|
                div
                    []
                    [ h1 [] [ text "Civilisation" ]
                    , civSelector "Please select a civilisation" <| List.map .name CivilizationData.all
                    ]
            , Maybe.map civilizationInformationBlock civ
            ]


civilizationInformationBlock : CivilizationData -> Html Msg
civilizationInformationBlock civ =
    div []
        [ h3 [] [ text civ.name ]
        , div [ css [ fontSize small ] ] [ text civ.description ]
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


update : Msg -> State -> State
update msg currentState =
    case msg of
        SelectCiv name ->
            if name == "" then
                init

            else
                let
                    selectedCiv : Maybe Civilization
                    selectedCiv =
                        CivilizationData.civilizationDataBy .name name
                            |> Maybe.map .civilization
                in
                case selectedCiv of
                    Just c ->
                        Just c

                    Nothing ->
                        currentState
