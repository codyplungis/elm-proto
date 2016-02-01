module TableRow where

import Html exposing (..)

import TableElement

type alias Model =
  { columns: List TableElement.Model
  , index: Int
  }

init: Int -> String -> Int -> Model
init c t i =
  Model (List.map (TableElement.init t) [1..c]) i

type Action
  = Click TableElement.Model TableElement.Action
  | UpdateColumns Int

update: Action -> Model -> String-> Model
update action model txt =
  case action of
    Click c act ->
      let
        newColumns = List.map (\col -> if col == c then (TableElement.update act c txt) else col) model.columns
      in
      { model | columns = newColumns }
    UpdateColumns numCols ->
      let
        cols = model.columns
        newColumns =
          if numCols > List.length cols
          then cols ++ [TableElement.init txt numCols]
          else if numCols < List.length cols
            then List.take numCols cols
            else cols
      in
      {model | columns = newColumns}

view: Signal.Address Action -> Model -> Html
view address model =
  tr [] (List.map (mkElement address) model.columns)

mkElement: Signal.Address Action -> TableElement.Model -> Html
mkElement address model =
  TableElement.view (Signal.forwardTo address (Click model)) model
