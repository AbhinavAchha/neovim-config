return {
	"folke/todo-comments.nvim",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = true,
		sign_priority = 8,
		keywords = {
			FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
			TODO = { icon = " ", color = "info", alt = { "TODO", "TASK" } },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = "󰅒 ", color = "hint", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			SAFETY = { icon = " ", color = "error", alt = { "UNSAFE" } },
		},
		highlight = {
			before = "",
			keyword = "wide_bg",
			after = "fg",
			comments_only = true,
		},
	},
	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next todo comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Prev todo comment",
		},
		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
	},
}
