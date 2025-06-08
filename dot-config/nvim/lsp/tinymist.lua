-- Lsp for typst
local function create_tinymist_command(command_name, client, bufnr)
	local export_type = command_name:match("tinymist%.export(%w+)")
	local info_type = command_name:match("tinymist%.(%w+)")
	if info_type and info_type:match("^get") then
		info_type = info_type:gsub("^get", "Get")
	end
	local cmd_display = export_type or info_type
	---Execute the Tinymist command, supporting both 0.10 and 0.11 exec methods
	---@return nil
	local function run_tinymist_command()
		local arguments = { vim.api.nvim_buf_get_name(bufnr) }
		local title_str = export_type and ("Export " .. cmd_display) or cmd_display
		---@type lsp.Handler
		local function handler(err, res)
			if err then
				return vim.notify(err.code .. ": " .. err.message, vim.log.levels.ERROR)
			end
			-- If exporting, show the string result; else, show the table for inspection
			vim.notify(export_type and res or vim.inspect(res), vim.log.levels.INFO)
		end
		-- For Neovim 0.11+
		return client:exec_cmd({
			title = title_str,
			command = command_name,
			arguments = arguments,
		}, { bufnr = bufnr }, handler)
	end
	-- Construct a readable command name/desc
	local cmd_name = export_type and ("LspTinymistExport" .. cmd_display) or ("LspTinymist" .. cmd_display) ---@type string
	local cmd_desc = export_type and ("Export to " .. cmd_display) or ("Get " .. cmd_display) ---@type string
	return run_tinymist_command, cmd_name, cmd_desc
end

return {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	-- root_markers = { ".git" },
	on_attach = function(client, bufnr)
		for _, command in ipairs({
			"tinymist.exportSvg",
			"tinymist.exportPng",
			"tinymist.exportPdf",
			"tinymist.exportHtml", -- Use typst 0.13
			"tinymist.exportMarkdown",
			"tinymist.exportText",
			"tinymist.exportQuery",
			"tinymist.exportAnsiHighlight",
			"tinymist.getServerInfo",
			"tinymist.getDocumentTrace",
			"tinymist.getWorkspaceLabels",
			"tinymist.getDocumentMetrics",
		}) do
			local cmd_func, cmd_name, cmd_desc = create_tinymist_command(command, client, bufnr)
			vim.api.nvim_buf_create_user_command(0, cmd_name, cmd_func, { nargs = 0, desc = cmd_desc })
		end
		-- Automatically try to pin to main.typ
		local current_dir = vim.fn.expand("%:p:h")
		local main_file = current_dir .. "/main.typ"
		if vim.fn.filereadable(main_file) == 0 then
			vim.notify("main.typ not found", vim.log.levels.WARN)
			return
		end
		vim.cmd("badd " .. main_file)
		local main_bufnr = vim.fn.bufnr(main_file)
		client:exec_cmd({
			title = "pin",
			command = "tinymist.pinMain",
			arguments = { main_file },
		}, { bufnr = main_bufnr })
		-- end,
		-- })

		vim.keymap.set("n", "<leader>tp", function()
			client:exec_cmd({
				title = "pin",
				command = "tinymist.pinMain",
				arguments = { vim.api.nvim_buf_get_name(0) },
			}, { bufnr = bufnr })
		end, { desc = "[T]inymist [P]in", noremap = true })

		vim.keymap.set("n", "<leader>tu", function()
			client:exec_cmd({
				title = "unpin",
				command = "tinymist.pinMain",
				arguments = { vim.v.null },
			}, { bufnr = bufnr })
		end, { desc = "[T]inymist [U]npin", noremap = true })
	end,
}

-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     local current_dir = vim.fn.expand("%:h")
--     local main_file = current_dir .. "/main.typ"
--
--     if vim.fn.filereadable(main_file) == 0 then
--       print("main.typ not found")
--       return
--     end
--
--     -- Open main.typ buffer if not already open
--     vim.cmd("badd " .. main_file)
--     local main_bufnr = vim.fn.bufnr(main_file)
--
--     -- Get tinymist client and run the pin command on main.typ
--     local clients = vim.lsp.get_active_clients({ name = "tinymist" })
--     if #clients > 0 then
--       local client = clients[1]
--       client:exec_cmd({
--         title = "pin",
--         command = "tinymist.pinMain",
--         arguments = { main_file },
--       }, { bufnr = main_bufnr })
--     end
--   end,
-- })
--
-- -- function()
-- --   client:exec_cmd({
-- --     title = "pin",
-- --     command = "tinymist.pinMain",
-- --     arguments = { vim.api.nvim_buf_get_name(0) },
-- --   }, { bufnr = bufnr })
-- -- end,
