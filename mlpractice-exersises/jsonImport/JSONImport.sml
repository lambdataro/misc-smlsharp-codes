structure JSONImport =
struct
  fun downloadJson url =
    let
      val tmpFile = OS.FileSys.tmpName ()
      val cmd =
        "wget --inet4-only -o wget.log -O " ^ tmpFile ^ " "
          ^ "\"" ^ url ^ "\""
      val _ = OS.Process.system cmd  
    in
      Dynamic.fromJsonFile tmpFile
      before OS.FileSys.remove tmpFile
    end
  
  fun 'a#reify castLike D (sample : 'a) =
    Dynamic.view (_dynamic D as 'a Dynamic.dyn)
  
  fun 'a#reify import {url, sample : 'a, ...} =
    castLike (downloadJson url) sample
end
