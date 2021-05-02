val N = 3

val T = Tree.mkTree N

val _ = Dynamic.pp
  {
    heightT = Tree.height T,
    sizeT = Tree.size T,
    sumT = Tree.sum T,
    traverseT = Tree.traverse T
  }
