module Container where

import Html exposing (..)
import Html.Attributes exposing (..)

import Table
import Controls

type alias Model =
  { table: Table.Model
  , controls: Controls.Model
  }

init: Model
init =
  let
    c = Controls.init
  in
  { table = Table.init c.rows c.columns c.text
  , controls = c
  }

type Action
  = Controls Controls.Action
  | Table Table.Action

update: Action -> Model -> Model
update action model =
  case action of
    Controls act ->
      let
        c = Controls.update act model.controls
        newTable =
          if c.rows /= model.controls.rows
          then Table.update (Table.UpdateRows c.rows c.columns) model.table c.text
          else if c.columns /= model.controls.columns
          then Table.update (Table.UpdateColumns c.columns) model.table c.text
          else model.table
      in
      { model | table = newTable, controls = c }
    Table a ->
      { model | table = Table.update a model.table model.controls.text}

view: Signal.Address Action -> Model -> Html
view address model =
  div [ mainStyle ]
  [ Controls.view (Signal.forwardTo address Controls) model.controls
  , Table.view (Signal.forwardTo address Table) model.table
  ]

mainStyle: Attribute
mainStyle =
  style
    [ ("font", "14px / 20px Verdana, Arial, Helvetica, sans-serif")
    , ("display", "flex")
    ]
