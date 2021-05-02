fun init64 () =
  MT.init_genrand64
    (Word64.fromLargeInt (Time.toSeconds (Time.now ())))

val len = 5
val init64 = init64 ()

val randInt63 =
  List.tabulate (len, fn x => MT.genrand64_int63 ())
val randWord64 =
  List.tabulate (len, fn x => MT.genrand64_int64 ())
val randReal1 =
  List.tabulate (len, fn x => MT.genrand64_real1 ())
val randReal2 =
  List.tabulate (len, fn x => MT.genrand64_real2 ())
val randReal3 =
  List.tabulate (len, fn x => MT.genrand64_real3 ())
val _ = Dynamic.pp
  { 
    randIntt63 = randInt63,
    randWord64 = randWord64,
    randReal1 = randReal1,
    randReal2 = randReal2,
    randReal3 = randReal3
  }

fun compare (p1, p2) =
  let
    val n1 = Pointer.load p1
    val n2 = Pointer.load p2
  in
    if n1 > n2 then 1
    else if n1 < n2 then ~1
    else 0
  end

fun genrand64_int () =
  let
    val maxInt =
      case Int.maxInt of
        NONE => 10000
      | SOME value => Int64.fromInt value
  in
    Int64.toInt (Int64.mod (MT.genrand64_int63 (), maxInt))
  end

val intArray = Array.tabulate (len, fn x => genrand64_int())
val realArray = Array.tabulate (len, fn x => MT.genrand64_real1 ())

val _ = Qsort.qsort (intArray, compare)
val _ = Qsort.qsort (realArray, compare)

val intArray2 = Array.tabulate (len, fn x => genrand64_int())
val realArray2 = Array.tabulate (len, fn x => MT.genrand64_real1 ())

val _ = Qsort.quickSort (intArray2, Int.compare)
val _ = Qsort.quickSort (realArray2, Real.compare)

val _ = Dynamic.pp
  {
    intArray = intArray,
    realArray = realArray,
    intArray2 = intArray2,
    realArray2 = realArray2
  }
