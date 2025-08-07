return {
   {
      "metalelf0/jellybeans-nvim",
      dependencies = {
         "rktjmp/lush.nvim",
      },
      lazy = false,
      enabled = true,
      priority = 1000,
      init = function() vim.cmd.colorscheme("jellybeans-nvim") end,
   },
   {
      "catppuccin/nvim",
      enabled = false,
      lazy = false,
      priority = 1000,
      config = function() vim.cmd.colorscheme("catppuccin-mocha") end,
   },
   {
      "rebelot/kanagawa.nvim",
      lazy = false,
      enabled = false,
      priority = 1000,
      init = function() vim.cmd("colorscheme kanagawa") end,
   },

   {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      enabled = false,
      opts = {},
      init = function() vim.cmd("colorscheme tokyonight-night") end,
   },
}
