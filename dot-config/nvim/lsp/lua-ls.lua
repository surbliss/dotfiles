return {
  -- This gets passed to vim.lsp.config('lua_ls', ...)
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      -- runtime = {
      --   version = "LuaJIT",
      -- },
      workspace = {
        checkThirdparty = false,
        -- https://github.com/neovim/neovim/discussions/24119
        -- library = {
        --   vim.env.VIMRUNTIME,
        -- }
        -- Didnt work
        -- library = vim.api.nvim_get_runtime_file("", true),
        -- library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
  filetypes = { "lua" },
}
