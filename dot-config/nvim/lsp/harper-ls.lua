-- Make sure filetypes don't overlap with 'text-harper-ls'!
return {
	-- This gets passed to vim.lsp.config('lua_ls', ...)
	cmd = { "harper-ls", "--stdio" },
	settings = {
		["harper-ls"] = {
			linters = {
				-- Underscore, despite being 'SpellCheck' in documentation...
				-- spell_check = false,
				-- Nvm, from an older version
				SpellCheck = false,
				SentenceCapitalization = false,
				ToDoHyphen = false,
				-- See https://github.com/Automattic/harper/blob/66bffd0d65f67488b83517892645ea19c9715663/harper-core/src/linting/spaces.rs#L6
				Spaces = false,
			},
		},
	},
	filetypes = {
		"c",
		"cpp",
		"cs",
		"go",
		"java",
		"javascript",
		"lua",
		"nix",
		"python",
		"ruby",
		"rust",
		"swift",
		"toml",
		"typescript",
		"typescriptreact",
		"haskell",
		"cmake",
		-- "typst",
		"php",
		"dart",
	},
}
