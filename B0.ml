open B0_kit.V000
open Result.Syntax

(* OCaml library names *)

let bos = B0_ocaml.libname "bos"
let rresult = B0_ocaml.libname "rresult"
let cmdliner = B0_ocaml.libname "cmdliner"
let webbrowser = B0_ocaml.libname "webbrowser"
let webbrowser_cli = B0_ocaml.libname "webbrowser.cli"

(* Libraries *)

let webbrowser_lib =
  B0_ocaml.lib webbrowser ~srcs:[`Dir ~/"src"] ~requires:[bos]

let webbrowser_cli_lib =
  let srcs = [`Dir ~/"src/cli"] in
  let requires = [rresult; bos; cmdliner; webbrowser] in
  B0_ocaml.lib webbrowser_cli ~srcs ~requires

(* Tools *)

let browse =
  let srcs = [`File ~/"test/browse.ml" ] in
  let requires = [bos; cmdliner; webbrowser; webbrowser_cli] in
  B0_ocaml.exe ~public:true ~srcs ~requires

(* Packs *)

let default =
  let meta =
    B0_meta.empty
    |> ~~ B0_meta.authors ["The webbrowser programmers"]
    |> ~~ B0_meta.maintainers ["Daniel Bünzli <daniel.buenzl i@erratique.ch>"]
    |> ~~ B0_meta.homepage "https://erratique.ch/software/webbbrowser"
    |> ~~ B0_meta.online_doc "https://erratique.ch/software/webbbrowser/doc/"
    |> ~~ B0_meta.licenses ["ISC"]
    |> ~~ B0_meta.repo "git+https://erratique.ch/repos/webbbrowser.git"
    |> ~~ B0_meta.issues "https://github.com/dbuenzli/webbbrowser/issues"
    |> ~~ B0_meta.description_tags
      ["web"; "http"; "url"; "browser"; "cli"; "org:erratique"]
    |> B0_meta.tag B0_opam.tag
    |> ~~ B0_opam.depends
      [ "ocaml", {|>= "4.08.0"|};
        "ocamlfind", {|build|};
        "ocamlbuild", {|build|};
        "bos", {|>= "0.2.1"|};
        "rresult", {|>= "0.7.0"|};
        "cmdliner", {|>= "1.3.0"|};
        "topkg", {|build & >= "1.0.3"|};
      ]
    |> ~~ B0_opam.build
      {|[["ocaml" "pkg/pkg.ml" "build" "--dev-pkg" "%{dev}%"]]|}
  in
  B0_pack.make "default" ~doc:"webbbrowser package" ~meta ~locked:true @@
  B0_unit.list ()
