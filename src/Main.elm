module Main exposing (main)

import Array exposing (Array)
import Browser
import Html.Styled exposing (Html, div, toUnstyled)
import Html.Styled.Lazy exposing (lazy)
import PageElements.Civilization as Civilization exposing (CivState)
import PageElements.Unit as Unit exposing (UnitState)


main =
    Browser.element
        { init = init
        , view = view >> toUnstyled
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { civState : CivState
    , unitStates : Array UnitState
    }



-- Initial model


init : () -> ( Model, Cmd Msg )
init _ =
    ( { civState = Civilization.init
      , unitStates = Unit.init
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
                ( civState, unitUpdateData, cmdMsg ) =
                    Civilization.update civMsg model.civState

                unitStates =
                    Unit.update model.unitStates unitUpdateData
            in
            ( { model
                | civState = civState
                , unitStates = unitStates
              }
            , Cmd.map UpdateCiv cmdMsg
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
        [ lazy Civilization.show model.civState
            |> Html.Styled.map UpdateCiv
        ]
