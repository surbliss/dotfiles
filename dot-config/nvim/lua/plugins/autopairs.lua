return {
  "windwp/nvim-autopairs",
  opts = {
    disable_filetype = { "tex", "copilot-chat" },
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    -- local ts_conds = require("nvim-autopairs.ts-conds")
    -- local log = require("nvim-autopairs._log")
    local utils = require("nvim-autopairs.utils")

    ----------------------------------------------------------------------
    -- Nix
    ----------------------------------------------------------------------
    -- Note that when the cursor is at the end of a comment line,
    -- treesitter thinks we are in attrset_expression
    -- because the cursor is "after" the comment, even though it is on the same line.
    local is_not_ts_node_comment_one_back = function()
      return function(info)
        vim.treesitter.get_parser():parse()
        local target = vim.treesitter.get_node({ ignore_injections = false })
        if
          target ~= nil and utils.is_in_table({ "comment" }, target:type())
        then
          return false
        end

        local rest_of_line = info.line:sub(info.col)
        return rest_of_line:match("^%s*$") ~= nil
      end
    end
    npairs.add_rule(
      Rule("=", ";", "nix"):with_pair(is_not_ts_node_comment_one_back())
    )

    ----------------------------------------------------------------------
    -- Lua
    ----------------------------------------------------------------------
    local is_in_table = function()
      -- Nested function to force lazily doing treesitter parsing
      return function()
        vim.treesitter.get_parser():parse()
        local n = vim.treesitter.get_node()
        if n == nil then return false end
        return utils.is_in_table({ "table_constructor", "field" }, n:type())
      end
    end

    npairs.add_rule(Rule("=", ",", "lua"):with_pair(is_in_table()))
  end,
}
