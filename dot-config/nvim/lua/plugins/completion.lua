return {
  {
    "L3MON4D3/LuaSnip",
    -- opts = {
    --   enable_autosnippets = true,
    --   store_selection_keys = "<Tab>",
    --   update_events = "TextChanged, TextChangedI",
    -- },
    config = function()
      local luasnip = require("luasnip")

      vim.keymap.set(
        "n",
        "<Leader>L",
        -- "<Cmd>lua require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/luasnippets/'})<CR>"
        -- To quickly reload snippets, without having to run home-manager switch.
        "<Cmd>lua require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/snippets/'})<CR>"
      )

      luasnip.config.setup({
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
        update_events = "TextChanged,TextChangedI",
      })
      require("luasnip.loaders.from_lua").load({ paths = { "./snippets/" } })

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        luasnip.jump(1)
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        luasnip.jump(-1)
      end, { silent = true })
    end,
  },

  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = { preset = "super-tab" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      cmdline = { enabled = false },

      completion = {
        -- menu = { border = "rounded" },
        -- documentation = { window = { border = "double" } },
        documentation = { auto_show = true, auto_show_delay_ms = 50 },
      },

      signature = {
        enabled = true,
        trigger = {
          enabled = true,
        },
      },
      -- signature = { window = { border = "single" } },
      -- Disable commandline completions
      --
      fuzzy = {
        implementation = "lua",
      },

      snippets = {
        preset = "luasnip",
        -- expand = function(snippet)
        --   require("luasnip").lsp_expand(snippet)
        -- end,
        -- active = function(filter)
        --   if filter and filter.direction then
        --     return require("luasnip").jumpable(filter.direction)
        --   end
        --   return require("luasnip").in_snippet()
        -- end,
        -- jump = function(direction)
        --   require("luasnip").jump(direction)
        -- end,
      },
      sources = {
        default = function(ctx)
          local success, node = pcall(vim.treesitter.get_node)
          if vim.bo.filetype == "lua" then
            return { "lsp", "path", "snippets" }
          elseif success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
            return { "buffer", "snippets" }
          else
            return { "lsp", "path", "snippets" }
          end
        end,
      },
      -- cmdline = {
      --   sources = {},
      -- },
    },
    signature = { enabled = true },
    opts_extend = { "sources.default" },
  },
}
