module Main exposing (main)

import Browser
import Html.Styled exposing (Html, div, toUnstyled)
import Html.Styled.Lazy exposing (lazy)
import PageElements.Civilization as Civilization
import PageElements.Unit as Unit exposing (Msg(..))


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
    , unitState : Unit.State
    }



-- Initial model


init : () -> ( Model, Cmd Msg )
init _ =
    ( { civilizationState = Civilization.init
      , unitState = Unit.init
      }
    , Cmd.none
    )



-- Update


type Msg
    = UpdateCiv Civilization.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateCiv civMsg ->
            let
                newCivilizationState : Civilization.State
                newCivilizationState =
                    Civilization.update civMsg model.civilizationState

                newUnitState : Unit.State
                newUnitState =
                    Unit.update (NewCiv newCivilizationState) model.unitState
            in
            ( { model
                | civilizationState = newCivilizationState
                , unitState = newUnitState
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
