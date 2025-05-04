return {
  {
    "L3MON4D3/LuaSnip",
    opts = {
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
      update_events = "TextChanged, TextChangedI",
      -- TODO: Set snip_env for global abbreviations in snippets
    },
    config = function(_, opts)
      local luasnip = require("luasnip")
      luasnip.config.setup(opts)
      require("luasnip.loaders.from_lua").load({ paths = { "./snippets/" } })
      -- FIX: Should maybe be set in blink config
      vim.keymap.set(
        { "i", "s" },
        "<C-l>",
        function() luasnip.jump(1) end,
        { silent = true }
      )
      vim.keymap.set(
        { "i", "s" },
        "<C-j>",
        function() luasnip.jump(-1) end,
        { silent = true }
      )
    end,
    keys = {
      {
        "<leader>L",
        function()
          require("luasnip.loaders.from_lua").load({
            paths = "~/.config/nvim/snippets/",
          })
        end,
      },
    },
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
        documentation = { auto_show = true, auto_show_delay_ms = 50 },
      },

      signature = {
        enabled = true,
        trigger = {
          enabled = true,
        },
      },
      fuzzy = {
        implementation = "lua",
      },

      snippets = {
        preset = "luasnip",
      },
      sources = {
        default = function(_)
          local success, node = pcall(vim.treesitter.get_node)
          if vim.bo.filetype == "lua" then
            return { "lsp", "path", "snippets" }
          elseif
            success
            and node
            and vim.tbl_contains(
              { "comment", "line_comment", "block_comment" },
              node:type()
            )
          then
            return { "buffer", "snippets" }
          else
            return { "lsp", "path", "snippets" }
          end
        end,
      },
    },
    signature = { enabled = true },
    opts_extend = { "sources.default" },
  },
}
