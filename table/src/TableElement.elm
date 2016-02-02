module TableElement where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

type alias Model =
  { text: String
  , clickCount: Int
  , id: Int
  }

init: Int -> Model
init i =
  Model "empty" 0 i

type Action
  = Click
  | Update String

update: Action -> Model -> Model
update action model =
  case action of
    Click ->
      { model | clickCount = model.clickCount + 1 }
    Update txt ->
      { model | text = txt, clickCount = model.clickCount + 1}


view: Signal.Address Action -> Model -> Html
view address model =
  div
    [ divStyle
    , onClick address Click
    ]
    [ text (toString model.id)
    , p [] [ text model.text ]
    , p [] [ text (toString model.clickCount) ]
    ]

divStyle : Attribute
divStyle =
  style
    [ ("border", "1px solid black")
    , ("width", "100px")
    , ("height", "100px")
    ]
