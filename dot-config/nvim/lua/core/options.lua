-- For nvim-filetree, disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Options ]]
-- See :help option-list
-- Must happen before plugins are required
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- No continuation of commented lines with 'o' or 'O'
-- vim.opt.formatoptions:remove("o")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function() vim.opt_local.formatoptions:remove("o") end,
  group = vim.api.nvim_create_augroup("FormatOptionsGroup", { clear = true }),
  desc = "Remove 'o' from formatoptions for all filetypes",
})

vim.opt.termguicolors = true

-- For custom functions later
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = "80"

-- Only mouse in [h]elp windows
-- Or [a]llways
vim.opt.mouse = "a"

-- statusline already shows mode
vim.opt.showmode = false

-- Copy from anywhere
vim.opt.clipboard = "unnamedplus"

-- Visual wrap keeps indentation
vim.opt.breakindent = true
vim.opt.textwidth = 80

vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Text keeps moving, if not always on
vim.opt.signcolumn = "yes"

-- vim.opt.updatetime = 250
-- For which-key
-- vim.opt.timeoutlen = 500

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "nosplit"

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.splitright = true
vim.opt.splitbelow = true

-- wrap between words
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "

-- Tabbing
vim.opt.expandtab = false -- Don't expand tabs to spaces
vim.opt.smarttab = true -- *Do* expand tabs at start of line (for indent)
vim.opt.shiftwidth = 2 -- Default space-indent (idk if 2 or 4 best)
vim.opt.tabstop = 8 -- Visual amount of spaces for TAB-characters
vim.opt.softtabstop = 8 -- Actual space inserted when pressing TAB

-- Don't keep buffer open when opening new file
vim.opt.hidden = false

-- Combined with mapping <Esc> to clear highlights
vim.opt.hlsearch = true

vim.filetype.add({
  extension = {
    ispc = "ispc",
  },
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

-- local original_validate = vim.validate
-- Hax to fix deprecation warning
-- vim.validate = function(arg1, arg2, ...)
--   if arg2 == nil and type(arg1) == "table" then
--     local key = next(arg1)
--     assert(next(arg1, key) == nil) -- Only one entry in table
--     assert(arg1[key]) -- Key has value
--     local args = arg1[key]
--     original_validate(key, args[1], args[2], args[3], args[4])
--     return
--   end
--   original_validate(arg1, arg2, ...)
-- end

-- local original_deprecate = vim.deprecate
