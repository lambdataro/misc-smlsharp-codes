structure Cpu =
struct
  fun cpuNext board color =
    let
      val possible = Game.possible board Game.WHITE
      (* 置ける場所のどこかに置く *)
      val idx = MT.genrand64_int64 () mod (Word64.fromInt (length possible))
    in
      List.nth (possible, Word64.toInt idx)
    end
end
