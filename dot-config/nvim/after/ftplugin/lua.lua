vim.opt.shiftwidth = 2
vim.opt.formatoptions:remove("o")

----------------------------------------------------------------------
-- Insert header above content
----------------------------------------------------------------------
local header_seq = "O<Esc>70i-<Esc>o--<Esc>o<Esc>70i-<Esc>kA<Space>"
vim.keymap.set("n", "<leader>ih", header_seq, { desc = "[I]nsert [H]eader" })
