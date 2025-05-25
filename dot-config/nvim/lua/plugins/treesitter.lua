return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-refactor",
  },
  opts = {
    auto_install = true,
    ignore_install = { "latex" },
    -- ensure_installed = { "norg" },
    highlight = {
      enable = true,
      disable = { "latex" },
    },
    -- },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        -- Defaults
        -- init_selection = "gnn",
        -- node_incremental = "grn",
        -- scope_incremental = "grc",
        -- node_decremental = "grm",

        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<m-space>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        -- automatically jump forward to textobj, see targets.vim
        lookahead = true,
        keymaps = {
          -- you can use the capture groups defined in textobjects.scm
          ["af"] = { query = "@function.outer", desc = "[a]round [f]unction" },
          ["if"] = { query = "@function.inner", desc = "[i]nner [f]unction" },
          -- [a/i]p is taken for "paragraph".
          ["aa"] = {
            query = "@parameter.outer",
            desc = "[a]round [a]rgument",
          },
          ["ia"] = { query = "@parameter.inner", desc = "[i]nner [a]rgument" },
          -- fucks up vimtex commands!
          ["ac"] = {
            query = "@class.outer",
            disable = function(lang, bufnr) return lang == "latex" end,
          },
          ["ic"] = {
            query = "@class.inner",
            disable = function(lang, bufnr) return lang == "latex" end,
          },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["][]"] = "@function.outer",
          ["]m"] = "@class.outer",
        },
        goto_next_end = {
          ["]]"] = "@function.outer",
          ["]M"] = "@class.outer",
        },
        goto_previous_start = {
          ["[["] = "@function.outer",
          ["[m"] = "@class.outer",
        },
        goto_previous_end = {
          ["[]"] = "@function.outer",
          ["[M"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader> >"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader> <"] = "@parameter.inner",
        },
      },
      lsp_interop = {
        enable = true,
        border = "none",
        floating_preview_opts = {},
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
    },
    refactor = {
      highlight_definitions = {
        -- enable = true,
        enable = false,
        -- Set to false if you have an `updatetime` of ~100.
        clear_on_cursor_move = true,
      },
      -- highlight_current_scope = { enable = true },
      smart_rename = {
        enable = true,
        -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
        keymaps = {
          smart_rename = "<leader>rn",
        },
      },
    },
  },
  config = function(_, opts)
    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1449
    require("nvim-treesitter.install").compilers = { "gcc" }
    require("nvim-treesitter.configs").setup(opts)
    vim.treesitter.language.register("bash", "zsh")
    -- local function printnode()
    --   local node = vim.treesitter.get_node()
    --   if node == nil then
    --     print(node)
    --   else
    --     print(node:type())
    --   end
    -- end

    -- local function printprevnode()
    --   local pos = vim.api.nvim_win_get_cursor(0) -- Pos is (1,0)-indexed
    --   local row, col = pos[1], pos[2]
    --   node = vim.treesitter.get_node({ pos = { row - 1, col - 2 } })
    --   if node == nil then
    --     print(node)
    --   else
    --     print(node:type())
    --   end
    -- end
    -- For debugging, uncomment only when needed
    -- vim.keymap.set("n", "<leader>tp", printprevnode)
    -- vim.keymap.set("n", "<leader>tt", printnode)
    -- vim.keymap.set("i", "<C-.>", printnode)
    -- vim.keymap.set("i", "<C-,>", printprevnode)
    -- require("nvim-treesitter.parsers").filetype_to_parsername.zsh = "bash"
  end,
  build = ":TSUpdate",
}
