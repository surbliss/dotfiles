return {},
-- Autosnippets
{
  s("codd", { t({ "```", "" }), i(1), t({ "", "```", "" }), i(0) }),
  s("mm", fmta("$<>$", { i(1) })),
  s("ml", fmta("$<>$, ", { i(1) })), -- Math list
}
