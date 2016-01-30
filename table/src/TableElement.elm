module TableElement where

import Html exposing (..)
import Html.Attributes exposing (..)

type alias Model =
  { text: String
}

init: String -> Model
init text =
  Model text

view: Model -> Html
view model =
  td [ tdStyle ] [ text model.text ]

tdStyle : Attribute
tdStyle =
  style
    [ ("border", "1px solid black")
    , ("width", "100px")
    , ("height", "100px")
    ]
