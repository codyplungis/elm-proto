module Controls where

import Html exposing (..)
import Html.Attributes exposing (..)

import Counter

type alias Model =
  { rows: Counter.Model
  , columns: Counter.Model
  , text: String
  }

init: Model
init =
  Model (Counter.init 2) (Counter.init 2) "blarg"

type Action = Rows Counter.Action | Columns Counter.Action

update: Action -> Model -> Model
update action model =
  case action of
    Rows act ->
      {model | rows = Counter.update act model.rows}
    Columns act ->
      {model | columns = Counter.update act model.columns}

view: Signal.Address Action -> Model -> Html
view address model =
  div
    [ style [("flex", "1 0 auto")]
    ]
    [ h3 [] [ text ("text " ++ model.text) ]
    , div []
      [ text "Rows"
      , Counter.view (Signal.forwardTo address Rows) model.rows
      ]
    , div []
      [ text "Columns"
      , Counter.view (Signal.forwardTo address Columns) model.columns
      ]
    ]
