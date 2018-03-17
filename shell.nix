let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell
  {
    shellHook = builtins.readFile ./pg-shell;
    buildInputs = [ pkgs.postgresql ];
  }
