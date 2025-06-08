return {}, {
  s({ trig = "bb", descr = "Braces" }, fmta("{<>}", { i(1) })),
  s({ trig = "vv", descr = "Var assignment", condition = conds.line_begin }, fmt("var {} = {};", { i(1), i(2) })),
  s("funn", fmt("{}({});", { i(1, "name"), i(2) })),
}
