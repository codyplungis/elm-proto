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
  { table = Table.init c c.rows c.columns
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
          then Table.update (Table.UpdateRows c.rows) model.table
          else if c.columns /= model.controls.columns
          then Table.update (Table.UpdateColumns c.columns) model.table
          else model.table
      in
      { model | table = newTable, controls = c }
    Table act ->
      let
        t = model.table
      in
      { model | table = Table.update act { t | controls = model.controls } }

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
