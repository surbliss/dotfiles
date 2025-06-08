local fidget = require("fidget")
local function tsnotify(text, opts)
   opts = opts or {}
   opts.group = "treesitter"
   fidget.notify(text, vim.log.levels.INFO, opts)
end

local function printnode()
   fidget.notification.clear("treesitter")
   local node = vim.treesitter.get_node()
   tsnotify(node and node:type() or "Treesitter node not found")
end

local function printtree()
   fidget.notification.clear("treesitter")
   local i = 1
   local node = vim.treesitter.get_node()
   while node do
      tsnotify(node:type(), { annote = i })
      node = node:parent()
      i = i + 1
   end
end

local function printprevnode()
   fidget.notification.clear("treesitter")
   local pos = vim.api.nvim_win_get_cursor(0) -- Pos is (1,0)-indexed
   local row, col = pos[1], pos[2]
   col = math.max(col - 1, 0)
   row = row - 1
   local node = vim.treesitter.get_node { pos = { row, col } }
   tsnotify(node and node:type())
end

return {
   "nvim-treesitter/nvim-treesitter",
   dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-refactor",
      "j-hui/fidget.nvim", -- For debugging
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
               ["af"] = {
                  query = "@function.outer",
                  desc = "[a]round [f]unction",
               },
               ["if"] = {
                  query = "@function.inner",
                  desc = "[i]nner [f]unction",
               },
               -- [a/i]p is taken for "paragraph".
               ["aa"] = {
                  query = "@parameter.outer",
                  desc = "[a]round [a]rgument",
               },
               ["ia"] = {
                  query = "@parameter.inner",
                  desc = "[i]nner [a]rgument",
               },
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
               ["<leader><leader>l"] = "@parameter.inner",
            },
            swap_previous = {
               ["<leader><leader>h"] = "@parameter.inner",
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
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
         },
         highlight_current_scope = { enable = true },
         smart_rename = {
            enable = true,
            -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
            keymaps = {
               smart_rename = "<leader>rn",
            },
         },
      },
   },
   lazy = false,
   -- config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
   main = "nvim-treesitter.configs",
   keys = {
      -- Debug mappings, useful when making luasnippets
      { "<C-.>", printnode, mode = { "n", "i" } },
      { "<C-,>", printprevnode, mode = { "n", "i" } },
      { "<C-'>", printtree, mode = { "n", "i" } },
   },
   build = ":TSUpdate",
}
-- NOTE: Potential issues:
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1449
-- require("nvim-treesitter.install").compilers = { "gcc" }
