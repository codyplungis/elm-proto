module TableRow where

import Html exposing (..)

import TableElement

type alias Model =
  { columns: Int
}

init: Int -> Model
init c =
  Model c

view: Model -> Html
view model =
  tr [] (List.map (createElement "test") [1..model.columns])

createElement: String -> Int -> Html
createElement str _ =
  TableElement.view (TableElement.Model str)
