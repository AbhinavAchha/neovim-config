return {
	"github/copilot.vim",
	lazy = false,

	config = function()
		vim.g.copilot_no_tab_map = true

		vim.keymap.set("i", "<C-l>", function()
			return vim.fn["copilot#Accept"]("")
		end, { expr = true, silent = true, replace_keycodes = false })
	end,

	keys = {
		{ "<c-p>", "<cmd>Copilot panel<cr>", desc = "Open Copilot Panel" },
		{ "<c-c>", "<cmd>Copilot toggle<cr>", desc = "Toggle Copilot" },
		-- {
		-- 	"<c-l>",
		-- 	function()
		-- 		return vim.fn["copilot#Accept"]()
		-- 	end,
		-- 	mode = "i",
		-- 	desc = "Accept Copilot Suggestion",
		-- 	expr = true,
		-- 	noremap = true,
		-- },
		{ "<c-;>", "copilot#Next()", mode = "i", desc = "Next Copilot Suggestion", expr = true, noremap = true },
		{
			"<c-,>",
			"copilot#Previous()",
			mode = "i",
			desc = "Previous Copilot Suggestion",
			expr = true,
			noremap = true,
		},
		{ "<c-x>", "copilot#Clear()", mode = "i", desc = "Clear Copilot Suggestion", expr = true, noremap = true },
	},
}
