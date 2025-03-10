(*---------------------------------------------------------------------------
   Copyright (c) 2016 Daniel C. Bünzli. All rights reserved.
   SPDX-License-Identifier: ISC
  ---------------------------------------------------------------------------*)

(** {!Cmdliner} support for {!Webbrowser}. *)

(** {1 Command line options} *)

open Bos

val browser : Cmd.t option Cmdliner.Term.t
(** A [--browser] option and [BROWSER] environment variable to
    use with the [browser] argument of {!Webbrowser.reload}. *)

val prefix : bool Cmdliner.Term.t
(** A [--prefix] option to use with the [prefix] argument of
    {!Webbrowser.reload}. *)

val background : bool Cmdliner.Term.t
(** A [--background] option to use with [background] argument of
    {!Webbrowser.reload}. *)
