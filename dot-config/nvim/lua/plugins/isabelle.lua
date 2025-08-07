return {
   "Treeniks/isabelle-syn.nvim",
   {
      "Treeniks/isabelle-lsp.nvim",
      branch = "isabelle-language-server",
      dependencies = {
         "neovim/nvim-lspconfig",
      },
      -- opts = {},
      config = function()
         require("isabelle-lsp").setup {}
         vim.lsp.enable("isabelle")
      end,
   },
}
