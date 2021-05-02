structure MakeDict =
struct
  datatype ('key, 'value) dict
    = EmptyDict
    | Node of ('key * 'value) * ('key, 'value) dict * ('key, 'value) dict 
  
  exception Empty

  fun makeDict comp =
    let
      val empty = EmptyDict

      fun find (dict, key) =
        case dict of
          EmptyDict => raise Empty
        | Node ((k, v), left, right) =>
          (
            case comp (k, key) of
              EQUAL => v
            | LESS => find (left, key)
            | GREATER => find (right, key)
          )
              
      fun enter ((key, value), dict) = 
        case dict of
          EmptyDict => Node ((key, value), EmptyDict, EmptyDict)
        | Node ((k, v), left, right) =>
          (
            case comp (k, key) of
              EQUAL => Node ((k, value), left, right)
            | LESS => Node ((k, v), enter ((key, value), left), right)
            | GREATER => Node ((k, v), left, enter ((key, value), right))
          )
    in
      { find = find, empty = empty, enter = enter }
    end
end
