module Controls where

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import Counter

type alias Model =
  { rows: Counter.Model
  , columns: Counter.Model
  , text: String
  }

init: Model
init =
  Model (Counter.init 2) (Counter.init 2) "abc"

type Action = Rows Counter.Action | Columns Counter.Action | Input String

update: Action -> Model -> Model
update action model =
  case action of
    Rows act ->
      {model | rows = Counter.update act model.rows}
    Columns act ->
      {model | columns = Counter.update act model.columns}
    Input text ->
      {model | text = text}

view: Signal.Address Action -> Model -> Html
view address model =
  div
    [ style [("flex", "1 0 auto")]
    ]
    [ div []
      [ text "Rows"
      , Counter.view (Signal.forwardTo address Rows) model.rows
      ]
    , div []
      [ text "Columns"
      , Counter.view (Signal.forwardTo address Columns) model.columns
      ]
    , input [ value model.text
            , on "input" targetValue (Signal.message address << Input)
            ] []
    ]
