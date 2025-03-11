return {
  -- This gets passed to vim.lsp.config('lua_ls', ...)
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      workspace = { checkThirdparty = false },
      telemetry = { enable = false },
    },
  },
  filetypes = { "lua" },
}
