module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List


type Region
    = Yellow
    | Red
    | Blue


encodeRegion : Region -> String
encodeRegion region =
    case region of
        Yellow ->
            "yellow"

        Red ->
            "red"

        Blue ->
            "blue"


renderTile : Model -> ( Int, Region ) -> Html Msg
renderTile model ( index, region ) =
    let
        stringIndex =
            index |> toString

        className =
            "tile-" ++ stringIndex

        hoveredClass =
            case model.hovered of
                Just hoveredRegion ->
                    if hoveredRegion == region then
                        "hovered"
                    else
                        ""

                Nothing ->
                    ""
    in
        div
            [ class className
            , class "tile"
            , class (encodeRegion region)
            , class hoveredClass
            , onMouseEnter (EnterRegion region)
            , onMouseLeave LeaveRegion
            ]
            []


tiles : Model -> Html Msg
tiles model =
    [ Yellow, Yellow, Yellow, Red, Red, Red, Red, Blue, Blue, Blue, Blue ]
        |> List.map2 (,) (List.range 1 11)
        |> List.map (renderTile model)
        |> div [ class "tiles" ]


init : Model
init =
    { hovered = Nothing }


type Msg
    = EnterRegion Region
    | LeaveRegion
    | NoOp


type alias Model =
    { hovered : Maybe Region
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        EnterRegion region ->
            { model | hovered = Just region }

        LeaveRegion ->
            { model | hovered = Nothing }

        NoOp ->
            model


view : Model -> Html Msg
view model =
    tiles model


main : Program Never Model Msg
main =
    beginnerProgram
        { view = view
        , update = update
        , model = init
        }
