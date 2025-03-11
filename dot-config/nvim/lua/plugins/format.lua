return {
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = {
        timeout_ms = 1500,
        -- lsp_format = "fallback",
      },
      -- default_format_opts = {
      -- lsp_format = "fallback",
      formatters_by_ft = {
        lua = { "stylua" },
        haskell = { "fourmolu" },
        -- cs = { "csharpier" }, -- Respects .editorconfig file, sooo
        -- cs = { "clang-format" }, -- Now I have a .clang-format file
        -- cs = { "astyle" },
        cs = { "uncrustify" }, -- Happy with this one!
        fsharp = { "fantomas" },
        nix = { "nixfmt" },
        python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
      },
    },
    config = function(_, opts)
      local conform = require("conform")
      conform.setup(opts)

      conform.formatters.astyle = {
        args = {
          "--style=java", -- K&R style (braces on same line)
          "--indent=spaces=4", -- 4 spaces indentation (per guide)
          "--pad-oper", -- Space around operators
          "--pad-header", -- Space after if/while/for
          "--break-blocks", -- Empty lines around blocks
          "--delete-empty-lines", -- Remove extra empty lines
          "--align-pointer=name", -- Align pointers with variable name
          "--max-code-length=100", -- Line width limit (per guide)
          "--unpad-paren", -- Remove unnecessary spaces inside parentheses
          "--pad-comma", -- Space after commas
          "--squeeze-ws", -- Remove superfluous whitespace
          "--convert-tabs", -- Convert tabs to spaces
          "--add-braces", -- Add braces to unbraced one-line blocks
          -- "--add-one-line-braces", -- Make the added braces one-line when possible
          "--keep-one-line-blocks", -- Keep one-line blocks in one line
          -- "--keep-one-line-statements" -- Keep statements on one line
        },
      }

      conform.formatters.uncrustify = {
        -- args = {
        --   "-c ~/.config/uncrustify/uncrustify.cfg"
        -- }
        env = {
          UNCRUSTIFY_CONFIG = vim.fn.expand("~/.config/uncrustify/uncrustify.cfg"),
        },
      }

      vim.keymap.set("n", "<leader>ff", function()
        print(string.format("Current filetype: %s", vim.bo.filetype))
        print(vim.inspect(conform.list_formatters()))
        conform.format()
      end, { desc = "[F]ormat document" })
    end,
  },
}
