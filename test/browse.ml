(*---------------------------------------------------------------------------
   Copyright (c) 2016 Daniel C. Bünzli. All rights reserved.
   SPDX-License-Identifier: ISC
  ---------------------------------------------------------------------------*)

let exec = Filename.basename Sys.executable_name
let log_err f = Format.eprintf ("%s: " ^^ f ^^ "@.") exec

let urify u = (* Detects if u is simply a file path *)
  try match Sys.file_exists u with
  | false -> u
  | true ->
      let u =
        if not (Filename.is_relative u) then u else
        Filename.concat (Sys.getcwd ()) u
      in
      Format.sprintf "file://%s" u
  with Sys_error _ -> u

let browse background prefix browser uris =
  let rec loop = function
  | [] -> 0
  | uri :: uris ->
      let uri = urify uri in
      match Webbrowser.reload ~background ~prefix ?browser uri with
      | Error (`Msg e) -> log_err "%s" e; 1
      | Ok () -> loop uris
  in
  loop uris

(* Command line interface *)

open Cmdliner

let uris =
  let doc = "URI to open or reload. If URI is an existing file path
             a corresponding file:// URI is opened."
  in
  Arg.(non_empty & pos_all string [] & info [] ~doc ~docv:"URI")

let cmd =
  let doc = "Open and reload URIs in web browsers" in
  let man = [
    `S Manpage.s_description;
    `P "The $(mname) command opens or reloads URIs specified
        on the command line.";
    `S Manpage.s_bugs;
    `P "This program is distributed with the OCaml webbrowser library.
        See $(i,%%PKG_HOMEPAGE%%) for contact information."; ]
  in
  let exits =
    Cmd.Exit.info 1 ~doc:"if the URI failed to load in some way" ::
    Cmd.Exit.defaults
  in
  Cmd.v (Cmd.info "browse" ~doc ~man ~exits) @@
  Term.(const browse $ Webbrowser_cli.background $ Webbrowser_cli.prefix $
        Webbrowser_cli.browser $ uris)

let main () = Cmd.eval' cmd
let () = if !Sys.interactive then () else exit (main ())
