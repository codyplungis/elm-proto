module Counter (Model, init, Action, update, view) where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

type alias Model = Int


init : Int -> Model
init count = count

type Action = Increment | Decrement


update : Action -> Model -> Model
update action model =
  case action of
    Increment ->
      if model < 10 then model + 1 else model
    Decrement ->
      if model > 1 then model - 1 else model

view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ style
      [ ("display", "inline")
      , ("padding-left", "10px")
      ]
    ]
    [ if model == 1
      then span [] []
      else button [ onClick address Decrement ] [ text "-" ]
    , div [ countStyle ] [ text (toString model) ]
    , if model == 10
      then span [] []
      else button [ onClick address Increment ] [ text "+" ]
    ]


countStyle : Attribute
countStyle =
  style
    [ ("font-family", "monospace")
    , ("display", "inline-block")
    , ("width", "50px")
    , ("text-align", "center")
    ]
