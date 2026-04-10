return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#2a273f',
				base01 = '#2a273f',
				base02 = '#8d8c8f',
				base03 = '#8d8c8f',
				base04 = '#2e2d2f',
				base05 = '#faf8fd',
				base06 = '#faf8fd',
				base07 = '#faf8fd',
				base08 = '#ca6578',
				base09 = '#ca6578',
				base0A = '#a286c2',
				base0B = '#53b96b',
				base0C = '#cbbddb',
				base0D = '#a286c2',
				base0E = '#f2e8ff',
				base0F = '#f2e8ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#8d8c8f',
				fg = '#faf8fd',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#a286c2',
				fg = '#2a273f',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#8d8c8f' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#cbbddb', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#f2e8ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#a286c2',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#a286c2',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#cbbddb',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#53b96b',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#2e2d2f' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#2e2d2f' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#8d8c8f',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
