module Main exposing (main)

import Browser
import Data.CivilizationData exposing (Civilization)
import Html.Styled exposing (Html, div, toUnstyled)
import Html.Styled.Lazy exposing (lazy)
import PageElements.Civilization as Civilization


main =
    Browser.element
        { init = init
        , view = view >> toUnstyled
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { civilizationState : Civilization.State
    }



-- Initial model


init : () -> ( Model, Cmd Msg )
init _ =
    ( { civilizationState = Civilization.init }
    , Cmd.none
    )



-- Update


type Msg
    = UpdateCiv Civilization.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateCiv civMsg ->
            ( { model
                | civilizationState = Civilization.update civMsg model.civilizationState
              }
            , Cmd.none
            )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []



-- View


view : Model -> Html Msg
view model =
    div
        []
        [ lazy Civilization.show model.civilizationState
            |> Html.Styled.map UpdateCiv
        ]
