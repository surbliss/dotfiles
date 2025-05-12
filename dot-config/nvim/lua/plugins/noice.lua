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
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
