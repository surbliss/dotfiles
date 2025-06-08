-- Server-specific configuration in nvim/lsp/ folder
local lsp_servers = {
  "lua-ls",
  "ltex-ls-plus",
  "pyright",
  "ruff",
  "nixd",
  "hls",
  "futhark-lsp",
  -- "clangd",
  "harper-ls",
  -- "text-harper-ls",
  "gleam-lsp",
  "fsautocomplete",
  "tinymist",
  "ty",
  -- "pylyzer",
}

-- Enable all lsp servers (make *sure* to define cmd and filetypes for all
-- configurations.)
vim.lsp.config("*", {
  root_markers = { ".git" },
  single_file_support = true,
})
vim.lsp.enable(lsp_servers)

-- Disble annoying ltex notificatoins
vim.diagnostic.update_in_insert = false
vim.diagnostic.config({
  -- signs = {  },
  severity_sort = true,
  -- priority = 999
  update_in_insert = false, -- false so diags are updated on InsertLeave
  -- virtual_text = { current_line = true, severity = { min = "INFO", max = "WARN" } },
  -- virtual_lines = { current_line = true, severity = { min = "ERROR" } },
  underline = { severity = { min = "WARN" } },
  -- Severities: HINT, INFO, WARN and ERROR
  -- virtual_text = { current_line = true },
  virtual_text = { current_line = false, severity = { min = "ERROR" } },
  virtual_lines = { current_line = true, severity = { min = "ERROR" } },
  -- severity_sort = true,
  -- vim.keymap.set("n", "<leader>vl", function()
  --   vim.diagnostic.config({
  --     virtual_lines = not vim.diagnostic.config().virtual_lines,
  --     virtual_text = not vim.diagnostic.config().virtual_text,
  --   })
  -- end, { desc = "Toggle diagnostic virtual lines and virtual text" }),
})
