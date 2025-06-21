--- Checks if current expression should be appended with a comma, e.g.
--- {x = ...,} or { "....", }
local function comma_if_field()
  local node = vim.treesitter.get_node()
  while node do
    local ntype = node:type()
    if ntype == "block" or ntype == "arguments" then return "" end
    if ntype == "table_constructor" then return ", " end
    node = node:parent()
  end
  return ""
end

return {
  s(
    {
      trig = "snippet",
      descr = "Standard snippet",
      condition = conds.line_begin,
    },
    -- fmta('s(<>, <>("<>", {<>}))', {
    fmta("s(<>, <>),", {
      -- i(1, "Trigger"),
      c(1, {
        sn(nil, { t '"', r(1, "trig"), t '"' }),
        fmta('{ trig = "<>", descr = "<>"}', { r(1, "trig"), r(2, "descr") }),
        fmta('{ trig = "<>", descr = "<>", condition = <>}', { r(1, "trig"), r(2, "descr"), i(3, "conds.line_begin") }),
      }),
      c(2, {
        fmta('fmta("<>", {<>})', { r(1, "expan"), r(2, "nodes") }),
        fmta('fmt("<>", {<>})', { r(1, "expan"), r(2, "nodes") }),
        fmta("fmta([[<>]], {<>})", { r(1, "expan"), r(2, "nodes") }),
        fmta("fmt([[<>]], {<>})", { r(1, "expan"), r(2, "nodes") }),
      }, { restore_cursor = true }),
    }, {
      stored = {
        ["trig"] = i(1, "Trigger"),
        ["descr"] = i(1, "Description"),
        ["expan"] = i(1, "Expansion"),
        ["nodes"] = i(1, "i(1)"),
      },
    })
  ),
},
----------------------------------------------------------------------
-- AUTO_SNIPPETS
----------------------------------------------------------------------
{
  s({ trig = "ss", descr = "String in table" }, fmt('"{}"{}', { i(1), p(comma_if_field) })),
  s({ trig = "tt", descr = "Table" }, fmta("{<>}", { i(1) })),
  s(
    { trig = "ett", descr = "= Table" },
    fmta("= {<>}<>", { i(1), p(comma_if_field) }),
    { condition = conds.line_begin }
  ),
  s(
    { trig = "ess", descr = "= String" },
    fmt('= "{}"{}', { i(1), p(comma_if_field) }),
    { condition = conds.line_begin }
  ),
  s({ trig = "ee", descr = "= ..." }, fmt("= {}{}", { i(1), p(comma_if_field) })),
}
