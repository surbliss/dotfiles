vim.opt.textwidth = 0
vim.opt.shiftwidth = 2
require("treesitter-context").disable()
-- vim.api.nvim_create_autocmd("Filetype", {
--   pattern = "nix",
--
--   callback = function()
--     print("FileType nix detected")
--     vim.cmd("TSContextDisable")
--   end,
--   -- command = "TSContextDisable",
-- })
