-- For filetypes with paragraph text, not comments
return {
  cmd = { "harper-ls", "--stdio" },
  settings = {
    ["harper-ls"] = {
      linters = {
        SpellCheck = true,
        SentenceCapitalization = true,
      },
    },
  },
  filetypes = {
    "gitcommit",
    "html",
    "markdown",
    "typst",
  },
}
