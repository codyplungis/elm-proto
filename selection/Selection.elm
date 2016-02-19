module Selection where

import List.Extra
import Array

type alias Selectable a = { a | selected: Bool }

init : List (Selectable a) -> List (Selectable a)
init list =
  Array.toList (selectAt 0 (Array.fromList list))

selectNext : List (Selectable a) -> List (Selectable a)
selectNext list =
  go 1 list

selectPrev : List (Selectable a) -> List (Selectable a)
selectPrev list =
  go -1 list

getSelected : List (Selectable a) -> Maybe (Selectable a)
getSelected list =
  at ((getIndex list) + 0) list

getNext : List (Selectable a) -> Maybe (Selectable a)
getNext list =
  at ((getIndex list) + 1) list

getPrev : List (Selectable a) -> Maybe (Selectable a)
getPrev list =
  at ((getIndex list) - 1) list

go : Int -> List (Selectable a) -> List (Selectable a)
go delta list =
  let
    index = getIndex list
  in
  if (index < 0) || (index + delta < 0) || (index + delta == List.length list)
  then list
  else Array.toList (selectAt (index + delta) (unselectAt index (Array.fromList list)))

at : Int -> List (Selectable a) -> Maybe (Selectable a)
at index list =
  Array.get index (Array.fromList list)

getIndex : List (Selectable a) -> Int
getIndex list =
  Maybe.withDefault -1 (List.Extra.findIndex .selected list)

selectAt : Int -> Array.Array (Selectable a) -> Array.Array (Selectable a)
selectAt index arr =
  setAt index True arr

unselectAt : Int -> Array.Array (Selectable a) -> Array.Array (Selectable a)
unselectAt index arr =
  setAt index False arr

setAt : Int -> Bool -> Array.Array (Selectable a) -> Array.Array (Selectable a)
setAt index val arr =
  let
    item = Array.get index arr
  in
  case item of
    Nothing ->
      arr
    Just thing ->
      Array.set index { thing | selected = val } arr
