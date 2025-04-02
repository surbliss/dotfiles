-- Server-specific configuration in nvim/lsp/ folder

-- Global options
-- vim.lsp.config("*", {
--   root_markers = { ".git" },
--   single_file_support = true,
-- })

local lsp_servers = {
  "lua-ls",
  "ltex",
  "pyright",
  "ruff",
  "nixd",
  "hls",
  "futhark-lsp",
  "clangd",
  "harper-ls",
  "text-harper-ls",
}

-- Enable all lsp servers (make *sure* to define cmd and filetypes for all
-- configurations.)
vim.lsp.enable(lsp_servers)
