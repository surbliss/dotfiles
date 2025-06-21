local check_node = require("utils.snippet").check_node
local line_begin = conds.line_begin
-- local ts_utils = require "nvim-treesitter.ts_utils"
local function is_math()
  return check_node {
    math = true,
    code = false,
    string = false,
  }
end
local function is_not_math() return not is_math() end

local function tag_if_math() return is_math() and "#" or "" end

local function comma_if_group()
  local in_group = check_node {
    group = true,
    content = false,
    math = false,
    block = false,
    code = false,
  }
  return in_group and ", " or ""
end

-- Math Snippet
-- NOTE: Shadows ms, if I were to use that
local function ms(trigger, nodes, opts)
  opts = opts or {}
  opts.condition = math
  opts.show_condition = math
  return s(trigger, nodes, opts)
end

return {
  -- Normal snippets
  -- TODO: Make table.header react to columns input
  s(
    "table",
    fmt(
      [[
      #table(
        columns: {},
        table.header({}),
        {}
      )
      ]],
      { i(1, "3"), i(2), i(3) }
    ),
    { condition = line_begin }
  ),
},
-- Autosnippets
{
  s(
    "codd",
    fmt(
      [[
      {}```
      {}
      ```
      ]],
      { p(tag_if_math), i(1) }
    )
  ),
  -- TODO: Make these only work in math environemnts (treesitter?)
  s("mm", fmta("$<>$", { i(1) }), { condition = is_not_math }),
  s("ml", fmta("$<>$, ", { i(1) }), { condition = is_not_math }), -- Math list
  -- s("rw", { m(1, function(arg1, arg2) return math() end, "#") }),
  s("rw", fmt("{}`{}`", { p(tag_if_math), i(1) })),

  -- s("mrw", fmta("#`<>`", { i(1) })), -- Math raw
  s({ trig = "dm", descr = "Display Math", condition = line_begin }, {
    c(1, {
      fmt("$ {} $", { r(1, "content", i(nil)) }),
      fmt(
        [[
        $ 
          {} 
        $
        ]],
        { r(1, "content") }
      ),
    }, { restore_cursor = true }),
  }),
  s({ trig = "bb", wordTrig = false }, fmta("{<>}", { i(1) }), { condition = is_math }),
  -- s({ trig = "rr", wordTrig = false }, fmta("{<>}", { i(1) }), { condition = is_math }),
  s({
    trig = "([%a]'?)(%d)",
    name = "auto subscript 1",
    regTrig = true,
    wordTrig = false,
    -- snippetType = "autosnippet",
  }, {
    f(function(_, snip) return string.format("%s_%s", snip.captures[1], snip.captures[2]) end, {}),
    i(0),
  }, { condition = is_math }),

  -- Aligned eq
  s("eqq", t "& = ", { condition = math }),
  s({ trig = "atr", descr = "Attribute in function" }, fmt("{}: {},", { i(1), i(2) })),
  s("ss", fmt('"{}"{}', { i(1), p(comma_if_group) })),
  s("pp", fmt("({})", { i(1) })),
  s("bb", fmta("{<>}", { i(1) })),
  s("cc", fmta("[<>]<>", { i(1), p(comma_if_group) })), -- Content
  s({ trig = "(%d)cc", regTrig = true, wordTrig = false }, {
    f(function(_, snip) return snip.captures[1] end),
    c(1, {
      fmta("[s.~<>]", { i(1) }),
      fmta("[Kap.~<>]", { i(1) }),
    }),
  }), -- Citation page
  s({ trig = "fnn", descr = "function" }, fmta("#<>(<>)", { i(1), i(2) })),
  s("bff", fmta("*<>*", { i(1) })),
  s("emm", fmta("_<>_", { i(1) })),
  s("nott", fmta("#text(red)[<>]", { i(1) })),
}
