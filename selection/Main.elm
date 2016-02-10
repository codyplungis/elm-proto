module Main where

import StartApp.Simple exposing (start)
import Html
import Page exposing (init, update, view)

main : Signal Html.Html
main =
  start
    { model = init
    , update = update
    , view = view
    }
