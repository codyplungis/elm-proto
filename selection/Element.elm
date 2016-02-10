module Element where

import Html exposing (..)
import Html.Attributes exposing (..)

import Selection

type alias Model =
  Selection.Selection
    { text : String
    }

init : String -> Model
init txt =
  { text = txt
  , selected = False
  }

view : Model -> Html
view model =
  let
    isSelected =
      if model.selected
      then [("font-size", "1.5em")]
      else []
  in
  li
    [ style isSelected
    ]
    [ text model.text
    ]

toString : Maybe Model -> String
toString maybeModel =
  case maybeModel of
    Nothing ->
      "N/A"
    Just model ->
      model.text
