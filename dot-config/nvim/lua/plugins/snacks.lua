return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	--@type snacks.Config
	opts = {
		lazygit = { enabled = true },
		scratch = { enabled = true },
	},

	keys = {
    -- stylua: ignore start
    { "<leader>lg", function() Snacks.lazygit.open() end },
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
		-- stylua: ignore end
	},
}
