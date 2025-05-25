return {
  -- Using the registry for inputs
  s(
    "flake-template",
    fmta(
      [[
{
  description = "A flake for <>";
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "<>";
      shell = ./shell.nix;
      # config = {};
      # overlay = overlay.nix;
    };
}]],
      { i(1), i(1) }
    )
  ),

  s(
    "shell-template",
    fmta(
      [[
{ pkgs }:
let
  packages = with pkgs; [ ];
in
pkgs.mkShell {
  name = "<>";
  inherit packages;
  # env = {};
  shellHook = ''
      echo "Hello <>!"
    '';
}]],
      { i(1), i(1) }
    )
  ),
}, {}
