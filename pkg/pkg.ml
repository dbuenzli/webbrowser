#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let () =
  Pkg.describe "webbrowser" @@ fun c ->
  Ok [ Pkg.mllib "src/webbrowser.mllib";
       Pkg.mllib "src/webbrowser_cli.mllib";
       Pkg.bin "test/browse"; ]
