structure ReadIntStream =
struct
  fun readIntStream radix fileName =
    let
      val inStream = TextIO.openIn fileName
      fun loop stream =
        case (Int.scan radix TextIO.StreamIO.input1 stream) of
          NONE => []
        | SOME (i, stream) => i :: loop stream
    in
      (loop (TextIO.getInstream inStream))
      before
      (TextIO.closeIn inStream) 
    end

  val readBinStream = readIntStream StringCvt.BIN
  val readDecStream = readIntStream StringCvt.DEC
  val readOctStream = readIntStream StringCvt.OCT
  val readHexStream = readIntStream StringCvt.HEX
end
