return {
  "folke/noice.nvim",
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
    -- TODO: Take a look at lsp-settings
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
