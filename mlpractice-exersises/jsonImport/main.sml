val jpNpatients =
  {
    url = "https://data.corona.go.jp/converted-json/covid19japan-npatients.json",
    contents = "累積陽性者数",
    sample = [{date = "", npatients = 0, adpatients = 0}]
  }

val _ = Dynamic.pp (JSONImport.import jpNpatients)
