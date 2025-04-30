local filetypes = {
  "bib",
  "gitcommit",
  "markdown",
  "org",
  "plaintex",
  "rst",
  "rnoweb",
  "tex",
  "pandoc",
  "quarto",
  "rmd",
  "context",
  "html",
  "xhtml",
  "mail",
  "text",
}

return {
  cmd = { "ltex-ls" },
  filetypes = filetypes,
  single_file_support = true,
  -- get_language_id = get_language_id,
  settings = {
    ltex = {
      -- Pr file changes: https://valentjn.github.io/ltex/advanced-usage.html#magic-comments
      language = "en-US",
    },
  },
}
