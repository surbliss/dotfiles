return {
  enabled = false,
  "OleJoik/squeel.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local squeel = require("squeel")
    squeel.setup()

    vim.keymap.set("n", "<leader>fo", function()
      -- optionally pass a buffer id to the format function
      squeel.format()
    end)
  end,
}
