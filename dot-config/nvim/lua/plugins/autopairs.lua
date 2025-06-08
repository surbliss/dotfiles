return {
   "windwp/nvim-autopairs",
   opts = {
      disable_filetype = { "tex", "copilot-chat" },
   },
   config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local ts_conds = require("nvim-autopairs.ts-conds")
      -- local is_nodes = require("nvim-autopairs.ts-conds").is_ts_node
      -- local is_not_nodes = require("nvim-autopairs.ts-conds").is_not_ts_node
      -- local ts_utils = require("nvim-autopairs.ts-utils")
      local ts_utils = require("nvim-treesitter.ts_utils")
      -- local log = require("nvim-autopairs._log")
      local utils = require("nvim-autopairs.utils")
      local cond = require("nvim-autopairs.conds")
      local set = require("utils.lua").set
      local is_nodes = require("utils.lua").is_ts_nodes

      ----------------------------------------------------------------------
      -- Nix
      ----------------------------------------------------------------------
      -- Note that when the cursor is at the end of a comment line,
      -- treesitter thinks we are in attrset_expression
      -- because the cursor is "after" the comment, even though it is on the same line.
      local is_not_ts_node_comment_one_back = function()
         return function(info)
            vim.treesitter.get_parser():parse()
            local target = vim.treesitter.get_node { ignore_injections = false }
            if
               target ~= nil and utils.is_in_table({ "comment" }, target:type())
            then
               return false
            end

            local rest_of_line = info.line:sub(info.col)
            return rest_of_line:match("^%s*$") ~= nil
         end
      end

      local is_bind_and_not_comment = function()
         -- Helper to check multiple values
         local binds = set { "binding_set", "attrset_expression" }
         local node = vim.treesitter.get_node()
         -- Check if node is an aqual binding
         if
            not is_nodes(node, {
               "binding_set",
               "attrset_expression",
               "identifier",
            })
         then
            return false
         end
         -- Check node one cursor-pos back (otherwise treesitter doesn't notice
         -- comments)
         local pos = vim.api.nvim_win_get_cursor(0) -- Pos is (1,0)-indexed
         local row, col = pos[1] - 1, math.max(pos[2] - 1, 0)
         node = vim.treesitter.get_node { pos = { row, col } }
         -- BUG: For now, writing "#=" produces "#=;", but adding a space fixes
         return not is_nodes(node, "comment")
      end

      npairs.add_rule(
         Rule("=", " ;", "nix")
            :with_pair(is_bind_and_not_comment)
            :set_end_pair_length(1)
      )

      ----------------------------------------------------------------------
      -- Lua
      ----------------------------------------------------------------------
      -- local is_in_table = function()
      --   -- Nested function to force lazily doing treesitter parsing
      --   return function()
      --     vim.treesitter.get_parser():parse()
      --     local n = vim.treesitter.get_node()
      --     print(n)
      --     if n == nil then return false end
      --     print(n:type())
      --     return utils.is_in_table(
      --       { "table_constructor", "field", "value" },
      --       n:type()
      --     )
      --   end
      -- end

      -- npairs.add_rules {
      --    Rule("=", ",", "lua"):with_pair(
      --       ts_conds.is_ts_node { "table_constructor", "field", "value" }
      --    ),
      -- }
      -- npairs.get_rule('""'):replace_endpair(function() return '",' end)
   end,
}
