let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell
  {
    shellHook = builtins.readFile ./pg-nix;
    buildInputs = [ pkgs.postgresql ];
  }
