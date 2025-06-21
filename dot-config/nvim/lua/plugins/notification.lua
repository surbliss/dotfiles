return {
   "j-hui/fidget.nvim",
   opts = {
      notification = {
         configs = {
            treesitter = {
               name = "treesitter",
               icon = "",
               info_annote = "",
               priority = 1,
               ttl = 5,
            },
         },

         window = {
            winblend = 30,
         },
      },
   },
   -- init = function()
   --    -- Disable fidget if nomodifiable is set globally
   --    if not vim.o.modifiable then return false end
   -- end,
}
