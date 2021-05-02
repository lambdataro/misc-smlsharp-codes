structure Tree =
struct
  datatype 'a tree
    = EmptyTree
    | Node of 'a * 'a tree * 'a tree

  fun copyTree EmptyTree = EmptyTree
    | copyTree (Node (value, left, right)) =
        Node (value, copyTree left, copyTree right)

  fun height EmptyTree = 0
    | height (Node (_, left, right)) =
        1 + Int.max (height left, height right)

  fun size EmptyTree = 0
    | size (Node (_, left, right)) =
        1 + size left + size right
  
  fun sum EmptyTree = 0
    | sum (Node (value, left, right)) =
        value + sum left + sum right

  fun traverse EmptyTree = []
    | traverse (Node (value, left, right)) =
        value :: traverse left @ traverse right

  fun mkTree 0 = EmptyTree
    | mkTree n = Node (n, mkTree (n - 1), mkTree (n - 1))
end
