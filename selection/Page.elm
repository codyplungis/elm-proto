module Page where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Element
import Selection

type alias Model =
  List Element.Model

init : Model
init =
  Selection.init
    [ Element.init "First"
    , Element.init "Second"
    , Element.init "Third"
    , Element.init "Fourth"
    , Element.init "Fifth"
    , Element.init "Sixth"
    , Element.init "Seventh"
    , Element.init "Eighth"
    , Element.init "Nineth"
    , Element.init "Tenth"
    ]

type Action
  = SelectNext
  | SelectPrevious

update : Action -> Model -> Model
update action model =
  case action of
    SelectNext ->
      Selection.selectNext model
    SelectPrevious ->
      Selection.selectPrev model

view : Signal.Address Action -> Model -> Html
view address model =
  let
    content = List.map Element.view model
    next = Element.toString (Selection.getNext model)
    current = Element.toString (Selection.getSelected model)
    prev = Element.toString (Selection.getPrev model)
  in
  div
    []
    [ h1 [] [ text "Selection Prototype" ]
    , button
        [ onClick address SelectPrevious ]
        [ text ("Previous: " ++ prev) ]
    , span
        [ style [("padding", "10px")] ]
        [ text ("Current: " ++ current) ]
    , button
        [ onClick address SelectNext ]
        [ text ("Next: " ++ next) ]
    , ul
        []
        content
    ]
