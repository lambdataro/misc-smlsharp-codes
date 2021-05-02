val r = FunctionTest.sum 1000000000
val _ = print (Int64.toString r ^ "\n")

val sum10 = FunctionTest.sum 10
val power23 = FunctionTest.power 2 3
val cube4 = FunctionTest.cube 4
val SigmaCube5 = FunctionTest.Sigma FunctionTest.cube 5

val _ = Dynamic.pp
  { 
    sum10 = sum10,
    power23 = power23,
    cube4 = cube4,
    SigmaCube5 = SigmaCube5
  }
