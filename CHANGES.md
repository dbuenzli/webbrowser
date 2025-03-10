
*Warning* This library is maintained but no longer developed.  Similar
functionality can be found in the libraries of [`b0`] (and its
`show-url` tool).

- Require OCaml >= 4.08.
- Install libraries in their own directories.
- Handle `cmdliner` deprecations.
- Drop direct dependency on `astring`, `rresult`
- `cmdliner` is no longer a depopt. This ensure that depending on
  `webbrowser` installs the `browse(1)` tool. You can still use the
  library without depending on it
  
v0.6.1 2016-09-14 Zagreb
------------------------

`browse(1)` command line tool: convert existing file paths
specified on the cli to file:// URIs.

v0.6.0 2016-08-08 Zagreb
-------------------------

First release. 
