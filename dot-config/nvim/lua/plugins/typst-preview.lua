return {
   "chomosuke/typst-preview.nvim",
   ft = "typst",
   version = "1.*",
   opts = {
      get_main_file = function() return "main.typ" end,
      open_cmd = "zen --new-window %s",
   }, -- lazy.nvim will implicitly calls `setup {}`
   keys = {
      {
         "<leader>ts",
         "<cmd>TypstPreviewToggle<cr>",
         desc = "[T]ypst [S]how Preview",
      },
      {
         "<leader>tc",
         "<cmd>TypstPreviewSyncCursor<cr>",
         desc = "[T]ypst [C]ursor",
      },
   },
}
