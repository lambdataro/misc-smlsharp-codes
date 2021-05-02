structure PrintInterface =
struct
  fun makePrintString name =
    "structure " ^ name ^ " = " ^ name ^ ";"

  fun execPrint name =
    let
      val commandString =
        "(smlsharp <<EOF\n"
          ^ makePrintString name
          ^ "\nEOF\n) | tail -n +2 > Results/"
          ^ name
          ^ ".txt"
    in
      (
        OS.Process.system commandString;
        ()
      )
    end
end
