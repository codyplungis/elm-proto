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
  Model (Table.init c.rows c.columns) c

type Action = Controls Controls.Action

update: Action -> Model -> Model
update action model =
  case action of
    Controls act ->
      let
        c = Controls.update act model.controls
      in
      { model | table = (Table.Model c.rows c.columns), controls = c}

view: Signal.Address Action -> Model -> Html
view address model =
  div [ mainStyle ]
  [ Controls.view (Signal.forwardTo address Controls) model.controls
  , Table.view model.table
  ]

mainStyle: Attribute
mainStyle =
  style
    [ ("font", "14px / 20px Verdana, Arial, Helvetica, sans-serif")
    , ("display", "flex")
    ]
