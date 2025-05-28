return {},
-- Autosnippets
{
  s(
    "codd",
    fmta(
      [[
      ```
      <>
      ```
      ]],
      { i(1) }
    )
  ),
  s("mm", fmta("$<>$ ", { i(1) })),
  s("ml", fmta("$<>$, ", { i(1) })), -- Math list
  s("rw", fmta("`<>` ", { i(1) })),
  s("mrw", fmta("#`<>`", { i(1) })), -- Math raw
}
