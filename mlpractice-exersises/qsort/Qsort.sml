structure Qsort =
struct
  type size_t = word64
  
  fun 'a#unboxed qsort (array, compare) =
    let
      val qsort_c =
        _import "qsort": ('a array, size_t, 'a size, ('a ptr, 'a ptr) -> int) -> ()
    in
      qsort_c
        (
          array,
          Word64.fromInt (Array.length array),
          _sizeof('a),
          compare
        )
    end

  fun 'a#unboxed quickSort (array, compare) =
    qsort
      (
        array,
        fn (p1, p2) =>
          let
            val n1 = Pointer.load p1
            val n2 = Pointer.load p2
          in
            case compare (n1, n2) of
              EQUAL => 0
            | LESS => ~1
            | GREATER => 1 
          end
      )
end
