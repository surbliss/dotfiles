return {
  "rcarriga/nvim-notify",
  lazy = false,
  opts = {},
  config = function(opts)
    vim.notify = vim.schedule_wrap(require("notify"))
    vim.opt.termguicolors = true
  end,
}
