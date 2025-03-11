-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
-- local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
-- local rep = require("luasnip.extras").rep
return {
  s(
    "shell-template",
    fmta(
      [[
{
  pkgs ? import <<nixpkgs>> { },
}:
pkgs.mkShell {
  # buildInputs is for dependencies you'd need "at run time",
  # were you to to use nix-build not nix-shell and build whatever you were working on
  buildInputs = with pkgs; [
    <>
    # (import ./my-expression.nix { inherit pkgs; })
  ];
  # Environmentvariables to set
  env = {
  };

  # Shell scripts
  # e.g. export SOME_VAR="some value"
  shellHook = ''
  '';
}
  ]],
      { i(1) }
    ),
    {}
  ),
}
