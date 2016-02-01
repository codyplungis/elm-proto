module TableElement where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

type alias Model =
  { text: String
  , clickCount: Int
  , index: Int
  }

init: String -> Int -> Model
init text i =
  Model text 0 i

type Action
  = Count

update: Action -> Model -> String -> Model
update action model txt =
  case action of
    Count ->
      { model | text = txt, clickCount = model.clickCount + 1 }


view: Signal.Address Action -> Model -> Html
view address model =
  td
    [ tdStyle
    , onClick address Count
    ]
    [ text model.text
    , p [] [ text (toString model.clickCount) ]
    ]

tdStyle : Attribute
tdStyle =
  style
    [ ("border", "1px solid black")
    , ("width", "100px")
    , ("height", "100px")
    ]
