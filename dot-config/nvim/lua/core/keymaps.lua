----------------------------------------------------------------------
-- Util
----------------------------------------------------------------------

-- mapleader = " " and maplocalleader = " " are set in init.lua

-- For elsewhere...
-- vim.tbl_contains({t}, {value}, {opts})

-- "leader" map. Use vim.keymap.set if other options than desc are needed.
local function lmap(key, command, desc)
  vim.keymap.set("n", "<leader>" .. key, command, { desc = desc })
end

-- Command
local function cmap(key, command, desc)
  vim.keymap.set("n", key, "<Cmd>" .. command .. "<Enter>", { desc = desc })
end

-- Leader command
local function lcmap(key, command, desc)
  vim.keymap.set(
    "n",
    "<leader>" .. key,
    "<Cmd>" .. command .. "<Enter>",
    { desc = desc }
  )
end

----------------------------------------------------------------------
-- Basic keybindings
----------------------------------------------------------------------
cmap("<Esc>", "nohlsearch")
-- A way to escape _down_ from auto comma or semicolon.
vim.keymap.set("i", "<C-o>", "<Esc>o", { silent = true })
vim.keymap.set("i", "<C-S-O>", "<Esc>O", { silent = true })
vim.keymap.set("i", "<C-Enter>", "<Esc>o", { silent = true })

-- Remap for dealing with word wrap
-- stylua: ignore start
vim.keymap.set( "n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set( "n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set( "n", "gk", "v:count == 0 ? 'k' : 'k'", { expr = true, silent = true })
vim.keymap.set( "n", "gj", "v:count == 0 ? 'j' : 'j'", { expr = true, silent = true })
-- stylua: ignore end

-- Simpler way to paste last *yanked* think (ignoring deletes)
-- Does overwrite default command, which pastes and puts cursor after, but
-- whatever
vim.keymap.set("n", "gp", '"0p', { desc = "[P]aste last yank", silent = true })

----------------------------------------------------------------------
-- Global LSP bindings
----------------------------------------------------------------------

-- Diagnostic keymaps
-- vim.keymap.set(
lmap(
  "pd",
  function() vim.diagnostic.jump({ count = -1, float = true }) end,
  "[P]revious [D]iagnostic"
)
lmap(
  "nd",
  function() vim.diagnostic.jump({ count = 1, float = true }) end,
  "[N]ext [D]iagnostic"
)

lmap("e", vim.diagnostic.open_float, "[E]rror messages")
lmap("qf", vim.diagnostic.setloclist, "[Q]uick[f]ix list")

-- LSP-commands (see :help vim.lsp.buf)
lmap("ca", vim.lsp.buf.code_action)
lmap("rn", vim.lsp.buf.rename)
-- lmap("rf", vim.lsp.buf.rename)

lmap("gd", vim.lsp.buf.definition)
lmap("gD", vim.lsp.buf.declaration)
lmap("K", vim.lsp.buf.hover) -- KK to focus hover window

-- Open Oil easy
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Switch buffers quickly
-- vim.keymap.set("n", "<leader>n", vim.cmd.bnext)
-- vim.keymap.set("n", "<leader>p", vim.cmd.bprev)
-- Floating terminal
-- vim.keymap.set("n", "tt", "<cmd>Floaterminal<cr>", { desc = "[T]oggle [T]erminal" })

vim.keymap.set("n", "g<cr>", "i<cr><esc>", { desc = "Insert new line" })

----------------------------------------------------------------------
-- Window mappings
----------------------------------------------------------------------
lmap("wj", "<C-W>j", "[W]indow down")
lmap("wk", "<C-W>k", "[W]indow up")
lmap("wh", "<C-W>h", "[W]indow left")
lmap("wl", "<C-W>l", "[W]indow right")
lcmap("ww", "w", "[W]rite")
lcmap("qq", "q", "[Q]uit")
lcmap("wq", "wq", "[W]rite and [Q]uit")
lmap("wp", vim.cmd.bprev, "[P]revious Buffer")
lmap("wn", vim.cmd.bnext, "[N]ext Buffer")
lmap("m", "@@", "Last [M]acro")

-- FIX: Idk why this is here
vim.lsp.get_clients()
