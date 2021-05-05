structure Cpu =
struct
  fun cpuNext board color =
    (* 置ける場所の一番先頭に置く *)
    hd (Game.possible board Game.WHITE)
end
