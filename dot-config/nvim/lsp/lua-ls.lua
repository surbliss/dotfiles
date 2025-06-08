return {
   -- This gets passed to vim.lsp.config('lua_ls', ...)
   cmd = { "lua-language-server" },
   settings = {
      Lua = {
         runtime = {
            version = "LuaJIT",
         },
         workspace = {
            checkThirdparty = false,

            -- Maybe this should only be done for neovim, but atm that is all I'm
            -- using lua for, sooo
            library = {
               vim.env.VIMRUNTIME,
            },
         },
         telemetry = { enable = false },
      },
   },
   filetypes = { "lua" },
}
