module Table where

import Html exposing (..)
import Html.Attributes exposing (..)

import TableRow

type alias Model =
  { rows: List TableRow.Model
  }

init: Int -> Int -> String-> Model
init r c t =
  let
    rows = List.map (TableRow.init c t) [1..r]
  in
    Model rows

type Action
  = UpdateRows Int Int
  | UpdateColumns Int
  | Click TableRow.Model TableRow.Action

update: Action -> Model -> String -> Model
update action model txt =
  case action of
    UpdateRows r c ->
      let
        newRows =
          if r > List.length model.rows
          then model.rows ++ [TableRow.init c txt r]
          else if r < List.length model.rows
            then List.take r model.rows
            else model.rows
      in
      {model | rows = newRows}
    UpdateColumns c ->
      { model | rows = List.map (\r -> TableRow.update (TableRow.UpdateColumns c) r txt) model.rows }
    Click row act ->
      let
        newRows = List.map (\r -> if r == row then (TableRow.update act row txt) else r) model.rows
      in
      { model | rows = newRows }

view: Signal.Address Action -> Model -> Html
view address model =
  div
  [ style [("flex", "1 0 auto")] ]
  [ table []
    [ tbody [] (List.map (mkRow address) model.rows)
    ]
  ]

mkRow: Signal.Address Action -> TableRow.Model -> Html
mkRow address m =
  TableRow.view (Signal.forwardTo address (Click m)) m
