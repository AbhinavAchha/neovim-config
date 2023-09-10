return {
	"github/copilot.vim",
	init = function()
		vim.g.copilot_no_tab_map = true
		vim.g.copilot_assume_mapped = true
		-- vim.g.copilot_tab_fallback = ""

		vim.cmd([[imap <silent><script><expr> <C-L> copilot#Accept()]])
		vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#b2b2bb" })
	end,
}
