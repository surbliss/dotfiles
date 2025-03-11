require("core.options")
require("core.keymaps")
require("core.commands")
require("core.floaterminal")
require("core.lsp")

-- Source file
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
-- Execute 1 line
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
-- Execute visual selection
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
-- Put lazy.nvim into the runtimepath for neovim (so require sources plugins)
vim.opt.runtimepath:prepend(lazypath)

-- Make sure to set leader before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- NOTE: Only sources files directly in 'lua/plugins' folder, so the
    -- 'lua/plugins/plugin-configs' folder will not be imported
    { import = "plugins" },
  },
  change_detection = {
    notify = false,
  },
})
