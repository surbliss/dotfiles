return {}, {
  s({ trig = "h1t", descr = "H1 tag" }, fmt("<h1>{}</h1>", { i(1) })),
  s({ trig = "pt", descr = "Paragraph tag" }, fmt("<p>{}</p>", { i(1) })),
  -- s({ trig = "imt", descr = "Image tag", condition = conds.line_begin }, fmt('<img src = "{{}}">{}</h1>', { i(1) })),
}
