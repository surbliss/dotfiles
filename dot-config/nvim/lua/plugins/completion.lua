return {
   {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      opts = {
         enable_autosnippets = true,
         -- store_selection_keys = "<Tab>",
         -- update_events = "TextChanged, TextChangedI",
         -- TODO: Set snip_env for global abbreviations in snippets
         region_check_events = { "InsertEnter" },
         delete_check_events = { "TextChanged", "InsertLeave" },
      },
      config = function(_, opts)
         local ls = require("luasnip")
         ls.config.setup(opts)
         require("luasnip.loaders.from_lua").load {
            paths = { vim.fn.stdpath("config") .. "/snippets" },
         }
         -- vim.keymap.set({ "i", "s" }, "<C-E>", function()
         --   if ls.choice_active() then ls.change_choice(1) end
         -- end, { silent = true })
         vim.keymap.set({ "i", "s" }, "<C-E>", function()
            if ls.choice_active() then
               ls.change_choice(1)
            end
         end, { silent = true })
         -- FIX: Should maybe be set in blink config
         -- vim.keymap.set(
         --   { "i" },
         --   "<C-y>",
         --   function() ls.expand() end,
         --   { silent = true }
         -- )
         -- vim.keymap.set(
         --   { "i", "s" },
         --   "<C-n>",
         --   function() ls.jump(1) end,
         --   { silent = true }
         -- )
         -- vim.keymap.set(
         --   { "i", "s" },
         --   "<C-e>",
         --   function() ls.jump(-1) end,
         --   { silent = true }
         -- )
         -- vim.keymap.set({ "i", "s" }, "<C-l>", function()
         --   if ls.choice_active() then ls.change_choice(1) end
         -- end, { silent = true })

         -- vim.keymap.set(
         --   { "i", "s" },
         --   "<C-l>",
         --   function() ls.jump(1) end,
         --   { silent = true }
         -- )
         -- vim.keymap.set(
         --   { "i", "s" },
         --   "<C-h>",
         --   function() ls.jump(-1) end,
         --   { silent = true }
         -- )
      end,
      keys = {
         {
            "<leader>L",
            function()
               require("luasnip.loaders.from_lua").load {
                  paths = "~/.config/nvim/snippets/",
               }
            end,
            { desc = "[L]oad snippets" },
         },
      },
   },
   {
      "saghen/blink.cmp",
      version = "*",
      build = "nix run .#build-plugin",
      dependencies = { "L3MON4D3/LuaSnip" },
      opts = {
         keymap = {
            preset = "none",
            ["<C-space>"] = {
               "show",
               "show_documentation",
               "hide_documentation",
            },
            ["<C-i>"] = { "show_signature", "hide_signature", "fallback" },
            ["<C-y>"] = { "select_and_accept", "fallback" },

            ["<Enter>"] = {
               "accept",
               "fallback",
            },
            -- ["<C-Enter>"] = {
            --    function(cmp)
            --       -- Probably needs more checks here, if I wan't to use snippets that
            --       -- require newlines...
            --       if cmp.snippet_active() then
            --          cmp.snippet_forward()
            --          vim.schedule(function() vim.api.nvim_input("<Enter>") end)
            --          return true
            --       else
            --          return false
            --       end
            --    end,
            --    "fallback",
            -- },
            -- ["<Enter>"] = { "accept", "fallback" },
            ["<C-c>"] = { "cancel", "fallback" },
            -- ["<Esc>"] = {
            --   function(cmp)
            --     if cmp.is_visible() then
            --       cmp.cancel()
            --       vim.cmd("stopinsert")
            --       -- vim.api.nvim_feedkeys(
            --       --   vim.api.nvim_replace_termcodes("<C-c>", true, true, true),
            --       --   "n",
            --       --   true
            --       -- )
            --       return true
            --     else
            --       return false
            --     end
            --   end,
            --   "fallback",
            -- },
            --
            -- ["<Up>"] = { "select_prev", "fallback" },
            -- ["<Down>"] = { "select_next", "fallback" },

            ["<Tab>"] = {
               -- function(cmp)
               --   if cmp.snippet_active() then
               --     cmp.snippet_forward()
               --     return true
               --   else
               --     return false
               --   end
               -- end,
               "snippet_forward",
               "fallback",
            }, -- somehow blink overwrote tab
            ["<S-Tab>"] = {
               function(cmp)
                  if cmp.snippet_active() then
                     cmp.snippet_backward()
                     return true
                  else
                     return false
                  end
               end,
               "fallback",
            }, -- somehow blink overwrote tab
            ["<C-k>"] = {
               "select_prev",
               "fallback_to_mappings", -- ignores default bindings
            },
            ["<C-j>"] = {
               "show_and_insert",
               -- "snippet_forward",
               -- "select_and_accept",
               "select_next",
               -- "show_and_insert",
               "fallback_to_mappings",
            },
            -- FIX: Seemed to open a different menu?
            -- Just allow using them, for now
            ["<C-p>"] = {
               "select_prev",
               "show_and_insert",
               "fallback",
            },
            ["<C-n>"] = {
               "select_next",
               "show_and_insert",
               "fallback",
            },

            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },

            ["<C-l>"] = {
               "select_and_accept",
               "snippet_forward",
               "fallback_to_mappings",
            },
            ["<C-h>"] = {
               "cancel",
               "snippet_backward",
               "fallback_to_mappings",
            },
            ["<C-m>"] = { "cancel", "fallback" },

            -- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
         },
         appearance = {
            -- use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
         },
         completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 0 },
            list = { selection = { preselect = false, auto_insert = false } },
            -- ghost_text = {
            --   enabled = true,
            --   show_with_menu = false,
            -- },
            -- menu = {
            --   auto_show = false,
            -- },
         },

         cmdline = { enabled = false },

         signature = {
            enabled = true,
            trigger = { enabled = true },
            window = {
               show_documentation = false,
            },
         },
         fuzzy = { implementation = "prefer_rust_with_warning" },

         snippets = { preset = "luasnip" },
         -- sources = { default = { "lsp", "buffer", "path", "snippets" } },
         sources = {
            default = { "lsp", "path", "snippets" },
            -- FIX: NOt correct naming (if option even exists)
            -- providers = {
            --   snippets = {
            --     opts = {
            --       show_auto_snippets = false,
            --     },
            --   },
            -- },
         },
         --     default = function(_)
         --       local success, node = pcall(vim.treesitter.get_node)
         --       if vim.bo.filetype == "lua" then
         --         return { "lsp", "path", "snippets" }
         --       elseif
         --         success
         --         and node
         --         and vim.tbl_contains(
         --           { "comment", "line_comment", "block_comment" },
         --           node:type()
         --         )
         --       then
         --         return { "buffer", "snippets" }
         --       else
         --         return { "lsp", "path", "snippets" }
         --       end
         --     end,
         --   },
      },
      -- signature = { enabled = true },
      opts_extend = { "sources.default" },
   },
}
