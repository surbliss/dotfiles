-- TODO: Can move this into "opts"
local config = function()
	local api = require("nvim-tree.api")

	local function edit_or_open()
		local node = api.tree.get_node_under_cursor()

		if node.nodes ~= nil then
			-- expand or collapse folder
			api.node.open.edit()
		else
			-- open file
			api.node.open.edit()
			-- Close the tree if file was opened
			api.tree.close()
		end
	end

	-- open as vsplit on current node
	local function vsplit_preview()
		local node = api.tree.get_node_under_cursor()

		if node.nodes ~= nil then
			-- expand or collapse folder
			api.node.open.edit()
		else
			-- open file as vsplit
			api.node.open.vertical()
		end

		-- Finally refocus on tree if it was lost
		api.tree.focus()
	end

	local function my_on_attach(bufnr)
		local function opts(desc)
			return {
				desc = "nvim-tree: " .. desc,
				buffer = bufnr,
				noremap = true,
				silent = true,
				nowait = true,
			}
		end

		-- default mappings
		api.config.mappings.default_on_attach(bufnr)

		-- on_attach
		vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
		vim.keymap.set("n", "<cr>", edit_or_open, opts("Edit Or Open"))
		vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
		vim.keymap.set("n", "h", api.tree.close, opts("Close"))
		vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
	end

	-- global
	vim.api.nvim_set_keymap(
		"n",
		"<C-h>",
		":NvimTreeToggle<cr>",
		{ silent = true, noremap = true, desc = "Filetree Toggle" }
	)
	vim.keymap.set("n", "<leader>ft", ":NvimTreeToggle<CR>", { desc = "[F]ile [T]ree" })
	require("nvim-tree").setup({
		on_attach = my_on_attach,
	})
	-- on_attach
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = config,
}
