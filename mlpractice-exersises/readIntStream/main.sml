val binL = ReadIntStream.readBinStream "binStreamFile.txt"
val decL = ReadIntStream.readDecStream "decStreamFile.txt"
val hexL = ReadIntStream.readHexStream "hexStreamFile.txt"
val octL = ReadIntStream.readOctStream "octStreamFile.txt"

val _ = Dynamic.pp { binL = binL, decL = decL, hexL = hexL, octL = octL }
