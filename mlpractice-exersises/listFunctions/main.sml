val N = 6

val L1 = List.tabulate (N, fn x => x + 1)
val L2 = rev L1

val L1L2 = ListFunctions.append (L1, L2)
val L2L1List = [L2, L1]
val L2L1ListConcat = ListFunctions.concat L2L1List
val L1L2Zip = ListFunctions.zip (L1, L2)
val L1L2ZipFilter = ListFunctions.filter (fn (a, b) => a < b) L1L2Zip
val listPair = ListFunctions.unzip L1L2ZipFilter

val resultRecord =
  {
    1_N = N,
    2_L1 = L1,
    3_L2 = L2,
    4_L1L2 = L1L2,
    5_L2L1List = L2L1List,
    6_L2L1ListConcat = L2L1ListConcat,
    7_L1L2Zip = L1L2Zip,
    8_L1L2ZipFilter = L1L2ZipFilter,
    9_listPair = listPair
  }

val _ = Dynamic.pp resultRecord
