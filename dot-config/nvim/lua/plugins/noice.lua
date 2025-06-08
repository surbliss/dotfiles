return {
   "folke/noice.nvim",
   -- Produces lsp-spam sometimes...
   enabled = false,
   event = "VeryLazy",

   opts = {
      cmdline = {
         enabled = true,
      },
      messages = {
         enabled = false,
      },
      popupmenu = {
         enabled = false,
      },
      notify = {
         enabled = false,
      },
   },
   -- dependencies = {
   --   "MunifTanjim/nui.nvim",
   -- },
}
