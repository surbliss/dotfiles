return {
   "m4xshen/hardtime.nvim",
   lazy = false,
   dependencies = { "MunifTanjim/nui.nvim" },
   enabled = false,
   opts = {
      max_time = 3000,
      max_count = 2,
      restricted_keys = {
         -- Defaults:
         -- ["h"] = { "n", "x" },
         -- ["j"] = { "n", "x" },
         -- ["k"] = { "n", "x" },
         -- ["l"] = { "n", "x" },
         -- ["+"] = { "n", "x" },
         -- ["gj"] = { "n", "x" },
         -- ["gk"] = { "n", "x" },
         -- ["<C-M>"] = { "n", "x" },
         -- ["<C-N>"] = { "n", "x" },
         -- ["<C-P>"] = { "n", "x" },
         ["<Up>"] = { "n", "x" },
         ["<Down>"] = { "n", "x" },
         ["<Left>"] = { "n", "x" },
         ["<Right>"] = { "n", "x" },
      },
      disabled_keys = {
         ["<Up>"] = false,
         ["<Down>"] = false,
         ["<Left>"] = false,
         ["<Right>"] = false,
      },
   },
}
