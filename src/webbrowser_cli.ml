(*---------------------------------------------------------------------------
   Copyright (c) 2016 Daniel C. Bünzli. All rights reserved.
   SPDX-License-Identifier: ISC
  ---------------------------------------------------------------------------*)

open Cmdliner
open Rresult
open Bos

let browser =
  let env = Cmdliner.Cmd.Env.info "BROWSER" in
  let browser =
    let parse s = Result.map Option.some (OS.Env.cmd s) in
    let pp ppf = function
    | None -> Format.fprintf ppf "OS specific fallback"
    | Some cmd -> Cmd.pp ppf cmd
    in
    Arg.conv (parse, pp)
  in
  let doc =
    "The WWW browser command $(docv) to use. The value may be interpreted
     and massaged depending on the OS. On Darwin it is sufficient to
     specify the name of a known existing browser; if absent the
     application that handles the 'http' URI scheme is used.
     Complaints and help to improve support are gladly taken
     at $(i,%%PKG_ISSUES%%/1)."
  in
  let docv = "CMD" in
  Arg.(value & opt browser None & info ["b"; "browser"] ~env ~doc ~docv)

let prefix =
  let doc = "Reload the first browser tab which has the URI as a prefix
             (rather than the exact URI)."
  in
  Arg.(value & flag & info ["p"; "prefix"] ~doc)

let background =
  let doc = "Reload URI but keep the browser application in the background."in
  Arg.(value & flag & info ["g"; "background"] ~doc)
