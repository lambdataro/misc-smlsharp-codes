structure Main =
struct
  type schema =
    { files: { name: string, suffix: string, size: int} list}
  
  exception Abort of string

  datatype mode = ScatterPlot of {xkey: string, ykey: string}
                | Histogram of {key: string}

  fun parseArgs (name, args) =
    case args of 
        [x] =>
          { mode = Histogram {key = x}, pdfFile = "out.pdf", dbFile = "db"}
      | [x, y] =>
          { mode = ScatterPlot {xkey = x, ykey = y}, pdfFile = "out.pdf", dbFile = "db" }
      | [x, y, pdfFile] =>
          { mode = ScatterPlot {xkey = x, ykey = y}, pdfFile = pdfFile, dbFile = "db" }
      | [x, y, pdfFile, dbFile] =>
          { mode = ScatterPlot {xkey = x, ykey = y}, pdfFile = pdfFile, dbFile = dbFile }
      | _ =>
          raise Abort ("usage: " ^ name ^ " xkey ykey [pdf [db]]\n")

  fun createQuery {xkey, ykey, ...} =
    fn db => _sql select #x.size as x, #y.size as y
                  from #db.files as x
                  join #db.files as y
                  on #x.name = #y.name
                where (#x.suffix = xkey and #y.suffix = ykey)
  
  fun fetchData {dbFile, ...} query =
    let
      val db = _sqlserver SQL.sqlite3 dbFile : schema
      val c = SQL.connect db
      val data = SQL.fetchAll (query c)
      val _ = SQL.closeConn c
    in
      map (fn {x, y} => {x = real x, y = real y}) data
    end

  fun createHistogramQuery {key, ...} =
    fn db => _sql select #x.size as x from #db.files as x where #x.suffix = key

  fun fetchHistogramData {dbFile, ...} query =
    let
      val db = _sqlserver SQL.sqlite3 dbFile : schema
      val c = SQL.connect db
      val data = SQL.fetchAll (query c)
      val _ = SQL.closeConn c
    in
      map (fn {x} => {x = real x}) data
    end

  fun main (name, args) =
    let
      val arg as {mode, pdfFile, ...} = parseArgs (name, args)
      val graph = 
        case mode of
          Histogram {key} =>
            let
              val query = createHistogramQuery {key = key}
              val data = fetchHistogramData arg (_sql db => select...(query db))
            in
              Graph.plotHistogram data
            end
        | ScatterPlot {xkey, ykey} =>
            let
              val query = createQuery {xkey = xkey, ykey = ykey}
              val data = fetchData arg (_sql db => select...(query db))
            in
              Graph.plot data
            end
    in
      Draw.toPDF pdfFile graph;
      OS.Process.success
    end
    handle Abort s =>
      (TextIO.output (TextIO.stdErr, s);
      OS.Process.failure)
end
