module Table where

import Html exposing (..)
import Html.Attributes exposing (..)

import Controls
import TableElement

type alias Model =
  { items: List TableElement.Model
  , controls: Controls.Model
  , rows: Int
  , columns: Int
  , uniqueId: Int
  }

init: Controls.Model -> Int -> Int -> Model
init cm r c =
  let
    items = List.map (TableElement.init) [1..r*c]
  in
    Model items cm r c (r*c+1)

type Action
  = UpdateRows Int
  | UpdateColumns Int
  | Click Int TableElement.Action

update: Action -> Model -> Model
update action model =
  case action of
    UpdateRows r ->
      let
        newItems =
          if model.rows < r
          then model.items ++ List.map (\x -> TableElement.init (model.uniqueId + x)) [1..model.columns]
          else if model.rows > r
            then List.take (r*model.columns) model.items
            else model.items
      in
      { model | rows = r, items = newItems, uniqueId = model.uniqueId + model.columns }
    UpdateColumns c ->
      let
        newItems =
          if model.columns < c
          then List.concat <| List.map (\r -> (List.take model.columns (List.drop ((r-1) * model.columns) model.items)) ++ [TableElement.init (model.uniqueId + r)] ) [1..model.rows]
          else if model.columns > c
            then List.concat <| List.map (\r -> List.take c (List.drop ((r-1) * model.columns) model.items) ) [1..model.rows]
            else model.items
      in
      { model | columns = c, items = newItems, uniqueId = model.uniqueId + model.columns }
    Click id act ->
      let
        newItems = List.map (\m -> if m.id == id then (TableElement.update (TableElement.Update model.controls.text) m) else m) model.items
      in
      { model | items = newItems }

view: Signal.Address Action -> Model -> Html
view address model =
  div
  [ style [("flex", "1 0 auto")] ]
  [ table []
    [ tbody [] (List.map (mkRow address model.items model.columns) [1..model.rows] )
    ]
  ]

mkRow: Signal.Address Action -> List TableElement.Model -> Int -> Int -> Html
mkRow addr models c r =
  let
    row = List.take c (List.drop ((r-1)*c) models)
  in
  tr []
    (List.map (mkItem addr row) [1..c])

mkItem: Signal.Address Action -> List TableElement.Model -> Int -> Html
mkItem address models i =
  let
    m = List.head (List.drop (i - 1) models)
    model = Maybe.withDefault (TableElement.init -1) m
  in
  td []
    [ TableElement.view (Signal.forwardTo address (Click model.id)) model
    ]
