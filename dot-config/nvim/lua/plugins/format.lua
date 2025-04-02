return {
  {
    "stevearc/conform.nvim",
    opts = {
      default_format_opts = {
        lsp_format = "never",
        timeout_ms = nil,
      },

      format_on_save = {
        timeout_ms = 1500,
        -- lsp_format = "fallback",
      },
      -- default_format_opts = {
      -- lsp_format = "fallback",
      formatters_by_ft = {
        lua = { "stylua" },
        haskell = { "fourmolu" },
        -- cs = { "csharpier" }, -- Respects '.editorconfig' file, sooo
        -- cs = { "clang-format" }, -- Now I have a '.clang-format' file
        -- cs = { "astyle" },
        -- cs = { "uncrustify" }, -- Happy with this one!
        -- cs = { "dotnet csharpier", "astyle" },
        -- cs = { "csharpier", "astyle", "brace_fix" },
        cs = { "csharpier", "brace_fix" },
        fsharp = { "fantomas" },
        nix = { "nixfmt" },
        python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
        tex = { "latexindent" },
      },
    },
    config = function(_, opts)
      local conform = require("conform")
      conform.setup(opts)
      conform.formatters = {
        latexindent = {
          command = "latexindent",
          -- args = { "--overwrite", "-m" },
          args = { "-m" },
        },
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },

        nixfmt = { args = { "--width=80", "--strict" } },

        -- Run after 'csharpier' to achieve K&R-style.
        brace_fix = {
          inherit = false,
          command = "perl",
          args = {
            "-0pe", -- -0 reads entire file, -p prints, -e executes the script
            -- "s/\\n\\s*\\{/ {/g",
            "s/\\n\\s*\\{/ {/g; s/}\\s*\\n\\s*else/} else/g",
          },
          stdin = true,
        },

        -- Astyle for elses
        astyle = {
          args = {
            "--style=java", -- K&R style (braces on same line)
            "--indent=spaces=4", -- 4 spaces indentation (per guide)
            "--suffix=none", -- No backup
          },
        },

        uncrustify = {
          -- args = {
          --   "-c ~/.config/uncrustify/uncrustify.cfg"
          -- }
          env = {
            UNCRUSTIFY_CONFIG = vim.fn.expand("~/.config/uncrustify/uncrustify.cfg"),
          },
        },
      }
      vim.keymap.set("n", "<leader>ff", function()
        -- print(string.format("Current filetype: %s", vim.bo.filetype))
        -- print(vim.inspect(conform.list_formatters()))
        print("Formatting...")
        conform.format({ async = true })
        print("Code formatted!")
      end, { desc = "[F]ormat document" })
    end,
  },
}
