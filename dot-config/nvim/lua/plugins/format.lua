return {
	{
		"stevearc/conform.nvim",
		event = "BufWrite",
		opts = {
			default_format_opts = {
				lsp_format = "never",
				timeout_ms = nil,
			},

			format_on_save = function(bufnr)
				local filetype = vim.bo[bufnr].filetype
				if filetype == "fsharp" or filetype == "cs" then
					return nil
				end

				return { timeout_ms = 1500 }
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				haskell = { "ormolu" },
				cs = { "csharpier", "brace_fix" },
				fsharp = { "fantomas" },
				nix = { "nixfmt" },
				python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
				tex = { "latexindent" },
				gleam = { "gleam" },
				typst = { "typstyle" },
			},

			formatters = {
				latexindent = {
					command = "latexindent",
					args = { "-m" },
				},
				csharpier = {
					command = "dotnet-csharpier",
					args = { "--write-stdout" },
				},

				ormolu = {
					prepend_args = {
						"-p",
						"Flow",
						-- -- flow fixities
						-- "--fixity",
						-- "infixl 0 |>",
						-- "--fixity",
						-- "infixl 0 !>",
						-- "--fixity",
						-- "infixr 0 <|",
						-- "--fixity",
						-- "infixr 0 <!",
						-- "--fixity",
						-- "infixl 9 .>",
						-- "--fixity",
						-- "infixr 9 <.",
					},
				},
				nixfmt = { args = { "--width=80", "--strict" } },

				-- Run after 'csharpier' to achieve K&R-style.
				brace_fix = {
					inherit = false,
					command = "perl",
					args = {
						"-0pe", -- -0 reads entire file, -p prints, -e executes the script
						-- "s/\\n\\s*\\{/ {/g",
						-- "s/\\n\\s*\\{/ {/g; s/}\\s*\\n\\s*else/} else/g",
						-- GPT Try
						[[s/\n\s*{\s*(?=\n|\s*$)/ {/g; s/}\s*\n\s*else/} else/g]],
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
					env = {
						UNCRUSTIFY_CONFIG = vim.fn.expand("~/.config/uncrustify/uncrustify.cfg"),
					},
				},
			},
		},
		keys = {
			{
				"<leader>ff",
				function()
					-- print(string.format("Current filetype: %s", vim.bo.filetype))
					-- print(vim.inspect(conform.list_formatters()))
					print("Formatting...")
					require("conform").format({ timeout_ms = 10000 })
					vim.cmd("write")
					print("Code formatted!")
				end,
				desc = "[F]ormat document",
			},
		},
	},
}
