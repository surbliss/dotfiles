-- Plugins that don't require separate files, for one reason or another
return {
  ----------------------------------------------------------------------
  -- Synatx highlighting
  ----------------------------------------------------------------------
  "Treeniks/isabelle-syn.nvim",

  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function() vim.cmd.colorscheme("catppuccin-mocha") end,
  },

  "LnL7/vim-nix",

  -- Dunno if this is needed, hmm
  -- "nvim-dap"

  -- neodev alternative
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  "kmonad/kmonad-vim",

  "tpope/vim-repeat",

  -- {
  --   "ggandor/leap.nvim",
  --   config = function()
  --     require("leap").create_default_mappings()
  --     require("leap.user").set_repeat_keys("<enter>", "<backspace>")
  --     vim.keymap.set("n", "s", "<Plug>(leap)")
  --     vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
  --     vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap-forward)")
  --     vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
  --   end,
  -- },

  {
    "stevearc/oil.nvim",
    opts = {
      delete_to_trash = true,
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
      },
    },
  },

  -- "plenary-nvim"

  {
    -- NOTE: Possible commands: NOTE, FIX, TODO, HACK, WARN, PERF & TEST.
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup()
      vim.keymap.set(
        "n",
        "]t",
        function()
          require("todo-comments").jump_next({
            keywords = { "TODO", "HACK", "WARN", "FIX", "PERF" },
          })
        end,
        { desc = "Next error/warning todo comment" }
      )
      vim.keymap.set(
        "n",
        "[t",
        function()
          require("todo-comments").jump_prev({
            keywords = { "TODO", "HACK", "WARN", "FIX", "PERF" },
          })
        end,
        { desc = "Next error/warning todo comment" }
      )
    end,
  },

  -- { "mrcjkb/haskell-tools.nvim", version = "^4", lazy = false },

  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },

  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  {
    -- "norcalli/nvim-colorizer.lua", -- Uses deprecated tbl_flatten
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      --   user_default_options = { names = false },
    },
  },

  "BeneCollyridam/futhark-vim",

  {
    "numToStr/FTerm.nvim",
    enabled = false,
    opts = {
      border = "rounded",
    },
    config = function(_, opts)
      local fterm = require("FTerm")
      fterm.setup(opts)
      vim.keymap.set("n", "<leader>tt", fterm.toggle)
      vim.keymap.set("t", "<leader>tt", fterm.toggle)
      -- vim.keymap.set("n", "<leader>g", function()
      --   fterm.run("lazygit")
      -- end)
    end,
  },

  {
    -- nvim v0.8.0
    "kdheepak/lazygit.nvim",
    enabled = false,
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      {
        "<leader>sl",
        function() require("telescope").extensions.lazygit.lazygit() end,
        desc = "[S]earch [L]azyGit",
      },
    },
    config = function() require("telescope").load_extension("lazygit") end,
  },

  ----------------------------------------------------------------------
  -- Graveyard
  ----------------------------------------------------------------------
  {
    "kylechui/nvim-surround",
    -- enabled = false,
    event = "VeryLazy",
    opts = {},
  },
}
