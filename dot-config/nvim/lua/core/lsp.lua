-- Server-specific configuration in nvim/lsp/ folder

-- Global options
-- vim.lsp.config("*", {})

local lsp_servers = {
  "lua_ls",
  "ltex",
  "pyright",
  "ruff",
  "nixd",
  "hls",
  "csharp_ls",
  "futhark_lsp",
  "clangd",
}

-- Enable all lsp servers (make *sure* to define cmd and filetypes for all
-- configurations.)
vim.lsp.enable(lsp_servers)
