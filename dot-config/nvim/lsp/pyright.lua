return {
  cmd = { "pyright-langserver", "--stdio" },
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
  },
  filetypes = { "python" },
}
