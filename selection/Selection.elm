module Selection where

import List.Extra
import Array

type alias Selection a = { a | selected: Bool }

init : List { a | selected : Bool } -> List { a | selected : Bool }
init list =
  Array.toList (toggleAt 0 (Array.fromList list))

selectNext : List { a | selected : Bool } -> List { a | selected : Bool }
selectNext list =
  go 1 list

selectPrev : List { a | selected : Bool } -> List { a | selected : Bool }
selectPrev list =
  go -1 list

getSelected : List { a | selected : Bool } -> Maybe { a | selected : Bool }
getSelected list =
  at ((getIndex list) + 0) list

getNext : List { a | selected : Bool } -> Maybe { a | selected : Bool }
getNext list =
  at ((getIndex list) + 1) list

getPrev : List { a | selected : Bool } -> Maybe { a | selected : Bool }
getPrev list =
  at ((getIndex list) - 1) list

go : Int -> List { a | selected : Bool } -> List { a | selected : Bool }
go delta list =
  let
    index = getIndex list
  in
  if (index < 0) || (index + delta < 0) || (index + delta == List.length list)
  then list
  else Array.toList (toggleAt (index + delta) (toggleAt index (Array.fromList list)))

at : Int -> List { a | selected : Bool } -> Maybe { a | selected : Bool }
at index list =
  Array.get index (Array.fromList list)

getIndex : List { a | selected : Bool } -> Int
getIndex list =
  Maybe.withDefault -1 (List.Extra.findIndex selected list)

selected : { a | selected : Bool } -> Bool
selected item =
  item.selected

toggleAt : Int -> Array.Array { a | selected : Bool } -> Array.Array { a | selected : Bool }
toggleAt index arr =
  let
    item = Array.get index arr
  in
  case item of
    Nothing ->
      arr
    Just thing ->
      Array.set index { thing | selected = not thing.selected} arr
