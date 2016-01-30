module Table where

import Html exposing (..)
import Html.Attributes exposing (..)

import TableRow

type alias Model =
  { rows: Int
  , columns: Int
}

init: Int -> Int -> Model
init r c =
  Model r c

view: Model -> Html
view model =
  div
  [ style [("flex", "1 0 auto")] ]
  [ table []
    [ tbody [] (List.map (createRow model) [1..model.rows])
    ]
  ]

createRow: Model -> Int -> Html
createRow model _ =
  TableRow.view (TableRow.Model model.columns)
