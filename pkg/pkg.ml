#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let () =
  Pkg.describe "webbrowser" @@ fun c ->
  Ok [ Pkg.mllib "src/webbrowser.mllib";
       Pkg.mllib "src/cli/webbrowser_cli.mllib" ~dst_dir:"cli";
       Pkg.bin "test/browse";
       Pkg.doc "doc/index.mld" ~dst:"odoc-pages/index.mld"; ]
